package com.mbc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.ReservationDTO;

@Service
public interface ReservationService {
	// host의 예약목록
	ArrayList<ReservationDTO> hostReserveList(int memberNum);
	// admin의 예약목록
	ArrayList<ReservationDTO> reserveList();
	// member의 예약목록
	ArrayList<ReservationDTO> myReserveList(int memberNum);

	void reserveInsert(ReservationDTO dto);
	
	// 예약 상세정보
	ReservationDTO reserveInfo(int reserveNum);
	
	void reserveUpdate(Map map);
	
	void reserveDelete(int reserveNum);
	
	List<String> getReserveDatesForHotel(int hotelNum);
	// 결재 완료하기
	void paymentOk(int reserveNum);
	// 결재 취소하기
	void resetPayment(int reserveNum);
}
