package com.mbc.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.AdminDTO;
import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.ReservationDTO;

@Service
public interface AdminService {

	// 멤버 로그인 OK
	boolean adminLogin(AdminDTO dto, HttpServletRequest request);

	// 어드민에서 멤버리스트 이동 및 띄우기
	ArrayList<MemberDTO> adMemberList();

	// 어드민에서 멤버 삭제하기
	void adMemberDelete(int no);
	
	// 어드민에서 멤버 정보보기
	MemberDTO adminMemberInfo(int no);
	
	// 어드민에서 멤버 수정하기 OK
	void adMemberUpdate(MemberDTO dto);

	// admin의 예약목록
	ArrayList<ReservationDTO> reserveList();
	// admin의 호텔목록
	ArrayList<HotelDTO> hotelList();
	
}
