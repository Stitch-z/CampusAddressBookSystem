package com.po;

/*
 * 联系人
 */
public class Liaison {
    private String laccount;//账号
    private int lno;//序号
    private String lnumber; //编号
    private String lname;//名字
    private String lsex;//性别
    private String lphone;//手机
    private String lrole;//角色
    public String getLaccount() {
        return laccount;
    }
    public void setLaccount(String laccount) {
        this.laccount = laccount;
    }
    public String getLname() {
        return lname;
    }
    public void setLname(String lname) {
        this.lname = lname;
    }
    public String getLsex() {
        return lsex;
    }
    public void setLsex(String lsex) {
        this.lsex = lsex;
    }
    public String getLphone() {
        return lphone;
    }
    public void setLphone(String lphone) {
        this.lphone = lphone;
    }
    public int getLno() {
        return lno;
    }
    public void setLno(int lno) {
        this.lno = lno;
    }

    public String getLrole() {
        return lrole;
    }

    public void setLrole(String lrole) {
        this.lrole = lrole;
    }

    public String getLnumber() {
        return lnumber;
    }

    public void setLnumber(String lnumber) {
        this.lnumber = lnumber;
    }

    @Override
    public String toString() {
        return "Liaison{" +
                "laccount='" + laccount + '\'' +
                ", lno=" + lno +
                ", lnumber='" + lnumber + '\'' +
                ", lname='" + lname + '\'' +
                ", lsex='" + lsex + '\'' +
                ", lphone='" + lphone + '\'' +
                ", lrole='" + lrole + '\'' +
                '}';
    }
}
