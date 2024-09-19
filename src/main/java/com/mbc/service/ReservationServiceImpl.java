package com.mbc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.jeju.mapper.ReservationMapper;

@Service
public class ReservationServiceImpl implements ReservationService{
	

	@Autowired
	private ReservationMapper mapper;

	// 예약 목록(admin-전체)
	@Override
	public ArrayList<ReservationDTO> reserveList() {
		return mapper.reserveList();
	}

	// 예약하기
	@Override
	public void reserveInsert(ReservationDTO dto) {
		mapper.reserveInsert(dto);
	}

	// 예약 정보
	@Override
	public ReservationDTO reserveInfo(int reserveNum) {

		return mapper.reserveInfo(reserveNum);
	}

	
	// 예약 목록(member-내가 예약한 목록)
	@Override
	public ArrayList<ReservationDTO> myReserveList(int memberNum) {
		return mapper.myReserveList(memberNum);
	}
	
	// 예약 목록(host-내 숙소의 예약목록)
	@Override
	public ArrayList<ReservationDTO> hostReserveList(int memberNum) {
		return mapper.hostReserveList(memberNum);
	}

	// 예약 수정
	@Override
	public void reserveUpdate(Map map) {
		mapper.reserveUpdate(map);
	}

	// 예약 삭제
	@Override
	public void reserveDelete(int reserveNum) {
		mapper.reserveDelete(reserveNum);
		
	}
	
	// 예약된 날짜 불러오기
	@Override
	public List<String> getReserveDatesForHotel(int hotelNum) {
		return mapper.getReserveDatesForHotel(hotelNum);
	}

	// 결재
	@Override
	public void paymentOk(int reserveNum) {
		mapper.paymentOk(reserveNum);
		
	}

	@Override
	public void resetPayment(int reserveNum) {
		mapper.resetPayment(reserveNum);
		
	}
	
	
}
