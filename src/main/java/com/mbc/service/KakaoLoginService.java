package com.mbc.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mbc.jeju.domain.MemberDTO;

@Service
public class KakaoLoginService {

    public String getAccessToken(String code) throws Exception {
        String clientId = "20b6f1160d8bfff6964dbd006007d8f6"; // REST API 키
        String redirectUri = "http://localhost:8088/jeju/kakao/auth"; // redirect_uri는 개발자 콘솔과 일치해야 함
        String tokenUrl = "https://kauth.kakao.com/oauth/token";

        String params = "grant_type=authorization_code"
                + "&client_id=" + URLEncoder.encode(clientId, StandardCharsets.UTF_8.toString())
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8.toString())
                + "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8.toString());

        URL url = new URL(tokenUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = params.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();

        if (responseCode == 200) { // 200 OK일 때만 진행
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line.trim());
            }
            br.close();

            String response = sb.toString();

            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonResponse = mapper.readTree(response);
            String accessToken = jsonResponse.get("access_token").asText();

            return accessToken;
        } else {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            String line;
            
            while ((line = br.readLine()) != null) {
                sb.append(line.trim());
            }
            br.close();

            throw new RuntimeException("Failed to get access token. Response code: " + responseCode + ". Response: " + sb.toString());
        }
    }
    
//  public String getUserInfo(String accessToken) throws JsonMappingException, JsonProcessingException{
  public MemberDTO getUserInfo(String accessToken) throws JsonMappingException, JsonProcessingException{
      //---------- http 요청 메시지 시작 ------------
      // 헤더 생성
      HttpHeaders header = new HttpHeaders();
      // ** Bearer 다음에 공백 추가할 것
      header.add("Authorization", "Bearer " + accessToken);
      header.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

      // body 생략
      HttpEntity<LinkedMultiValueMap<String, String>> requestEntity
              = new HttpEntity<>(header);
      //---------- http 요청 메시지 끝 ------------

      RestTemplate restTemplate = new RestTemplate();

      // exchange() : 인증서버에 요청 및 응답(토큰) 받기
      ResponseEntity<String> responseEntity = restTemplate.exchange(
              // 토큰 요청 주소 설정
              "https://kapi.kakao.com/v2/user/me",
              HttpMethod.GET, // 요청방식
              requestEntity, // Http 요청 메시지
              String.class // 응답 받을 타입
      );
      
//      return responseEntity.getBody();
      
      
      // Gson 대신 Jackson 라이브러리 이용
      // ObjectMapper는 Jackson 라이브러리의 클래스로 JSON 데이터 --> Java객체로 변환, Java객체 --> JSON 데이터로 변환시 유용한 클래스
      ObjectMapper objectMapper = new ObjectMapper();
      // readValue() : JSON 문자열 --> Java객체로 변환, 
      Map<String, Object> userInfo = objectMapper.readValue(responseEntity.getBody(), new TypeReference<Map<String, Object>>(){});
      
//    ---------- 응답 JSON 객체 ---------
//    {
//        "id": 3657097611,
//        "connected_at": "2024-08-09T02:37:30Z",
//        "properties": {
//                  "nickname": "아무개"
//                 },
//        "kakao_account": {
//            "profile_nickname_needs_agreement": false,
//            "profile": {
//              "nickname": "아무개",
//              "is_default_nickname": false
//             },
//            "has_email": true,
//            "email_needs_agreement": false,
//            "is_email_valid": true,
//            "is_email_verified": true,
//            "email": "이메일주소"
//         }
//    }
      
   // 위 응답 JSON 객체에서 필요한 정보 추출
      String id = String.valueOf(userInfo.get("id"));
      Map<String, Object> kakaoAccount = (Map<String, Object>) userInfo.get("kakao_account");
      Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
      String nickname = (String) profile.get("nickname");
      String email = (String) kakaoAccount.get("email");
      
      
      // MemberDTO 객체 생성하기
      MemberDTO memberDTO = new MemberDTO();
      memberDTO.setMemberId(id);
      // 이 비번은 카카오 로그인시 실제 사용되는 비번이 아니고 계정의 형식을 유지하기 위한 용도이므로
      // id값을 그대로 사용함
      memberDTO.setMemberPw(id);
      memberDTO.setMemberName(nickname);
      memberDTO.setMemberEmail(email);
      // 전번은 필수이므로 테스트용으로 넣어줌, 
      // 카카오 로그인 API 사용시 사업자번호 등록을 하면 전번을 가져올 수 있음
      memberDTO.setMemberTel("010-1212-3434");
      memberDTO.setMemberType("common");
      
      return memberDTO;
  }    
}
