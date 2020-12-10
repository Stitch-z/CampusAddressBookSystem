package com.po;

public class Notify {
    private int nno;
    private String nfrom;
    private String nfromName;
    private String nto;
    private String ntoName;
    private String ntoRole;
    private String ncourse;
    private String ncourseName;
    private String ncourseTaccount;
    private String ncourseTeacher;
    private String ncontent;
    private String nstate;
    private String ntype;

    public int getNno() {
        return nno;
    }

    public void setNno(int nno) {
        this.nno = nno;
    }

    public String getNfrom() {
        return nfrom;
    }

    public void setNfrom(String nfrom) {
        this.nfrom = nfrom;
    }

    public String getNfromName() {
        return nfromName;
    }

    public void setNfromName(String nfromName) {
        this.nfromName = nfromName;
    }

    public String getNto() {
        return nto;
    }

    public void setNto(String nto) {
        this.nto = nto;
    }


    public String getNcontent() {
        return ncontent;
    }

    public void setNcontent(String ncontent) {
        this.ncontent = ncontent;
    }

    public String getNstate() {
        return nstate;
    }

    public void setNstate(String nstate) {
        this.nstate = nstate;
    }

    public String getNcourse() {
        return ncourse;
    }

    public void setNcourse(String ncourse) {
        this.ncourse = ncourse;
    }

    public String getNtoName() {
        return ntoName;
    }

    public void setNtoName(String ntoName) {
        this.ntoName = ntoName;
    }

    public String getNtoRole() {
        return ntoRole;
    }

    public void setNtoRole(String ntoRole) {
        this.ntoRole = ntoRole;
    }

    public String getNcourseName() {
        return ncourseName;
    }

    public void setNcourseName(String ncourseName) {
        this.ncourseName = ncourseName;
    }

    public String getNcourseTaccount() {
        return ncourseTaccount;
    }

    public void setNcourseTaccount(String ncourseTaccount) {
        this.ncourseTaccount = ncourseTaccount;
    }

    public String getNcourseTeacher() {
        return ncourseTeacher;
    }

    public void setNcourseTeacher(String ncourseTeacher) {
        this.ncourseTeacher = ncourseTeacher;
    }

    public String getNtype() {
        return ntype;
    }

    public void setNtype(String ntype) {
        this.ntype = ntype;
    }

    @Override
    public String toString() {
        return "Notify{" +
                "nno=" + nno +
                ", nfrom='" + nfrom + '\'' +
                ", nfromName='" + nfromName + '\'' +
                ", nto='" + nto + '\'' +
                ", ntoName='" + ntoName + '\'' +
                ", ntoRole='" + ntoRole + '\'' +
                ", ncourse='" + ncourse + '\'' +
                ", ncourseName='" + ncourseName + '\'' +
                ", ncourseTaccount='" + ncourseTaccount + '\'' +
                ", ncourseTeacher='" + ncourseTeacher + '\'' +
                ", ncontent='" + ncontent + '\'' +
                ", nstate='" + nstate + '\'' +
                ", ntype='" + ntype + '\'' +
                '}';
    }
}
