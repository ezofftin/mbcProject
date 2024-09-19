package com.mbc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.service.HotelService;
import com.mbc.service.MemberService;
import com.mbc.service.ReservationService;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService service;
	
	@Autowired
	private HotelService hotelservice;

	@Autowired
	private MemberService memberservice;
	
	
// 예약 리스트
	@GetMapping("/reserveList.do")
	public String reserveList(Model model) {
		
		ArrayList<ReservationDTO> reserveList = service.reserveList();
		model.addAttribute("reserveList", reserveList);
		
		return "reservation/reserveList";
	}
	
// 예약하기 
	@GetMapping("/reserveCheck.do")
	public String reserveInput(int hotelNum, Model model) {
		ArrayList<HotelDTO> hotelList = hotelservice.hotelList();
		model.addAttribute("hotelList", hotelList);

		ArrayList<MemberDTO> memberList = memberservice.memberList();
		model.addAttribute("memberList", memberList);
		
		HotelDTO hotelDto = hotelservice.hotelInfo(hotelNum);
		model.addAttribute("hotelDto", hotelDto);
		
		
		return "reservation/reserveCheck";
	}
	// -=--------------- 예약할 때 예약이 된 날짜 확인 -------------------
	@RequestMapping("reserveCheck.do")
	public String reservedateCheck(Model model, @RequestParam("hotelNum") int hotelNum) {
		// 예약된 날짜를 서비스에서 조회
		List<String> reserveDates = service.getReserveDatesForHotel(hotelNum);
		
		// jsp에 예약된 날짜 목록을 전달
		model.addAttribute("reserveDates", reserveDates);
		System.out.println(reserveDates);
		// 호텔 정보도 전달
		HotelDTO hotelDto = hotelservice.hotelInfo(hotelNum);
		model.addAttribute("hotelDto", hotelDto);
		
		return "reservation/reserveCheck";
	}
	
	
	// -=----------------------------------
	@RequestMapping("/reserveCheckOk.do")
	public String reserveInput(int hotelNum, HttpSession session, MultipartHttpServletRequest mhr, HttpServletRequest request, ReservationDTO dto) throws IOException {
		MemberDTO memberdto = (MemberDTO)session.getAttribute("loginDTO");
		HotelDTO hoteldto = hotelservice.hotelInfo(hotelNum);
		
		dto.setMemberNum(memberdto.getMemberNum());
		dto.setHotelNum(hoteldto.getHotelNum());
		
		service.reserveInsert(dto);
		return "redirect:/myReserveList.do";
	}
	//예약 목록확인
	@GetMapping("/myReserveList.do")
//			@ResponseBody
	public String myReserveList(Model model, HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		ArrayList<MemberDTO> memberList = memberservice.memberList();
		model.addAttribute("memberList", memberList);
		
		
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		System.out.println(dto);
		int memberNum = dto.getMemberNum();
		
		MemberDTO memberDto = memberservice.memberInfo(memberNum);
		model.addAttribute("memberDto", memberDto);
		
		
		if(dto.getMemberType().equals("host")) {
			ArrayList<ReservationDTO> reserveList = service.hostReserveList(memberNum);
			model.addAttribute("myReserveList", reserveList);
			return "reservation/hostReserveList";
		} else if (dto.getMemberType().equals("common")) {
			ArrayList<ReservationDTO> reserveList = service.myReserveList(memberNum);
			model.addAttribute("myReserveList", reserveList);
			return "reservation/myReserveList";
		}else {
			redirectAttributes.addFlashAttribute("msg", "회원로그인이 필요합니다.");
			session.invalidate();	// 세션초기화
			return "redirect:login/memberLoginForm";
		}
	}
	
	// 예약 정보 확인
	@RequestMapping("/reserveInfo.do")
	public String reserveInfo(int memberNum, int hotelNum, Model model, int reserveNum, HttpSession session) {
		
		ReservationDTO reserveDto = service.reserveInfo(reserveNum);
		model.addAttribute("reserveDto", reserveDto);
		
		MemberDTO memberDto = memberservice.memberInfo(memberNum);
		model.addAttribute("memberDto", memberDto);
		
		HotelDTO hotelDto = hotelservice.hotelInfo(hotelNum);
		model.addAttribute("hotelDto", hotelDto);
		
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginDTO");
		return "reservation/reserveInfo";
	}
	
	// 예약 수정
	@RequestMapping("/reserveUpdate.do")
	public String reserveUpdate(HttpSession session,@RequestParam Map<String, Object> map,HttpServletRequest request, Model model, Integer reserveNum){
//		Map<String, Object> map = new HashMap<>();
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		Enumeration<String> enu = request.getParameterNames();
		 while (enu.hasMoreElements()) {
		        String paramName = enu.nextElement();
		        String paramValue = request.getParameter(paramName);
		        map.put(paramName, paramValue);
		    }
		System.out.println(map);
		
		service.reserveUpdate(map);
		if(dto.getMemberType().equals("common")||dto.getMemberType().equals("host")) {
			return "reservation/myReserveList";
		}else {
			return "reservation/reserveList";
		}
	}
	
	// 예약 삭제
	@RequestMapping("/reserveDelete.do")
	public String reserveDelete(int reserveNum, HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		service.reserveDelete(reserveNum);
		if(dto.getMemberType().equals("common")||dto.getMemberType().equals("host")) {
			return "redirect:/myReserveList.do";
		}else {
			return "redirect:/reserveList.do";
		}
	}
	
	// 결재페이지로
	@RequestMapping("/payment.do")
	public String reservePay(int reserveNum, int memberNum, int hotelNum, Model model) {
		ReservationDTO reserveDto = service.reserveInfo(reserveNum);
		model.addAttribute("dto", reserveDto);
		
		MemberDTO memberDto = memberservice.memberInfo(memberNum);
		model.addAttribute("mDto", memberDto);
		
		HotelDTO hotelDto = hotelservice.hotelInfo(hotelNum);
		model.addAttribute("hDto", hotelDto);
		return "reservation/payment";
	}
	
	// 결재 페이지에서 결재 버튼 눌렀을 때
	@RequestMapping("/paymentOk.do")
	public String paymentOk(int reserveNum, Model model) {
		service.paymentOk(reserveNum);
		return "redirect:/myReserveList.do";
	}
	
	@RequestMapping("/resetPayment.do")
	public String resetPayment(int reserveNum) {
		service.resetPayment(reserveNum);
		return "redirect:/myReserveList.do";
	}
	
	@RequestMapping("/hotelReview.do")
	public String hotelReview(int reserveNum, int memberNum, int hotelNum, Model model) {
		ReservationDTO reserveDto = service.reserveInfo(reserveNum);
		model.addAttribute("rDto", reserveDto);
		
		MemberDTO memberDto = memberservice.memberInfo(memberNum);
		model.addAttribute("mDto", memberDto);
		
		HotelDTO hotelDto = hotelservice.hotelInfo(hotelNum);
		model.addAttribute("hDto", hotelDto);
		
		return "reservation/reviewWrite";
	}
	
	
}
