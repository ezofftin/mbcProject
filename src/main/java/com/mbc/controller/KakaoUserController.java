package com.mbc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.jeju.domain.MemberDTO;
import com.mbc.service.KakaoLoginService;
import com.mbc.service.MemberService;

@Controller
public class KakaoUserController {

    @Autowired
    private KakaoLoginService kakaoLoginService; 
    
    @Autowired
    private MemberService memberService;
    

    // 카카오 로그인 페이지로 리다이렉트
    @GetMapping("/kakao/login")
    public String redirectKakaoLogin() {
        String clientId = "20b6f1160d8bfff6964dbd006007d8f6"; // 업데이트된 REST API 키
        String redirectUri = "http://localhost:8088/jeju/kakao/auth"; // 인증 코드가 리다이렉트될 URI
        String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize?response_type=code"
                + "&client_id=" + clientId
                + "&redirect_uri=" + redirectUri;

        System.out.println("Redirecting to Kakao login URL: " + kakaoLoginUrl);
        return "redirect:" + kakaoLoginUrl;
    }

    // 카카오 인증 코드를 처리
    @GetMapping("/kakao/auth")
//    @ResponseBody
    public String getKakaoAuthCode(@RequestParam("code") String code, HttpSession session) throws Exception {
        // 인증 코드 수신 확인
        System.out.println("Received authorization code: " + code);

        // 인증 코드로 Access Token 요청 및 로그인 처리
        String accessToken = kakaoLoginService.getAccessToken(code);        
        MemberDTO kakaoUser = kakaoLoginService.getUserInfo(accessToken);
        
        // 회원 중복 체크
        MemberDTO existingMember = memberService.memberIdCheck(kakaoUser.getMemberId());        
        
        if (existingMember == null) {
            // 회원이 존재하지 않으면 회원가입 처리
            memberService.memberInsert(kakaoUser);
            session.setAttribute("loginDTO", kakaoUser);
            session.setAttribute("mode", "user");            
        } else {
            // 회원이 존재하면 로그인 처리
            session.setAttribute("loginDTO", existingMember);
            session.setAttribute("mode", "user");            
        }
        
        // 로그인 후 메인 페이지로 리다이렉트
        return "redirect:/";
    }
}
