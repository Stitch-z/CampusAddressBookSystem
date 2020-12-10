package com.po;

public class StudentCourse {
    private int scno;   //自增id
    private String saccount;    //学生编号
    private String caccount;    //课程编号

    public int getScno() {
        return scno;
    }

    public void setScno(int scno) {
        this.scno = scno;
    }

    public String getSaccount() {
        return saccount;
    }

    public void setSaccount(String saccount) {
        this.saccount = saccount;
    }

    public String getCaccount() {
        return caccount;
    }

    public void setCaccount(String caccount) {
        this.caccount = caccount;
    }
}
