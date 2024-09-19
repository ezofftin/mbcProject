package com.mbc.jeju.domain;

import com.mbc.jeju.util.PackageType;

import lombok.Data;
import lombok.ToString;

public class PackageDTO {
	private int packageNum;
	private String packageName;
	private PackageType packageType;
	private int packagePrice;
	private String packageInfo;
	private String packageImage;

	public PackageDTO() {}

	public int getPackageNum() {
		return packageNum;
	}

	public String getPackageName() {
		return packageName;
	}

	public PackageType getPackageType() {
		return packageType;
	}

	public int getPackagePrice() {
		return packagePrice;
	}

	public String getPackageInfo() {
		return packageInfo;
	}

	public String getPackageImage() {
		return packageImage;
	}

	public void setPackageNum(int packageNum) {
		this.packageNum = packageNum;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public void setPackageType(PackageType packageType) {
		this.packageType = packageType;
	}

	public void setPackagePrice(int packagePrice) {
		this.packagePrice = packagePrice;
	}

	public void setPackageInfo(String packageInfo) {
		this.packageInfo = packageInfo;
	}

	public void setPackageImage(String packageImage) {
		this.packageImage = packageImage;
	}

	@Override
	public String toString() {
		return "PackageDTO [packageNum=" + packageNum + ", packageName=" + packageName + ", packageType=" + packageType
				+ ", packagePrice=" + packagePrice + ", packageInfo=" + packageInfo + ", packageImage=" + packageImage
				+ "]";
	}

	public PackageDTO(int packageNum, String packageName, PackageType packageType, int packagePrice, String packageInfo,
			String packageImage) {
		super();
		this.packageNum = packageNum;
		this.packageName = packageName;
		this.packageType = packageType;
		this.packagePrice = packagePrice;
		this.packageInfo = packageInfo;
		this.packageImage = packageImage;
	}
	
}
