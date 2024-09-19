package com.mbc.service;

import java.util.ArrayList;
import com.mbc.jeju.domain.MemberDTO;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// MemberService 인터페이스는 회원 관리 기능을 정의합니다.
// 이 인터페이스를 구현하는 클래스에서 실제 비즈니스 로직을 구현합니다.
public interface MemberService {
    
    // 회원을 등록하는 메서드
    // 회원 정보를 담은 MemberDTO 객체를 입력받아 데이터베이스에 저장합니다.
    void memberInsert(MemberDTO dto);
    
    // ID 중복 체크 메서드
    // 회원 가입 시 입력된 ID가 이미 사용 중인지를 확인합니다.
    // ID가 사용 중이면 MemberDTO 객체를 반환하고, 그렇지 않으면 null을 반환합니다.
    MemberDTO memberIdCheck(String uid);
    
    // 전화번호 중복 체크 메서드
    // 회원 가입 시 입력된 전화번호가 이미 사용 중인지를 확인합니다.
    // 전화번호가 사용 중이면 MemberDTO 객체를 반환하고, 그렇지 않으면 null을 반환합니다.
    MemberDTO memberTelCheck(String utel);
    
    // 모든 회원 목록을 가져오는 메서드
    // 데이터베이스에 저장된 모든 회원 정보를 ArrayList로 반환합니다.
    ArrayList<MemberDTO> memberList();
    
    // 특정 회원을 삭제하는 메서드
    // 회원 번호를 입력받아 해당 회원을 데이터베이스에서 삭제합니다.
    void memberDelete(int memberNum);
    
    // 특정 회원의 정보를 가져오는 메서드
    // 회원 번호를 입력받아 해당 회원의 정보를 MemberDTO 객체로 반환합니다.
    MemberDTO memberInfo(int memberNum);
    
    // 회원 정보를 업데이트하는 메서드
    // 수정된 회원 정보를 담은 MemberDTO 객체를 입력받아 데이터베이스에서 업데이트합니다.
    void memberUpdate(MemberDTO dto);
    
    // 회원 로그인 처리 메서드
    // 입력된 회원 정보(dto)로 로그인 시도 후 성공 여부를 반환합니다.
    // 로그인 성공 시 세션에 회원 정보를 저장하고, 실패 시 에러 메시지를 설정합니다.
    boolean memberLogin(MemberDTO dto, HttpServletRequest request, RedirectAttributes redirectAttributes);
    
    // 회원의 ID를 찾는 메서드
    // 이름과 전화번호로 회원 ID를 찾아 반환합니다.
    String findId(MemberDTO dto);
    
    // 비밀번호 찾기 메서드
    // ID와 이메일을 입력받아 임시 비밀번호를 생성하고, 이를 암호화하여 데이터베이스에 저장합니다.
    // 임시 비밀번호는 이메일로 전송됩니다.
    int findPw(String uid, String uEmail, MemberDTO dto);
    
    // 비밀번호 수정 메서드
    // 입력된 회원 정보(dto)로 비밀번호를 수정합니다.
    int modifyPw(MemberDTO dto);

    // 이름과 이메일로 회원의 ID를 찾는 메서드
    // 이름과 이메일을 입력받아 회원의 ID를 찾고, 이를 반환합니다.
    MemberDTO findIdByNameAndEmail(String uName, String uEmail);
    


}
