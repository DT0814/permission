package com.mmall.model;

import java.security.PrivateKey;
import java.util.Date;

public class SysProj {

    private Integer id;
    private Integer uid;
    private Integer ptid;
    private Integer type;
    private String name;
    private String descr;
    private Date startdate;
    private Integer level;
    //连表查询时用
    private String username;
    private String deptName;
    private String ptname;
    //是否是我的项目
    private int isMy=0;


    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getPtid() {
        return ptid;
    }

    public void setPtid(Integer ptid) {
        this.ptid = ptid;
    }

    public int getIsMy() {
        return isMy;
    }

    public void setIsMy(int isMy) {
        this.isMy = isMy;
    }

    public String getPtname() {
        return ptname;
    }

    public void setPtname(String ptname) {
        this.ptname = ptname;
    }
}
