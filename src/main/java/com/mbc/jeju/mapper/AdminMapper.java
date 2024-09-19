package com.mbc.jeju.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mbc.jeju.domain.AdminDTO;
import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.ReservationDTO;


public interface AdminMapper {
	
	// 멤버 로그인 OK
	AdminDTO adminLogin(AdminDTO dto);

	// 어드민-멤버 리스트
	ArrayList<MemberDTO> adMemberList();
	
	// 어드민-멤버 삭제
	void adMemberDelete(int no);
	
	// 어드민-멤버 조회
	MemberDTO adminMemberInfo(int no);
	
	// 어드민-멤버 수정OK
	void adMemberUpdate(MemberDTO dto);

	// 어드민-전체멤버 예약 리스트
	ArrayList<ReservationDTO> reserveList();
	
	// 호텔 리스트
	ArrayList<HotelDTO> hotelList(Map params);

}
