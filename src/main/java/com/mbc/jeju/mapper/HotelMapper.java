package com.mbc.jeju.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mbc.jeju.domain.HotelDTO;

public interface HotelMapper {

	// 호텔 등록
	void hotelInsert(Map map);
	
	// 호텔 수정
	void hotelUpdate(Map map);
	
	// 호텔 삭제
	void hotelDelete(int hotelNum);
	
	// 호텔 리스트
	ArrayList<HotelDTO> hotelList(Map params);
	
	// 호텔 상세정보
	HotelDTO hotelInfo(int hotelNum);
	
}
