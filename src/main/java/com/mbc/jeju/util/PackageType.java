package com.mbc.jeju.util;

public enum PackageType {
	
	HOLIDAY("연휴 특가"), HOTEL("호텔 제휴"), ETC("기타");
	
	private final String value;

	PackageType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
	
    @Override
    public String toString() {
        return getValue();
    }
}
