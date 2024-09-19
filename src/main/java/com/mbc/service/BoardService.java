package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.BoardDTO;
import com.mbc.jeju.domain.PageDTO;

@Service
public interface BoardService {
    
    // 게시글 등록 OK
    void registerBoard(BoardDTO dto);
    
    // 게시판 전체 리스트 가져오기 (조회하는게 dto랑 resultType="BoardDTO" 이 쓰임)
    List<BoardDTO> listBoard(PageDTO pDto);
    
    // 게시글 상세보기 (조회하는게 dto랑 resultType="BoardDTO" 이 쓰임)
    BoardDTO viewBoard(int bid, String mode);

    // 게시글 수정하기 OK
    void modifyBoard(BoardDTO dto);

    // 게시글 삭제하기
    void removeBoard(int bid);
    
    // 메인 페이지에 표시할 최신 공지사항 가져오기
    List<BoardDTO> getRecentNotices(int limit);
}
