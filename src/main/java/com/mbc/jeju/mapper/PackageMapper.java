package com.mbc.jeju.mapper;

import java.util.ArrayList;
import java.util.Map;

import com.mbc.jeju.domain.PackageDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.jeju.util.PackageType;

public interface PackageMapper {

	// admin @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 핫딜 등록
	void insertPackage(Map map);

	// 핫딜 리스트 조회
	ArrayList<PackageDTO> packageList();

	// 핫딜 삭제
	void deletePackage(int packageNum);

	// 핫딜 정보 보기
	PackageDTO modifyPackage(int packageNum);

	// 핫딜 상품 수정 Ok
	void updatePackage(Map map);
	
	// 특정 packageType에 따른 패키지 리스트 필터링
	ArrayList<PackageDTO> getPackByType(String packageType);

	// package 상품 상세 페이지 띄우기
	PackageDTO getPackage(int packageNum);

	// 예약
	void reservePackage(ReservationDTO dto);


	
	
}
