package com.mbc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mbc.service.BoardService;
import com.mbc.jeju.domain.BoardDTO;
import com.mbc.jeju.domain.PageDTO;

@Controller
public class BoardController {

    @Autowired
    private BoardService service;

    // 게시글 등록폼 뷰  // GET
    @GetMapping("/registerBoard.do")
    public String registerBoard() {
        return "board/registerBoard";  // 게시글 등록 페이지로 이동
    }

    // 게시글 등록 처리  // POST
    @PostMapping("/registerBoard.do")
    public String registerBoard(BoardDTO dto) {
        service.registerBoard(dto);  // 게시글 등록 서비스 호출
        return "redirect:/boardList.do";  // 등록 후 게시글 목록으로 리다이렉트
    }

    // 게시글 리스트 보기 // GET, POST 모두 지원
    @RequestMapping("/boardList.do")
    public String boardList(PageDTO pDto, Model model) {
        List<BoardDTO> boardList = service.listBoard(pDto);  // 게시글 리스트 가져오기
        model.addAttribute("list", boardList);  // 게시글 리스트를 모델에 추가
        model.addAttribute("pDto", pDto);  // 페이지 정보도 모델에 추가
        return "board/boardList";  // 게시글 목록 페이지로 이동
    }

    // 게시글 상세보기 // GET
    @GetMapping("/viewBoard.do")
    public String viewBoard(int bid, PageDTO pDto, Model model) {
        BoardDTO dto = service.viewBoard(bid, "y");  // 조회수 증가 후 게시글 가져오기
        model.addAttribute("dto", dto);  // 게시글 정보 모델에 추가
        model.addAttribute("pDto", pDto);  // 페이지 정보도 모델에 추가
        return "board/notice";  // 게시글 상세보기 페이지로 이동 (notice.jsp)
    }

    // 게시글 수정 폼으로 이동 // GET
    @GetMapping("/modifyBoard.do")
    public String modifyBoard(int bid, PageDTO pDto, Model model) {
        BoardDTO dto = service.viewBoard(bid, "n");  // 조회수 증가 없이 게시글 가져오기
        model.addAttribute("dto", dto);  // 게시글 정보 모델에 추가
        model.addAttribute("pDto", pDto);  // 페이지 정보도 모델에 추가
        return "board/modifyBoard";  // 게시글 수정 페이지로 이동
    }

    // 게시글 수정 처리 // POST
    @PostMapping("/modifyBoard.do")
    public String modifyBoard(BoardDTO dto, PageDTO pDto) {
        service.modifyBoard(dto);  // 게시글 수정 처리
        return "redirect:/boardList.do?viewPage=" + pDto.getViewPage()  // 수정 후 게시글 목록으로 리다이렉트
                + "&searchType=" + pDto.getSearchType()
                + "&keyword=" + pDto.getKeyword()
                + "&cntPerPage=" + pDto.getCntPerPage();
    }

    // 게시글 삭제 // GET
    @GetMapping("/removeBoard.do")
    public String removeBoard(int bid, PageDTO pDto) {
        service.removeBoard(bid);  // 게시글 삭제 처리
        return "redirect:/boardList.do?viewPage=" + pDto.getViewPage()  // 삭제 후 게시글 목록으로 리다이렉트
                + "&searchType=" + pDto.getSearchType()
                + "&keyword=" + pDto.getKeyword()
                + "&cntPerPage=" + pDto.getCntPerPage();
    }
}
