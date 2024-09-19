package com.mbc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.mapper.HotelMapper;

@Service
@Transactional
public class HotelServiceImpl implements HotelService{
	@Autowired
	private HotelMapper mapper;
	@Autowired
    private HttpServletRequest request;
	
	// 호텔 등록
	@Override
	public void insertHotel(Map map) {
		mapper.hotelInsert(map);
		
	}
	// 호텔 수정
	@Override
	public void hotelUpdate(Map map) {
		mapper.hotelUpdate(map);
	}
	
	// 호텔 삭제
	@Override
	public void hotelDelete(int hotelNum) {
		mapper.hotelDelete(hotelNum);
	}
	
	// 호텔 리스트
	@Override
	public ArrayList<HotelDTO> hotelList() {
		String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");
        
        Map<String, String> params = new HashMap<>();
        params.put("start-date", startDate);
        params.put("end-date", endDate);
        
		return mapper.hotelList(params);
	}

	// 호텔 상세정보
	@Override
	public HotelDTO hotelInfo(int hotelNum) {
		
		
		return mapper.hotelInfo(hotelNum);
	}

}
