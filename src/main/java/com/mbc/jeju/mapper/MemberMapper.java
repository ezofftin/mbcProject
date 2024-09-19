package com.mbc.jeju.mapper;

import java.util.ArrayList;
import com.mbc.jeju.domain.MemberDTO;

import org.apache.ibatis.annotations.Param;

public interface MemberMapper {
    
    // 회원 정보를 데이터베이스에 삽입 (회원가입 시 사용)
    void memberInsert(MemberDTO dto);
    
    // 입력한 ID로 회원 정보 조회 (ID 중복 체크 시 사용)
    MemberDTO memberIdCheck(String uid);
    
    // 입력한 전화번호로 회원 정보 조회 (전화번호 중복 체크 시 사용)
    MemberDTO memberTelCheck(String utel);
    
    // 모든 회원 정보를 리스트로 반환 (회원 목록 조회 시 사용)
    ArrayList<MemberDTO> memberList();
    
    // 회원 번호로 회원 삭제 (회원 탈퇴 시 사용)
    void memberDelete(int memberNum);
    
    // 회원 번호로 특정 회원 정보 조회 (회원 정보 상세 조회 시 사용)
    MemberDTO memberInfo(int memberNum);
    
    // 회원 정보 업데이트 (회원 정보 수정 시 사용)
    void memberUpdate(MemberDTO dto);
    
    // 회원 로그인 시 입력한 ID와 비밀번호로 회원 정보 조회 (로그인 시 사용)
    MemberDTO memberLogin(MemberDTO dto);
    
    // 입력한 이름과 전화번호로 회원 ID 조회 (아이디 찾기 시 사용)
    String findId(MemberDTO dto);
    
    // 입력한 ID와 이메일로 비밀번호를 업데이트 (비밀번호 찾기 시 사용)
    // MyBatis에서 여러 개의 매개변수를 사용할 때 @Param 어노테이션을 사용하여 매개변수 이름을 지정
    int findPw(@Param("uid") String uid, @Param("uEmail") String uEmail, @Param("chiperPw") String chiperPw);
    
    // 회원 비밀번호를 업데이트 (비밀번호 변경 시 사용)
    int updatePw(MemberDTO dto);

    // 입력한 이름과 이메일로 회원 ID 조회 (아이디 찾기 시 사용)
    // @Param 어노테이션을 사용하여 MyBatis XML에서 사용할 매개변수 이름을 지정
    MemberDTO findIdByNameAndEmail(@Param("uName") String uName, @Param("uEmail") String uEmail);
    


}
