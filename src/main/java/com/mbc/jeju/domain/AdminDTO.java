package com.mbc.jeju.domain;

public class AdminDTO {
	private String adminId;
	private String adminPw;
	private String adminName;
	private String adminEmail;
	private String adminTel;
	
	
	// 인자생성자 
	public AdminDTO(String adminId, String adminPw, String adminName, String adminEmail,
			String adminTel) {
		super();
		this.adminId = adminId;
		this.adminPw = adminPw;
		this.adminName = adminName;
		this.adminEmail = adminEmail;
		this.adminTel = adminTel;
	}

	// construction using field
	@Override
	public String toString() {
		return "AdminDTO [adminId=" + adminId + ", adminPw=" + adminPw + ", adminName="
				+ adminName + ", adminEmail=" + adminEmail + ", adminTel=" + adminTel + "]";
	}
	
	// getter, setter 

	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}
	public String getAdminTel() {
		return adminTel;
	}
	public void setAdminTel(String adminTel) {
		this.adminTel = adminTel;
	}
	

	
}
