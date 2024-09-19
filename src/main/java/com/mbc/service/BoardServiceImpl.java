package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.jeju.domain.BoardDTO;
import com.mbc.jeju.domain.PageDTO;
import com.mbc.jeju.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
    
    @Autowired
    private BoardMapper mapper;
    
    @Override
    public void registerBoard(BoardDTO dto) {
        mapper.insertBoard(dto);
    }

    @Override // 페이징처리
    public List<BoardDTO> listBoard(PageDTO pDto) {

        // 페이징 처리
        int totalCnt = mapper.totalCnt(pDto); // 검색어 있을경우
        pDto.setValue(totalCnt, pDto.getCntPerPage());
        
        return mapper.listBoard(pDto); 
    }

    @Override // 게시글 상세보기
    public BoardDTO viewBoard(int bid, String mode) {
        // 글 상세보이길 경우만 hitAdd 호출
        if (mode.equals("y")) {
            mapper.hitAdd(bid);
        }
        return mapper.viewBoard(bid);
    }

    @Override // 게시글 수정하기
    public void modifyBoard(BoardDTO dto) {
        mapper.updateBoard(dto);
    }

    @Override // 게시글 삭제하기
    public void removeBoard(int bid) {
        mapper.deleteBoard(bid);
    }

    @Override // 메인 페이지에 표시할 최신 공지사항 가져오기
    public List<BoardDTO> getRecentNotices(int limit) {
        return mapper.getRecentNotices(limit);
    }
}
