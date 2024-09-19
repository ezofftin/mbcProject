package com.mbc.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.PackageDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.jeju.mapper.PackageMapper;
import com.mbc.jeju.util.PackageType;

@Service
public class PackageServiceImpl implements PackageService {
	
	@Autowired
	private PackageMapper mapper;

	// admin @@@@@@@@@@@@@@@@@@@@@@@@@@
	// 핫딜 등록
	@Override
	public void insertPackage(Map map) {
		mapper.insertPackage(map);
	}

	// 핫딜 리스트 보기
	@Override
	public ArrayList<PackageDTO> packageList() {
		return mapper.packageList();
	}

	// 핫딜 삭제
	@Override
	public void deletePackage(int packageNum) {
		mapper.deletePackage(packageNum);
	}

	// 핫딜 정보 보기s
	@Override
	public PackageDTO modifyPackage(int packageNum) {
		return mapper.modifyPackage(packageNum);
	}

	// 핫딜 상품 수정 Ok
	@Override
	public void updatePackage(Map map) {
		mapper.updatePackage(map);
	}

	// user @@@@@@@@@@@@@@@@@@@@@@@@@@
	// 특정 packageType에 따른 패키지 리스트
	@Override
	public ArrayList<PackageDTO> getPackByType(String packageType) {
		return mapper.getPackByType(packageType);
	}

	// package 정보 띄우기
	@Override
	public PackageDTO getPackage(int packageNum) {
		return mapper.getPackage(packageNum);
	}

	@Override
	public void reservePackage(ReservationDTO dto) {
		mapper.reservePackage(dto);
	}



}
