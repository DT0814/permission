package com.mmall.controller;

import com.mmall.common.JsonData;
import com.mmall.model.SysProj;
import com.mmall.model.SysProjFName;
import com.mmall.model.SysProjType;
import com.mmall.service.ProjFNameService;
import com.mmall.service.ProjTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
@Controller
public class ProjFNameController {
    @Resource
    private ProjFNameService projFNameService;

    /*
    删除项目类型
     * @param request - HttpRequest对象
     * @param int  id 必传
    *
    * */
    @RequestMapping("/delectProjFName.action")
    @ResponseBody
    public JsonData delectProjFName(@RequestParam("id") Integer id) {
        if (id == null || id <= 0)
            return JsonData.fail("id is erro!");
        projFNameService.delectProjFName(id);
        return JsonData.success(1);
    }



    @RequestMapping("/updatProjFNameById.action")
    @ResponseBody
    public JsonData updatProjFNameById(SysProjFName sysProjFName, HttpServletRequest request) {
        if(sysProjFName.getId() == null||sysProjFName.getId()<=0)
            JsonData.fail("id is null");
        if(sysProjFName.getFilename() == null)
        JsonData.fail("filename is null");
        if (sysProjFName.getId() == null || sysProjFName.getId() <= 0)
            JsonData.fail("id is erro");
        projFNameService.updatProjFNameById(sysProjFName);
        return JsonData.success(1);
    }

/*
* filename
* ptid 项目类型id
* */
    @RequestMapping("/insertProjFName.action")
    @ResponseBody
    public JsonData insertProjFName(SysProjFName sysProjFName, HttpServletRequest request) {
        if (sysProjFName.getFilename() == null)
            JsonData.fail("filename is null");
        if (sysProjFName.getPtid() == null || sysProjFName.getPtid() <= 0)
            JsonData.fail("ptid is erro");
        projFNameService.insertProjFName(sysProjFName);
        return JsonData.success(1);
    }

    /*
     * ptid即项目类型表中的id
     * */
    @RequestMapping("/getProjFNameByPtid.action")
    @ResponseBody
    public JsonData getProjFNameByPtid(@RequestParam("ptid") Integer ptid) {
        if (ptid == null || ptid <= 0)
            return JsonData.fail("ptid is erro!");
        return JsonData.success(projFNameService.getProjFNameByPtid(ptid));
    }

    @RequestMapping("/getProjFNameById.action")
    @ResponseBody
    public JsonData getProjFNameById(@RequestParam("id") Integer id) {
        if (id == null || id <= 0)
            return JsonData.fail("ptid is erro!");
        return JsonData.success(projFNameService.getProjFNameById(id));
    }
}
