package com.mmall.controller;

import com.mmall.common.JsonData;
import com.mmall.model.SysProjType;
import com.mmall.model.SysUser;
import com.mmall.service.*;
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
public class ProjTypeController {
    @Resource
    private ProjTypeService projTypeService;


    /*
    删除项目类型
     * @param request - HttpRequest对象
     * @param int  id 必传
    *
    * */
    @RequestMapping("/delectProjType.action")
    @ResponseBody
    public JsonData delectProjType(SysProjType sysProjType) {
        if (sysProjType.getId() == null || sysProjType.getId() <= 0)
            return JsonData.fail("id is erro!");
        sysProjType.setDeleted(1);
        projTypeService.updatProjById(sysProjType);
        return JsonData.success(1);
    }

    /*
        修改项目类型
         * @param request - HttpRequest对象
         * @param int  id 必传
        *
        * */
    @RequestMapping("/updateProjType.action")
    @ResponseBody
    public JsonData updateProjType(SysProjType sysProjType) {
        if (sysProjType.getId() == null || sysProjType.getId() <= 0)
            return JsonData.fail("id is erro!");
        projTypeService.updatProjById(sysProjType);
        return JsonData.success(1);
    }


    /**
     * 插入项目类型.
     * insertProj.action
     *
     * @param request - HttpRequest对象
     * @param String  name;必传
     */
    @RequestMapping("/insertProjType.action")
    @ResponseBody
    public JsonData insertProjType(SysProjType sysProjType, HttpServletRequest request) {
        if (sysProjType.getName() == null)
            return JsonData.fail("I_PramFail");
        sysProjType.setDeleted(0);
        //   uid = 1;//仅测试
        sysProjType.setStartdate(new Timestamp(new Date().getTime()));
        projTypeService.insertProj(sysProjType);
        return JsonData.success(1);
    }

    //创建新的项目类型（跳转）
    @RequestMapping("/CreateNewProjType")
    @ResponseBody
    public ModelAndView getProjById(@RequestParam("userid") int uid, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("NewProjType");
        return mav;
    }


    //查看所有项目类型
    @RequestMapping("/ToProjTypeManage")
    public ModelAndView ToProjTypeManage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("ShowAllProjType");
        return mav;
    }

    //查看所有项目类型
    @RequestMapping("/FindAllProjType")
    @ResponseBody
    public JsonData FindAllProjType(HttpServletRequest request) {
        List<SysProjType> list = projTypeService.getProjTypeByDeleted();
        return JsonData.success(list);
    }
}
