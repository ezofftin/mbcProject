package com.mbc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.HotelDTO;

@Service
public interface HotelService {
	
	// 호텔 등록
	void insertHotel(Map map);
	
	// 호텔 수정
	void hotelUpdate(Map map);
	
	// 호텔 삭제
	void hotelDelete(int hotelNum);
	
	// 호텔 리스트
	ArrayList<HotelDTO> hotelList();
	
	// 호텔 상세정보
	HotelDTO hotelInfo(int hotelNum);
	
	// 호텔 리뷰 리스트 가져오기
}
