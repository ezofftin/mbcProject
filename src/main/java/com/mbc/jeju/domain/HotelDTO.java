package com.mbc.jeju.domain;

public class HotelDTO {
	private int hotelNum;
	private String hotelName;
	private int hotelPrice;
	private String hotelInfo;
	private String hotelImage;
	private String hotelState;
	private int hostNum;
	public HotelDTO () {}

	public HotelDTO(int hotelNum, String hotelName, int hotelPrice, String hotelInfo, String hotelImage,
			String hotelState, int hostNum) {
		super();
		this.hotelNum = hotelNum;
		this.hotelName = hotelName;
		this.hotelPrice = hotelPrice;
		this.hotelInfo = hotelInfo;
		this.hotelImage = hotelImage;
		this.hotelState = hotelState;
		this.hostNum = hostNum;
	}

	public int getHostNum() {
		return hostNum;
	}

	public void setHostNum(int hostNum) {
		this.hostNum = hostNum;
	}

	public int getHotelNum() {
		return hotelNum;
	}

	public void setHotelNum(int hotelNum) {
		this.hotelNum = hotelNum;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public int getHotelPrice() {
		return hotelPrice;
	}

	public void setHotelPrice(int hotelPrice) {
		this.hotelPrice = hotelPrice;
	}

	public String getHotelInfo() {
		return hotelInfo;
	}

	public void setHotelInfo(String hotelInfo) {
		this.hotelInfo = hotelInfo;
	}

	public String getHotelImage() {
		return hotelImage;
	}

	public void setHotelImage(String hotelImage) {
		this.hotelImage = hotelImage;
	}

	public String getHotelState() {
		return hotelState;
	}

	public void setHotelState(String hotelState) {
		this.hotelState = hotelState;
	}

	@Override
	public String toString() {
		return "HotelDTO [hotelNum=" + hotelNum + ", hotelName=" + hotelName + ", hotelPrice=" + hotelPrice
				+ ", hotelInfo=" + hotelInfo + ", hotelImage=" + hotelImage + ", hotelState=" + hotelState + "]";
	}
	
	
}
