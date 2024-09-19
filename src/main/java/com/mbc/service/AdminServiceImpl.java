package com.mbc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.jeju.domain.AdminDTO;
import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.jeju.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper mapper;
	
	@Autowired 
	JavaMailSender mailSender;
	
	@Autowired
    private HttpServletRequest request;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	

	// 멤버 로그인 OK
	public boolean adminLogin(AdminDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession(); // 서비스계층에서 세션객체를 불러온다
		
		// 입력아이디와 일치하는 회원정보를 dto에 담아서
		AdminDTO loginDTO = mapper.adminLogin(dto);
		
		// 암호화 하기 전
		if(loginDTO != null) {				// 일치하는 아이디가 있는 경우
			String inputPw = dto.getAdminPw();	// dto.getPw() 사용자가 입력한 비번
			String dbPw = loginDTO.getAdminPw();	// loginDTO.getPw() DB에서 가져온 비번
			
			if(inputPw.equals(dbPw)) {		// 비번일치
				session.setAttribute("loginDTO", loginDTO);
				session.setAttribute("mode", "admin");
				return true;
			} else { 						// 비번 불일치
				request.setAttribute("loginErr", "pwdErr");
				return false;
			}
		}
		request.setAttribute("loginErr", "idErr");
		return false;	// 아이디 불일치
	}

	// 어드민-멤버 리스트
	@Override
	public ArrayList<MemberDTO> adMemberList() {
		return mapper.adMemberList();
	}
	
	// 어드민-멤버 삭제
	@Override
	public void adMemberDelete(int no) {
		mapper.adMemberDelete(no);
	}
	
	// 어드민-멤버 정보
	@Override 
	public MemberDTO adminMemberInfo(int no) {
		//System.out.println("멤버넘버 : "+no);
		return mapper.adminMemberInfo(no);
	}

	// 어드민-멤버 업데이트
	@Override
	public void adMemberUpdate(MemberDTO dto) {
		mapper.adMemberUpdate(dto);
	}

	// 예약 목록(admin-전체)
	@Override
	public ArrayList<ReservationDTO> reserveList() {
		return mapper.reserveList();
	}
	
	// 호텔 리스트
	@Override
	public ArrayList<HotelDTO> hotelList() {
		String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");
        
        Map<String, String> params = new HashMap<>();
        params.put("start-date", startDate);
        params.put("end-date", endDate);
        
		return mapper.hotelList(params);
	}
}
