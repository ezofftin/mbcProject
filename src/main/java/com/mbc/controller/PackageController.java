package com.mbc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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

import com.mbc.jeju.domain.MemberDTO;
import com.mbc.jeju.domain.PackageDTO;
import com.mbc.jeju.domain.ReservationDTO;
import com.mbc.jeju.util.PackageType;
import com.mbc.service.MemberService;
import com.mbc.service.PackageService;

@Controller
public class PackageController {

	@Autowired
	private PackageService service;
	@Autowired
	private MemberService memberService;

	// admin @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 핫딜 등록 페이지로 이동
	@GetMapping("/packageInput.do")
	public String PackageInputForm(Model model) {

		PackageType[] packTypes = PackageType.values();
		model.addAttribute("packTypes", packTypes);

		return "/package/package_input";
	}

	// 핫딜 등록 OK
	@PostMapping("/packageRegisterOk.do")
	public String insertPackage(MultipartHttpServletRequest mhr, HttpServletRequest request,
			RedirectAttributes redirectAttributes) throws IOException {

//		String repository = "resources/fileRepository";
//		String savePath = request.getServletContext().getRealPath("") + File.separator + repository;
//		System.out.println("savePath: " + savePath);

		// 외부 경로 설정
		String savePath = "C:/fileRepo/";

		// 사진 여러장 업로드
		List<String> uploadedFileNames = new ArrayList<>();

		Map map = new HashMap();

		Enumeration<String> enu = mhr.getParameterNames();

		while (enu.hasMoreElements()) {
			String paramName = enu.nextElement();
			String paramValue = mhr.getParameter(paramName);
			map.put(paramName, paramValue);
		}

		List<MultipartFile> fileList = mhr.getFiles("packageImages");

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

		// 업로드된 파일 이름들을 쉼표로 구분하여 저장
		map.put("packageImage", String.join(", ", uploadedFileNames));

		// 패키지 저장 서비스 호출
		service.insertPackage(map);

//		service.insertPackage(map);
		redirectAttributes.addFlashAttribute("msg", "패키지 등록 완료");

		return "redirect:/packageList.do";
	}

	// 핫딜 리스트 보기
	@RequestMapping("/packageList.do")
	public String packageList(Model model, String packType) {
		ArrayList<PackageDTO> packageList = service.packageList();
		model.addAttribute("list", packageList);
		return "package/package_list";
	}

	// 핫딜 리스트에서 삭제
	@RequestMapping("/deletePackage.do")
	public String deletePackage(int packageNum, String packageImage, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

	    // 외부 경로 설정
	    String savePath = "C:/fileRepo/";
	    
	    File delFile = new File(savePath + File.separator + packageImage);

		if (packageImage != null) {
			delFile = new File(savePath + "\\" + packageImage);
			if (delFile.exists()) {
				if (delFile.delete()) {
					System.out.println("삭제 완료!");
				}
			}
		}

		service.deletePackage(packageNum);
		redirectAttributes.addFlashAttribute("msg", "삭제 완료!");

		return "redirect:/packageList.do";
	}

	// 핫딜 상품 수정 폼으로 이동
	@RequestMapping("/updatePackage.do")
	public String modifyPackage(int packageNum, Model model) {

		PackageType[] packTypes = PackageType.values();
		model.addAttribute("packTypes", packTypes);

		PackageDTO dto = service.modifyPackage(packageNum);
		model.addAttribute("dto", dto);

		return "package/package_update";
	}

	// 핫딜 상품 수정 Ok
	@RequestMapping("/updatePackageOk.do")
	public String updatePackage(MultipartHttpServletRequest mhr, HttpServletRequest request,
			RedirectAttributes redirectAttributes) throws IOException {
		
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

	    List<MultipartFile> fileList = mhr.getFiles("packageImages");

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

	    // 업로드된 파일 이름들을 쉼표로 구분하여 저장
	    String uploadedFileNamesString = String.join(",", uploadedFileNames);
	    map.put("packageImage", uploadedFileNamesString);

	    // 서비스 호출하여 데이터베이스 업데이트
	    service.updatePackage(map);

	    return "redirect:/packageList.do";
	}
	
	// user @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 전체 package 상품 리스트 띄우기
	@RequestMapping("/UPackList.do")
	public String UPackList(String packageNum, String packageType, Model model) {
		ArrayList<PackageDTO> packageList = service.packageList();
		model.addAttribute("list", packageList);

		PackageType[] packTypes = PackageType.values();
		model.addAttribute("packTypes", packTypes);

		// packageType 클릭 시 이동
//		ArrayList<PackageDTO> pList = service.getPackByType(packageType);
//		model.addAttribute("list", pList); // 패키지 타입 별 리스트
//		model.addAttribute("type", packageType); // enum

		// enum 값 출력
//		String pTypeName = PackageType.valueOf(packageType).getValue();
//		model.addAttribute("pTypeName", pTypeName);

		// 특정 packageType에 따른 패키지 리스트 필터링
		if (packageType != null && !packageType.isEmpty()) {
			ArrayList<PackageDTO> pList = service.getPackByType(packageType);
			model.addAttribute("list", pList); // 선택된 패키지 타입에 따른 리스트
			model.addAttribute("type", packageType); // 선택된 패키지 타입

			// enum 값을 모델에 추가
			String pTypeName = PackageType.valueOf(packageType).getValue();
			model.addAttribute("pTypeName", pTypeName);
		}

		return "/package/user_package_list";
	}

	// package 상세 페이지 띄우기
	@RequestMapping("/UPackView.do")
	public String UPackView(int packageNum, String packageType, Model model) {
		PackageType[] packTypes = PackageType.values();
		model.addAttribute("packTypes", packTypes);

		PackageDTO packDto = service.getPackage(packageNum);
		model.addAttribute("dto", packDto);

//		String packTypeName = PackageType.valueOf(packageType).getValue();
//		model.addAttribute("packageType", packTypeName);

		if (packageType != null && !packageType.isEmpty()) {
			ArrayList<PackageDTO> packageList = service.getPackByType(packageType);
			model.addAttribute("list", packageList); // 선택된 패키지 타입에 따른 리스트
			model.addAttribute("type", packageType); // 선택된 패키지 타입

			// enum 값을 모델에 추가
			String pTypeName = PackageType.valueOf(packageType).getValue();
			model.addAttribute("pTypeName", pTypeName);
		}

		return "/package/user_package_view";
	}
	
	// 예약 ... @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@RequestMapping("/reservePackage.do")
	public String reservePackage(PackageDTO dto, int packageNum, Model model) {
		PackageDTO packDto = service.getPackage(packageNum);
		model.addAttribute("dto", packDto);
		
		ArrayList<PackageDTO> packageList = service.packageList();
		model.addAttribute("packageList", packageList);
		
		ArrayList<MemberDTO> memberList = memberService.memberList();
		model.addAttribute("memberList", memberList);
		
		return "/package/user_reserve_package";
	}
	
	// 예약 Ok ==> 미완성 @@@@
	@PostMapping("/reservePackageOk.do")
//	@RequestMapping("/reservePackageOk.do")
	public String reservePackInput(int packageNum, HttpSession session, MultipartHttpServletRequest mhr, HttpServletRequest request, ReservationDTO dto) throws IOException {
		MemberDTO mDto = (MemberDTO)session.getAttribute("loginDTO");
		PackageDTO pDto = service.getPackage(packageNum);
		
		dto.setMemberNum(mDto.getMemberNum());
		dto.setPackageNum(pDto.getPackageNum());
		
		service.reservePackage(dto);
		
		return "redirect:/myReserveList.do";
	}

}
