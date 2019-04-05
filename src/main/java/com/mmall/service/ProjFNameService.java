package com.mmall.service;

import com.mmall.dao.ProjFNameDao;
import com.mmall.model.SysProj;
import com.mmall.model.SysProjFName;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ProjFNameService {
    @Resource
    ProjFNameDao projFNameDao;

    //   @Resource
    //  PassageDao passageDao;
    public SysProjFName getProjFNameById(int id) {
        // TODO Auto-generated method stub
        return projFNameDao.getProjFNameById(id);
    }
    public List<SysProjFName> getProjFNameByPtid(int pid) {
        return projFNameDao.getProjFNameByPtid(pid);
    }

    public void insertProjFName(SysProjFName sysProjFName) {
        projFNameDao.insertProjFName(sysProjFName);
    }

    public void updatProjFNameById(SysProjFName sysProjFName) {
        // TODO Auto-generated method stub
        projFNameDao.updatProjFNameById(sysProjFName);
    }
    public int delectProjFName(Integer id) {
        return projFNameDao.delectProjFName(id);
    }
}
