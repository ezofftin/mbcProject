package com.mbc.jeju.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mbc.jeju.domain.BoardDTO;
import com.mbc.jeju.domain.PageDTO;

public interface BoardMapper {

    // 게시글 등록
    void insertBoard(BoardDTO dto);

    // 게시판 전체 리스트 가져오기
    List<BoardDTO> listBoard(PageDTO pDto);

    // 게시글 상세보기
    BoardDTO viewBoard(int bid);

    // 게시글 수정하기
    void updateBoard(BoardDTO dto);

    // 게시글 삭제하기
    void deleteBoard(int bid);

    // 조회수 추가
    void hitAdd(int bid);

    // 전체 게시글 수 구하기
    int totalCnt(PageDTO pDto);

    // 댓글 수 업데이트
    void updateReplyCnt(@Param("bid") int bid, @Param("n") int n);

    // 메인 페이지에 표시할 최신 공지사항 가져오기
    List<BoardDTO> getRecentNotices(@Param("limit") int limit);
}
