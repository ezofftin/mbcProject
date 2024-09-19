package com.mbc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.ServletContext;
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

import com.mbc.service.BoardService;
import com.mbc.service.HotelService;
import com.mbc.service.MemberService;
import com.mbc.service.ReservationService;
import com.mbc.jeju.domain.BoardDTO;
import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.PageDTO;

@Controller
public class MemberController {

    @Autowired
    private MemberService service;
    @Autowired
    private HotelService hotelservice;
    @Autowired
    private BoardService boardservice;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private BCryptPasswordEncoder pwEncoder;

    @Autowired
    private ReservationService resservice;

    // Ajax로 회원 리스트를 반환
    @RequestMapping("/memberAjaxList.do")
    @ResponseBody
    public List<MemberDTO> memberAjaxList() {
        return service.memberList();
    }

 // 홈
    @RequestMapping("/userMainForm.do")
    public String userMainForm(PageDTO pDto, HttpServletRequest request, Model model) {
       ServletContext application = request.getServletContext();
       
       // 추가하려는 DTO 연결.
       ArrayList<HotelDTO> hotelList = hotelservice.hotelList();
       application.setAttribute("hotelList", hotelList);
       
       // board DTO Main 연결 
       List<BoardDTO> boardList = boardservice.listBoard(pDto);
       model.addAttribute("noticeList", boardList);
       model.addAttribute("pDto", pDto);
       
       // 묶기
        Map map = new HashMap();
       Set key = map.keySet();
       model.addAttribute("key", key);
       model.addAttribute("map", map);
//       System.out.println("map : " + map);
//       System.out.println("hotelList = " + hotelList);
       return "home";
    }   

    // 회원가입 폼으로 이동
    @RequestMapping("/memberRegister.do")
    public String memberRegister() {
        return "member/registerMember";
    }

    // 회원가입 처리
    @RequestMapping("/memberInsert.do")
    public String memberInsert(MemberDTO dto) {
        service.memberInsert(dto);
        return "redirect:/memberLogin.do";
    }

    // ID 중복 체크
    @RequestMapping("/memberIdCheck.do")
    @ResponseBody
    public String memberIdCheck(@RequestParam("uid") String uid) {
        if (uid == null || uid.trim().isEmpty()) {
            return "no";
        }
        MemberDTO dto = service.memberIdCheck(uid);
        return (dto != null) ? "no" : "yes";
    }

    // 전화번호 중복 체크
    @RequestMapping("/memberTelCheck.do")
    @ResponseBody
    public String memberTelCheck(@RequestParam("utel") String utel) {
        if (utel == null || utel.trim().isEmpty()) {
            return "no";
        }
        MemberDTO dto = service.memberTelCheck(utel);
        return (dto != null) ? "no" : "yes";
    }

    // 이메일 인증 코드 전송
    @RequestMapping("/memberEmailCheck.do")
    @ResponseBody
    public String memberEmailCheck(@RequestParam("uEmail") String uEmail) {
        String uuid = UUID.randomUUID().toString().substring(0, 6);

        MimeMessage mail = mailSender.createMimeMessage();
        String mailContents = "<h3>이메일 주소 확인</h3><br/>"
                            + "<span>사용자가 본인임을 확인하려고 합니다. 다음 확인 코드를 입력하세요.</span>"
                            + "<h2>" + uuid + "</h2>";
        try {
            mail.setSubject("LINE SQUARE [이메일 인증코드]", "utf-8");
            mail.setText(mailContents, "utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
            mailSender.send(mail);
            return uuid;
        } catch (MessagingException e) {
            e.printStackTrace();
            return "fail";
        }
    }

    // 회원 목록 조회
    @RequestMapping("/memberList.do")
    public String memberList(Model model) {
        model.addAttribute("list", service.memberList());
        return "member/memberList";
    }

    // 회원 삭제 (탈퇴)
    @RequestMapping("/memberDelete.do")
    public String memberDelete(int no, HttpSession session, RedirectAttributes redirectAttributes) {
        service.memberDelete(no);
        session.invalidate();
        redirectAttributes.addFlashAttribute("msg", "회원탈퇴 완료!!");
        return "redirect:/memberLogin.do";
    }

    // 회원 정보 조회
    @RequestMapping("/memberInfo.do")
    public String memberInfo(int no, String find, Model model) {
        model.addAttribute("dto", service.memberInfo(no));
        model.addAttribute("find", find);
        return "member/memberInfo";
    }

    // 회원 정보 수정
    @RequestMapping("/memberUpdate.do")
    public String memberUpdate(MemberDTO dto, RedirectAttributes redirectAttributes) {
        service.memberUpdate(dto);        
        redirectAttributes.addFlashAttribute("msg", "회원정보 수정완료");
        return "redirect:/memberUpdateOk.do?no="+dto.getMemberNum()+"&find=info";
    }

    // 로그인 폼으로 이동
    @GetMapping("/memberLogin.do")
    public String memberLoginForm(String moveURL, Model model) {
        model.addAttribute("moveURL", moveURL);
        return "login/memberLoginForm";
    }

    // 로그인 처리
    @PostMapping("/memberLogin.do")
    public String memberLogin(MemberDTO dto, HttpServletRequest request, String moveURL, Model model, RedirectAttributes redirectAttributes) {
        boolean result = service.memberLogin(dto, request, redirectAttributes);
        if (!result) {
            return "redirect:/memberLogin.do?moveURL=" + moveURL;
        }
        return "redirect:/userMainForm.do";
    }

    // 로그아웃
    @GetMapping("/memberLogout.do")
    public String memberLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/userMainForm.do";
    }

    // 계정 찾기 선택 페이지로 이동
    @GetMapping("/accountFind.do")
    public String accountFindForm() {
        return "login/accountFind";
    }

    // 아이디/비밀번호 찾기 폼으로 이동
    @GetMapping("/idPwFind.do")
    public String idPwFind(String find, Model model) {
        model.addAttribute("find", find);
        return "login/idPwFind";
    }

    // 아이디 찾기 처리
    @PostMapping("findId.do")
    @ResponseBody
    public String findId(MemberDTO dto) {
        return service.findId(dto);
    }

    // 비밀번호 찾기 처리
    @PostMapping("findPw.do")
    @ResponseBody
    public int findPw(String uid, String uEmail, MemberDTO dto) {
        return service.findPw(uid, uEmail, dto);
    }

    // 비밀번호 확인
    @PostMapping("pwCheck.do")
    @ResponseBody
    public String pwCheck(String pw, HttpSession session) {
        MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
        String dbPw = dto.getMemberPw();
        return (pwEncoder.matches(pw, dbPw) || pw.equals(dbPw)) ? "ok" : "no";
    }

    // 비밀번호 변경
    @PostMapping("pwChange.do")
    @ResponseBody
    public int pwChange(@RequestBody MemberDTO dto) {
        String chiperPw = pwEncoder.encode(dto.getMemberPw());
        dto.setMemberPw(chiperPw);
        return service.modifyPw(dto);
    }

//    // 회원 예약 목록 확인 및 수정
//    @GetMapping("/myReservationList.do")
//    public String myReservationList(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
//        MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
//        if (dto == null) {
//            redirectAttributes.addFlashAttribute("msg", "회원 로그인이 필요합니다.");
//            session.invalidate();
//            return "redirect:/memberLogin.do";
//        }
//        model.addAttribute("myReservationList", resservice.myReserveList(dto.getMemberNum()));
//        return dto.getMemberType().equals("host") ? "reservation/hostReserveList" : "reservation/myReservationList";
//    }

    // 비밀번호 재설정 폼으로 이동
    @GetMapping("/forgotPassword.do")
    public String forgotPasswordForm() {
        return "login/forgotPasswordForm";
    }

    // 비밀번호 재설정 처리
    @PostMapping("/forgotPassword.do")
    public String resetPassword(@RequestParam("uid") String uid, @RequestParam("uEmail") String uEmail, RedirectAttributes redirectAttributes) {
        MemberDTO dto = service.memberIdCheck(uid);
        if (dto == null || !uEmail.equals(dto.getMemberEmail())) {
            redirectAttributes.addFlashAttribute("msg", "일치하는 회원정보가 없습니다.");
            return "redirect:/forgotPassword.do";
        }

        // 새 비밀번호 생성 및 이메일 전송 로직
        String newPassword = UUID.randomUUID().toString().substring(0, 8);
        dto.setMemberPw(pwEncoder.encode(newPassword));
        service.modifyPw(dto);

        // 이메일 발송
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            String mailContents = "<h3>새로운 비밀번호</h3><br/>"
                                + "<span>비밀번호가 재설정되었습니다. 새로운 비밀번호는 다음과 같습니다:</span>"
                                + "<h2>" + newPassword + "</h2>";
            mail.setSubject("LINE SQUARE [비밀번호 재설정]", "utf-8");
            mail.setText(mailContents, "utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(dto.getMemberEmail()));
            mailSender.send(mail);
            redirectAttributes.addFlashAttribute("msg", "새 비밀번호가 이메일로 전송되었습니다.");
            return "redirect:/memberLogin.do";
        } catch (MessagingException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("msg", "이메일 발송에 실패하였습니다.");
            return "redirect:/forgotPassword.do";
        }
    }

    // 아이디 찾기 폼으로 이동
    @GetMapping("/forgotId.do")
    public String forgotIdForm() {
        return "login/forgotIdForm";
    }

    // 아이디 찾기 처리
    @PostMapping("/forgotId.do")
    public String resetId(@RequestParam("uName") String uName, @RequestParam("uEmail") String uEmail, RedirectAttributes redirectAttributes) {
        MemberDTO dto = service.findIdByNameAndEmail(uName, uEmail);
        if (dto == null || dto.getMemberEmail() == null || dto.getMemberEmail().isEmpty()) {
            redirectAttributes.addFlashAttribute("msg", "일치하는 회원정보가 없거나 이메일 주소가 등록되지 않았습니다.");
            return "redirect:/forgotId.do";
        }

        // 이메일 발송
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            String mailContents = "<h3>아이디 찾기</h3><br/>"
                                + "<span>회원님의 아이디는 다음과 같습니다:</span>"
                                + "<h2>" + dto.getMemberId() + "</h2>";
            mail.setSubject("LINE SQUARE [아이디 찾기]", "utf-8");
            mail.setText(mailContents, "utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(dto.getMemberEmail()));
            mailSender.send(mail);
            redirectAttributes.addFlashAttribute("msg", "아이디가 이메일로 전송되었습니다.");
            return "redirect:/memberLogin.do";
        } catch (MessagingException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("msg", "이메일 발송에 실패하였습니다.");
            return "redirect:/forgotId.do";
        }
    }
    
    // 회원 목록 조회
    @RequestMapping("/memberUpdateOk.do")
    public String memberUpdateOk(int no, String find, Model model) {
        MemberDTO dto = service.memberInfo(no);  
        model.addAttribute("dto", dto);
        model.addAttribute("find", find);
        return "member/memberUpdate";
    }

}
