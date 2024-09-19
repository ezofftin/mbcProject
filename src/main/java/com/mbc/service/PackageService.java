package com.mbc.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.PackageDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.jeju.util.PackageType;

@Service
public interface PackageService {

	// admin @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 핫딜 상품 등록
	void insertPackage(Map map);

	// 핫딜 리스트 보기
	ArrayList<PackageDTO> packageList();

	// 핫딜 삭제
	void deletePackage(int packageNum);

	// 핫딜 상품 수정 폼 이동
	PackageDTO modifyPackage(int packageNum);

	// 핫딜 상품 수정 Ok
	void updatePackage(Map map);


	// user @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 특정 packageType에 따른 패키지 리스트
	ArrayList<PackageDTO> getPackByType(String packageType);

	// package 상품 상세 페이지 띄우기
	PackageDTO getPackage(int packageNum);

	// 예약
	void reservePackage(ReservationDTO dto);



}
