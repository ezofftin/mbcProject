package com.mbc.jeju.domain;

import java.sql.Date;

public class ReservationDTO {
	private int reserveNum;

	private int packageNum;

	public int getPackageNum() {
		return packageNum;
	}

	public void setPackageNum(int packageNum) {
		this.packageNum = packageNum;
	}

	private int memberNum;
	private int hotelNum;
	private Date checkin;
	private Date checkout;
	private int people;
	
	private int totalPrice;
	
	private String state;
	
	public ReservationDTO() {}

	public ReservationDTO(int reserveNum, int packageNum, int memberNum, int hotelNum, Date checkin, Date checkout,
			int people, int totalPrice, String state) {
		super();
		this.reserveNum = reserveNum;
		this.packageNum = packageNum;
		this.memberNum = memberNum;
		this.hotelNum = hotelNum;
		this.checkin = checkin;
		this.checkout = checkout;
		this.people = people;
		this.totalPrice = totalPrice;
		this.state = state;
	}
	
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getReserveNum() {
		return reserveNum;
	}


	public void setReserveNum(int reserveNum) {
		this.reserveNum = reserveNum;
	}


	public int getMemberNum() {
		return memberNum;
	}


	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}


	public int getHotelNum() {
		return hotelNum;
	}


	public void setHotelNum(int hotelNum) {
		this.hotelNum = hotelNum;
	}


	public Date getCheckin() {
		return checkin;
	}


	public void setCheckin(Date checkin) {
		this.checkin = checkin;
	}


	public Date getCheckout() {
		return checkout;
	}


	public void setCheckout(Date checkout) {
		this.checkout = checkout;
	}


	public int getPeople() {
		return people;
	}


	public void setPeople(int people) {
		this.people = people;
	}

	@Override
	public String toString() {
		return "ReservationDTO [reserveNum=" + reserveNum + ", packageNum=" + packageNum + ", memberNum=" + memberNum
				+ ", hotelNum=" + hotelNum + ", checkin=" + checkin + ", checkout=" + checkout + ", people=" + people
				+ ", totalPrice=" + totalPrice + ", state=" + state + "]";
	}

	

	

	
	
	
	
}
