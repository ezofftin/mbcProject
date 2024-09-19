package com.mbc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.jeju.domain.HotelDTO;
import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.service.AdminService;
import com.mbc.service.HotelService;
import com.mbc.service.MemberService;
import com.mbc.service.ReservationService;

@Controller
public class HotelController {
	@Autowired
	private HotelService service;
	
	@Autowired
	private AdminService adminservice;
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private ReservationService resservice ;
	
	// 호텔 리스트(admin)
	@RequestMapping("/adminhotelList.do")
	public String adminHotelList(Model model) {
		ArrayList<HotelDTO> hotelList = service.hotelList();
		model.addAttribute("hotelList", hotelList);
		
		return "hotel/ad_hotelList";
	}
//	// 새 호텔 등록(admin) host 등록에 포함 ad_hotelRegister 삭제
//	@GetMapping("/hotelInput.do")
//	public String HotelRegister(Model model) {
//		ArrayList<HotelDTO> hotelList = service.hotelList();
//		model.addAttribute("hotelList", hotelList);
//		return "admin/ad_hotelRegister";
//	}
	// 새 호텔 등록(host)
	@GetMapping("/hostHotelInput.do")
	public String NewHotel(Model model) {
		ArrayList<HotelDTO> hotelList = service.hotelList();
		model.addAttribute("hotelList", hotelList);
		return "hotel/hotelRegister";
	}
//	// 호텔 등록하기(admin)
//	@PostMapping("/hotelRegister.do")
//	public String insertHotel(HttpSession session, MultipartHttpServletRequest mhr, HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException {
//		
//				String savePath = "C:/fileRepo/";
//				
//				// 사진 여러장 업로드
//				List<String> uploadedFileNames= new ArrayList<>();
//				
//				Map map = new HashMap();
//				
//				Enumeration<String> enu = mhr.getParameterNames();
//				
//				while(enu.hasMoreElements()) {
//					String paramName = enu.nextElement();
//					String paramValue = mhr.getParameter(paramName);
////					System.out.println(paramName + " : " + paramValue);
//					map.put(paramName, paramValue);
//				}
//				
//				List<MultipartFile> fileList = mhr.getFiles("hotelImage");
//				
//				for (MultipartFile mFile : fileList) {
//					String originName = mFile.getOriginalFilename();
//					if(originName == null || originName.isEmpty()) {
//						continue;
//					}
//					
//					// 중복된 파일명 처리
//					String saveFileName = originName;
//					File uploadFile = new File(savePath + saveFileName);
//					if (uploadFile.exists()) {
//						saveFileName = System.currentTimeMillis() + "_" + originName;
//						uploadFile = new File(savePath + saveFileName);
//					}
//					
//					// 파일 저장
//					mFile.transferTo(uploadFile);
//					uploadedFileNames.add(saveFileName);
//				}
//				
//				// 업로드된 파일 이름들을 쉼표로 구분하여 저장
//				map.put("hotelImage", String.join(", ", uploadedFileNames));
//
//				
//		service.insertHotel(map);
//		redirectAttributes.addFlashAttribute("msg", "상품 등록 완료");
//		
//		return "redirect:/adminhotelList.do";
//	}
	
	// 호텔 등록하기(host)
	@PostMapping("/hostHotelRegister.do")
	public String insertHotelHost(HttpSession session, MultipartHttpServletRequest mhr, HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException {
		
		String savePath = "C:/fileRepo/";
		
		// 사진 여러장 업로드
		List<String> uploadedFileNames= new ArrayList<>();
		
		Map map = new HashMap();
		
		Enumeration<String> enu = mhr.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String paramName = enu.nextElement();
			String paramValue = mhr.getParameter(paramName);
//			System.out.println(paramName + " : " + paramValue);
			map.put(paramName, paramValue);
		}
		
		List<MultipartFile> fileList = mhr.getFiles("hotelImages");
		
		for (MultipartFile mFile : fileList) {
			String originName = mFile.getOriginalFilename();
			if(originName == null || originName.isEmpty()) {
				continue;
			}
			
			// 중복된 파일명 처리
			String saveFileName = originName;
			File uploadFile = new File(savePath + saveFileName);
			if (uploadFile.exists()) {
				saveFileName = System.currentTimeMillis() + "_" + originName;
				uploadFile = new File(savePath + saveFileName);
			}
			
			// 파일 저장
			mFile.transferTo(uploadFile);
			uploadedFileNames.add(saveFileName);
		}
		
		// 업로드된 파일 이름들을 쉼표로 구분하여 저장
		map.put("hotelImage", String.join(", ", uploadedFileNames));

		
		service.insertHotel(map);
		redirectAttributes.addFlashAttribute("msg", "상품 등록 완료");

		return "redirect:/adminhotelList.do";
	}
	
	@RequestMapping("/hotelUpdate.do") // Model model은 바인딩
	public String getProduct(int hotelNum, Model model) {
		HotelDTO hotelDto = service.hotelInfo(hotelNum);
		model.addAttribute("hotelDto", hotelDto);
		
		return "hotel/hotelUpdate";
	}
	
	// 호텔 수정(admin)
	@RequestMapping("/hotelUpdateOk.do")
	public String hotelUpdate(MultipartHttpServletRequest mhr, RedirectAttributes redirectAttributes) throws IOException {
		// 외부 경로 설정
		String savePath = "C:/fileRepo/";
		
		// 사진 여러장 업로드
		List<String> uploadedFileNames = new ArrayList<>();
		
		Map<String, Object> map = new HashMap<>();

	    Enumeration<String> enu = mhr.getParameterNames();
		
		 while (enu.hasMoreElements()) {
		        String paramName = enu.nextElement();
		        String paramValue = mhr.getParameter(paramName);
		        map.put(paramName, paramValue);
		    }
		 // 기존 이미지 데이터 유지
		 String existingImages = mhr.getParameter("hotelImageOld"); // 기존 이미지
		    if (existingImages != null && !existingImages.isEmpty()) {
		        uploadedFileNames.addAll(Arrays.asList(existingImages.split(",")));
		    }
		    // 새로운 파일 업로드 처리
		 List<MultipartFile> fileList = mhr.getFiles("hotelImages");
		 // 파일 저장 및 이름 리스트에 추가
		 for (MultipartFile mFile : fileList) {
		        String originName = mFile.getOriginalFilename();
		        if (originName == null || originName.isEmpty()) {
		            continue;
		        }
		        
		     // 중복된 파일명 처리
		        String saveFileName = originName;
		        File uploadFile = new File(savePath + saveFileName);
		        if (uploadFile.exists()) {
		            saveFileName = System.currentTimeMillis() + "_" + originName;
		            uploadFile = new File(savePath + saveFileName);
		        }

		        // 파일 저장
		        mFile.transferTo(uploadFile);
		        uploadedFileNames.add(saveFileName);
		    }
		        
		 // 기존 이미지와 업로드된 파일 이름들을 쉼표로 구분하여 저장
		    String uploadedFileNamesString = String.join(",", uploadedFileNames);
		    map.put("hotelImage", uploadedFileNamesString);
		 
		System.out.println(map);
		service.hotelUpdate(map);
		redirectAttributes.addFlashAttribute("msg", "수정완료");
		return "redirect:/adminhotelList.do";
	}
	
	// 호텔 삭제(admin)
	@RequestMapping("/hotelDelete.do")
	public String hotelDelete(int hotelNum, String hotelImage, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		//파일 저장 경로
		String savePath = "C:/fileRepo/";
		
		File delFile = null;
		
		 if(hotelImage != null) {
			  delFile = new File(savePath + "\\" + hotelImage); //(savePath + "/" + hotelImage);
			  if(delFile.exists()) {
				  if(delFile.delete()) {
					  System.out.println("이미지 파일 삭제완료");
				  }
			  }
		  }
		service.hotelDelete(hotelNum);
		redirectAttributes.addFlashAttribute("msg", "해당 호텔 삭제완료");
		return "redirect:/adminhotelList.do";
	}
	
	// 호텔 리스트 페이지
	@RequestMapping("/hotelList.do")
	public String hotelList(Model model) {
		ArrayList<HotelDTO> hotelList = service.hotelList();
		model.addAttribute("hotelList", hotelList);
		
		
		return "hotel/hotelList";
	}
	
	// 호텔 상세정보 페이지
	@RequestMapping("/hotelInfo.do")
	public String hotelInfo(int hotelNum, Model model) {
		HotelDTO hotelDto = service.hotelInfo(hotelNum);
		model.addAttribute("hotelDto", hotelDto);
		
		String hotelInfo = hotelDto.getHotelInfo().replaceAll("\n", "<br/>");
	    model.addAttribute("hotelInfo", hotelInfo);
		
		return "hotel/hotelInfo";
	}
}

