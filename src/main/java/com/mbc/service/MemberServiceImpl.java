package com.mbc.service;

import java.util.ArrayList;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
    
    // MemberMapper는 MyBatis를 사용하여 데이터베이스와 상호작용하는 매퍼입니다.
    @Autowired
    private MemberMapper mapper;
    
    // JavaMailSender는 이메일을 전송하기 위해 사용됩니다.
    @Autowired
    private JavaMailSender mailSender;
    
    // BCryptPasswordEncoder는 비밀번호 암호화를 위해 사용됩니다.
    @Autowired
    private BCryptPasswordEncoder pwEncoder;
    
    // 회원 등록 메서드
    @Override
    public void memberInsert(MemberDTO dto) {
        // 입력된 비밀번호를 암호화한 후 DTO에 다시 설정
        String inputPw = dto.getMemberPw();
        String chiperPw = pwEncoder.encode(inputPw);
        dto.setMemberPw(chiperPw);
        
        // 데이터베이스에 회원 정보를 삽입
        mapper.memberInsert(dto);
    }

    // ID 중복 체크 메서드
    @Override
    public MemberDTO memberIdCheck(String uid) {
        // 입력된 ID로 데이터베이스에서 회원 정보를 조회
        return mapper.memberIdCheck(uid);
    }

    // 전화번호 중복 체크 메서드
    @Override
    public MemberDTO memberTelCheck(String utel) {
        // 입력된 전화번호로 데이터베이스에서 회원 정보를 조회
        return mapper.memberTelCheck(utel);
    }
    
    // 회원 목록 조회 메서드
    @Override
    public ArrayList<MemberDTO> memberList() {
        // 모든 회원 정보를 데이터베이스에서 가져와 리스트로 반환
        return mapper.memberList(); 
    }

    // 회원 삭제 메서드
    @Override
    public void memberDelete(int no) {
        // 회원 번호를 기준으로 데이터베이스에서 해당 회원 정보를 삭제
        mapper.memberDelete(no);
    }

    // 특정 회원 정보 조회 메서드
    @Override
    public MemberDTO memberInfo(int no) {
        // 회원 번호를 기준으로 데이터베이스에서 해당 회원 정보를 조회
        return mapper.memberInfo(no);
    }

    // 회원 정보 수정 메서드
    @Override
    public void memberUpdate(MemberDTO dto) {
        // DTO에 담긴 회원 정보를 데이터베이스에서 업데이트
        mapper.memberUpdate(dto);
    }

    // 로그인 처리 메서드
    @Override
    public boolean memberLogin(MemberDTO dto, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 세션 객체를 가져옴
        HttpSession session = request.getSession();
        
        // 입력된 ID로 데이터베이스에서 회원 정보를 조회
        MemberDTO loginDTO = mapper.memberLogin(dto);

        if (loginDTO != null) {
            // 입력된 비밀번호와 데이터베이스에 저장된 비밀번호를 비교
            String inputPw = dto.getMemberPw();
            String dbPw = loginDTO.getMemberPw();
            
            // 비밀번호가 일치하는 경우 로그인 성공
            if (pwEncoder.matches(inputPw, dbPw) || inputPw.equals(dbPw)) {
                session.setAttribute("loginDTO", loginDTO);
                session.setAttribute("mode", "user");
                return true;
            } else {
                // 비밀번호가 일치하지 않는 경우
                redirectAttributes.addFlashAttribute("loginErr", "pwdErr");
                return false;
            }
        }
        // ID가 일치하지 않는 경우
        redirectAttributes.addFlashAttribute("loginErr", "idErr");
        return false;
    }

    // ID 찾기 메서드
    @Override
    public String findId(MemberDTO dto) {
        // 이름과 전화번호로 데이터베이스에서 ID를 조회
        String findId = mapper.findId(dto);
        System.out.println("##findId: " + findId);
        return findId;
    }

    // 비밀번호 찾기 메서드
    @Override
    public int findPw(String uid, String uEmail, MemberDTO dto) {
        // 임시 비밀번호 생성 및 암호화
        String tempPw = UUID.randomUUID().toString().substring(0, 8);
        String chiperPw = pwEncoder.encode(tempPw);
        dto.setMemberPw(chiperPw);
        
        // 이메일로 임시 비밀번호 전송
        MimeMessage mail = mailSender.createMimeMessage();
        String mailContents = "<h3>임시 비밀번호 발급</h3><br/>"
                + "<h2>" + tempPw + "</h2>"
                + "<p>임시 비밀번호가 발급되었습니다. 로그인 이후에 비밀번호를 재설정 해주세요.</p>";
                
        try {
            mail.setSubject("LINE SQUARE [임시 비밀번호]", "utf-8");
            mail.setText(mailContents, "utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
            mailSender.send(mail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        
        // 데이터베이스에서 비밀번호 업데이트
        return mapper.findPw(uid, uEmail, chiperPw);
    }

    // 비밀번호 변경 메서드
    @Override
    public int modifyPw(MemberDTO dto) {
        // DTO에 담긴 회원 정보를 이용해 데이터베이스에서 비밀번호 업데이트
        return mapper.updatePw(dto);
    }

    // 이름과 이메일로 ID 찾기 메서드
    @Override
    public MemberDTO findIdByNameAndEmail(String uName, String uEmail) {
        // 이름과 이메일을 기준으로 데이터베이스에서 ID를 조회
        return mapper.findIdByNameAndEmail(uName, uEmail);
    }
    

}
