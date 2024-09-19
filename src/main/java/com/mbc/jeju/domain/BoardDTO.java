package com.mbc.jeju.domain;

import java.time.LocalDateTime;

public class BoardDTO {
    private int bid;  // 이 필드가 존재해야 합니다.
    private String subject;
    private String contents;
    private int hit;
    private String writer;
    private LocalDateTime reg_date;
    private int replyCnt;

    // 기본 생성자
    public BoardDTO() {}

    // 모든 필드를 사용하는 생성자
    public BoardDTO(int bid, String subject, String contents, int hit, String writer, LocalDateTime reg_date, int replyCnt) {
        this.bid = bid;
        this.subject = subject;
        this.contents = contents;
        this.hit = hit;
        this.writer = writer;
        this.reg_date = reg_date;
        this.replyCnt = replyCnt;
    }

    // Getter and Setter methods
    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public LocalDateTime getReg_date() {
        return reg_date;
    }

    public void setReg_date(LocalDateTime reg_date) {
        this.reg_date = reg_date;
    }

    public int getReplyCnt() {
        return replyCnt;
    }

    public void setReplyCnt(int replyCnt) {
        this.replyCnt = replyCnt;
    }

    // toString method
    @Override
    public String toString() {
        return "BoardDTO{" +
                "bid=" + bid +
                ", subject='" + subject + '\'' +
                ", contents='" + contents + '\'' +
                ", hit=" + hit +
                ", writer='" + writer + '\'' +
                ", reg_date=" + reg_date +
                ", replyCnt=" + replyCnt +
                '}';
    }
}
