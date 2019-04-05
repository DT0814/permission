package com.mmall.dao;

import com.mmall.model.SysProj;
import com.mmall.model.SysProjFName;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface ProjFNameDao {
    SysProjFName getProjFNameById(int id);

    List<SysProjFName> getProjFNameByPtid(int ptid);

    void insertProjFName(SysProjFName proj);

    int delectProjFName(int id);

    void updatProjFNameById(SysProjFName sysProj);
}
