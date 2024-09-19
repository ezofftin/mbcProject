package com.mbc.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.mbc.jeju.domain.AdminDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.service.AdminService;
import com.mbc.service.ReservationService;


@Controller
public class AdminController {
   
   @Autowired 
   private AdminService service;
   
   @Autowired 
   private ReservationService reservationSvc;
   
   
   @Autowired 
   JavaMailSender mailSender;
   
   @Autowired   
   private BCryptPasswordEncoder pwEncoder;
   
   // 어드민 메인 폼으로 이동 
   @GetMapping("/adminMain.do")
   public String adminMainForm(Model model) {
      ArrayList<ReservationDTO> reserveList = reservationSvc.reserveList();

      Gson gson = new Gson();
      String reserveListJson = gson.toJson(reserveList);

      model.addAttribute("reserveListJson", reserveListJson);
       model.addAttribute("reserveList", reserveList); // 기존 데이터도 전달
      
      return "/admin/ad_main";
   }
   
   // 어드민 로그인 폼으로 이동 
   @GetMapping("/adminLogin.do")
   public String adminLoginForm(HttpSession session) {
		// 로그인 아이디 초기화
		session.invalidate();
		return "/admin/ad_login";
   }
   
   
   @PostMapping("/adminLoginOk.do")
   public String adminLogin(AdminDTO dto, HttpServletRequest request) {
      boolean result = service.adminLogin(dto, request);
      
      if(!result) {       
         return "admin/ad_login";
      }
//      return "/admin/ad_main";
      return "redirect:/adminMain.do";
   }
   
   // 어드민 로그아웃 - Get방식
   @GetMapping("/adminLogout.do")
   public String adminLogout(HttpSession session) {
      session.invalidate();   // 세션초기화
      return "/admin/ad_main";
   }
   
   // 어드민-멤버리스트 이동 및 띄우기
   @RequestMapping("/adminMemberList.do")
   public String adMemberList(Model model) {
      ArrayList<MemberDTO> adMemberList = service.adMemberList();
      model.addAttribute("list", adMemberList);
      return "/admin/admember_list";
   }

   // 어드민-멤버 리스트에서 삭제OK
   @RequestMapping("/adminMemberDelete.do")
   public String adMemberDelete(int no, RedirectAttributes redirectAttributes) {
      service.adMemberDelete(no);  // cnt는 값을가지고 추가로 어떠한 작업을 하고 싶을때 추가(유효성검사 등)
      redirectAttributes.addFlashAttribute("msg", "멤버 삭제완료!!");
      return "redirect:adminMemberList.do";
   }
   
   // 어드민-멤버 정보 폼으로 가기 (info)
   @RequestMapping("/adminMemberUpdate.do") // Model model은 바인딩
   public String adminMemberInfo(int no, String find, Model model) {      
      MemberDTO dto = service.adminMemberInfo(no);
      model.addAttribute("dto", dto);
      model.addAttribute("find", find); // find는 회원정보 수정인지 비밀번호 변경인지 구분해주는 것을 바인딩해서 뷰에서 뷰로 넘겨줌
      return "/admin/admember_update";
   }
   
   // 어드민-멤버 정보에서 수정OK 이동
   @RequestMapping("/adminMemberUpdateOk.do")
   public String adMemberUpdate(MemberDTO dto, RedirectAttributes redirectAttributes) {
      if(dto.getMemberId() == null || dto.getMemberPw() == null || 
               dto.getMemberId().trim().equals("") || dto.getMemberPw().trim().equals("")) {
         redirectAttributes.addFlashAttribute("msg", "멤버정보 수정실패!!");
           return "redirect:adminMemberList.do";
       }

      service.adMemberUpdate(dto);
      redirectAttributes.addFlashAttribute("msg", "멤버정보 수정완료!!");
      return "redirect:adminMemberList.do";
   }

}
