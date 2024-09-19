package com.mbc.jeju.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.jeju.domain.KakaoDTO;

@Mapper
public interface KakaoLoginMapper {
    void insertKakaoUser(KakaoDTO kakaoDTO);
    KakaoDTO findKakaoUserById(Long id);
}
