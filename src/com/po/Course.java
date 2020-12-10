package com.po;

public class Course {
    private int cno;    //自增id
    private String caccount;    //课程编号
    private String cname;   //课程名称
    private String taccount;    //教师编号
    private String cteacher;    //课程教师

    public int getCno() {
        return cno;
    }

    public void setCno(int cno) {
        this.cno = cno;
    }

    public String getCaccount() {
        return caccount;
    }

    public void setCaccount(String caccount) {
        this.caccount = caccount;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCteacher() {
        return cteacher;
    }

    public void setCteacher(String cteacher) {
        this.cteacher = cteacher;
    }

    public String getTaccount() {
        return taccount;
    }

    public void setTaccount(String taccount) {
        this.taccount = taccount;
    }

    @Override
    public String toString() {
        return "Course{" +
                "cno=" + cno +
                ", caccount='" + caccount + '\'' +
                ", cname='" + cname + '\'' +
                ", taccount='" + taccount + '\'' +
                ", cteacher='" + cteacher + '\'' +
                '}';
    }
}
