package com.mmall.dao;

import com.mmall.model.SysProjType;
import org.mybatis.spring.annotation.MapperScan;
import java.util.List;
@MapperScan
public interface ProjTypeDao {
    SysProjType getProjTypeById(int id);

    SysProjType getProjTypeByFName(String fName);

    List<SysProjType> getProjTypeByDeleted();

    List<SysProjType> getProjTypeByUid(int uid);

    void insertProjType(SysProjType proj);
    int delectProjType(int id);
    void updatProjTypeById(SysProjType sysProj);
}
