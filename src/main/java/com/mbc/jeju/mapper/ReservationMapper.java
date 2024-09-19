package com.mbc.jeju.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mbc.jeju.domain.ReservationDTO;

public interface ReservationMapper {
	
	
	// -- 8/21
	ArrayList<ReservationDTO> myReserveList(int memberNum);

	ArrayList<ReservationDTO> hostReserveList(int memberNum);
	// 8/21
	ReservationDTO reserveInfo(int reserveNum);
	
	
	//
	ArrayList<ReservationDTO> reserveList();
	
	//
	void reserveInsert(ReservationDTO dto);
	
	void reserveUpdate(Map map);

	void reserveDelete(int reserveNum);

	List<String> getReserveDatesForHotel(int hotelNum);
	
	// 결재 완료
	void paymentOk(int reserveNum);

	void resetPayment(int reserveNum);
}
