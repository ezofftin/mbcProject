package com.mbc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.jeju.domain.HotelDTO;
import com.mbc.service.AdminService;
import com.mbc.service.HotelService;

@Controller
public class ThingstodoController {
	@Autowired
	private HotelService service;
	
	@Autowired
	private AdminService adminservice;
	
	// thingstodo 리스트
	@GetMapping("/thingstodoList.do")
	public String adminMainForm() {
		return "/thingstodo/thingstodoList";
	}
	
	// 카카오맵 위치검색 연결
    @GetMapping("/kakaoMap")
    public String kakaomap(){
        return "/thingstodo/kakaoMap";
    }
}
