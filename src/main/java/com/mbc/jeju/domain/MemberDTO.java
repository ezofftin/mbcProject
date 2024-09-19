package com.mbc.jeju.domain;

public class MemberDTO {
   private int memberNum;
   private String memberId;
   private String memberPw;
   private String memberName;
   private String memberEmail;
   private String memberTel;
   private String memberType;
   
   public MemberDTO() {}
   
   public int getMemberNum() {
      return memberNum;
   }
   public void setMemberNum(int memberNum) {
      this.memberNum = memberNum;
   }
   public String getMemberId() {
      return memberId;
   }
   public void setMemberId(String memberId) {
      this.memberId = memberId;
   }
   public String getMemberPw() {
      return memberPw;
   }
   public void setMemberPw(String memberPw) {
      this.memberPw = memberPw;
   }
   public String getMemberName() {
      return memberName;
   }
   public void setMemberName(String memberName) {
      this.memberName = memberName;
   }
   public String getMemberEmail() {
      return memberEmail;
   }
   public void setMemberEmail(String memberEmail) {
      this.memberEmail = memberEmail;
   }
   public String getMemberTel() {
      return memberTel;
   }
   public void setMemberTel(String memberTel) {
      this.memberTel = memberTel;
   }
   public String getMemberType() {
      return memberType;
   }
   public void setMemberType(String memberType) {
      this.memberType = memberType;
   }
   @Override
   public String toString() {
      return "MemberDTO [memberNum=" + memberNum + ", memberId=" + memberId + ", memberPw=" + memberPw
            + ", memberName=" + memberName + ", memberEmail=" + memberEmail + ", memberTel=" + memberTel
            + ", memberType=" + memberType + "]";
   }
   public MemberDTO(int memberNum, String memberId, String memberPw, String memberName, String memberEmail,
         String memberTel, String memberType) {
      super();
      this.memberNum = memberNum;
      this.memberId = memberId;
      this.memberPw = memberPw;
      this.memberName = memberName;
      this.memberEmail = memberEmail;
      this.memberTel = memberTel;
      this.memberType = memberType;
   }
   
   

}

