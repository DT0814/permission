package com.mmall.controller;

import com.mmall.common.JsonData;
import com.mmall.model.File;
import com.mmall.model.SysProj;
import com.mmall.model.SysUser;
import com.mmall.service.FileService;
import com.mmall.service.ProjService;
import com.mmall.service.SysDeptService;
import com.mmall.service.SysUserService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
public class ProjController {

    @Resource
    private ProjService projService;
    @Resource
    private FileService fileService;
    @Resource
    private SysUserService sysUserService;
    @Resource
    private SysDeptService sysDeptService;


    @RequestMapping("/updateProj.action")
    @ResponseBody
    public JsonData updateProj(SysProj proj) {
        if (proj.getId() == null || proj.getId() <= 0)
            return JsonData.fail("id is erro!");
        projService.updatProjById(proj);
        return JsonData.success(1);
    }

    //查看我的项目
    @RequestMapping("/showMyProj")
    @ResponseBody
    public ModelAndView getProjById(@RequestParam("userid") int userid, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("MyProj");
        System.out.println("查看id为" + userid + "的项目");
        List<SysProj> list = projService.getProjById(userid);
        for (int i = 0; i < list.size(); i++) {
            System.out.println("项目名" + list.get(i).getName());
        }
        mav.addObject("ProList", list);
        return mav;
    }

    //查看/上传文件  我的某个项目
    @RequestMapping("/toProj")
    @ResponseBody
    public ModelAndView toProj(@RequestParam("id") int id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("ProJ");
        System.out.println("将要查看项目id" + id);
        SysProj proj = projService.getOneProj(id);
        mav.addObject("ProjName", proj.getName());
        mav.addObject("ProjDesc", proj.getDescr());
        mav.addObject("Pid", id);
        return mav;
    }

    //查看/上传文件  我的某个项目
    @RequestMapping("/getAllFileNameAndFileByPid.action")
    @ResponseBody
    public JsonData getAllFileNameAndFileByPid(@RequestParam("id") int id, HttpServletRequest request) {
        System.out.println("将要查看项目id" + id);
        List<File> list = fileService.getFileByPidz(id);
        for (int i = 0; i < list.size(); i++) {
            String old = list.get(i).getLocation();
            if (null == old || old.indexOf(".") == -1) {
            } else {
                String res = old.substring(0, old.lastIndexOf(".")) + ".pdf";
                res = "../.." + res;
                System.out.println(res);
                list.get(i).setLocation(res);
            }
        }
        return JsonData.success(list);
    }

    /*
     * 查看所有项目用
     * */
    @RequestMapping("/showAllProj")
    @ResponseBody
    public ModelAndView getProjByLevel(@RequestParam("userid") int userid, HttpServletRequest request) {
        SysUser user = sysUserService.selectByPrimaryKey(userid);
        String level = sysDeptService.getLevel(user.getDeptId());
        int level1 = 0;
        for (int i = 0; i < level.length(); i++) {
            if (level.charAt(i) == '.') {
                level1++;
            }
        }
        List<SysProj> list = projService.getProjByLevel(level1);
        System.out.println("list.size():"+list.size());
        if(list!=null||list.size()>0){
            for(int i=0;i<list.size();i++)
            {
                if(list.get(i).getUid()==userid)
                    list.get(i).setIsMy(1);
            }
        }

        ModelAndView mav = new ModelAndView("ShowAllProj");
        mav.addObject("ProjList", list);
        return mav;
    }


    /*
     * 删除项目用
     * */
    @RequestMapping("/delectProj.action")
    @ResponseBody
    @Transactional
    public JsonData delectProj(@RequestParam("id") Integer id) {
        if (id == null || id <= 0)
            return JsonData.fail("pid is null!");
        List<File> fileList = fileService.getFileByPid(id);
        System.out.println("fileList.size():"+fileList.size());
        for (int i = 0; i < fileList.size(); i++) {
            java.io.File file = new java.io.File(fileList.get(i).getLocation());
            String pdfFileName = fileList.get(i).getLocation().substring(0, fileList.get(i).getLocation().indexOf(".")) + ".pdf";
            System.out.println("pdfFileName:" + pdfFileName);
            java.io.File file1 = new java.io.File(pdfFileName);
            if (file.exists() && file.isFile())
                System.out.println("file.delete():" + file.delete());
            else
                System.out.println("file is not exist");
            fileService.delectFile(fileList.get(i).getId());
        }
        return JsonData.success(projService.delectProj(id));
    }

    /**
     * 插入项目.
     * insertProj.action
     *
     * @param request - HttpRequest对象
     * @param String  name（项目名字）必传，
     *                ptid （项目类型id）必传
     * @param String  descr（描述） 选传
     */
    @RequestMapping("/insertProj.action")
    @ResponseBody
    public JsonData insertProj(SysProj sysProj,
                               HttpServletRequest request) {
        SysUser user1 = (SysUser) request.getSession().getAttribute("user");
        if (sysProj.getName() == null)
            return JsonData.fail(" Name is null");
        if (sysProj.getPtid() == null)
            return JsonData.fail(" Ptid is null");
        if (user1 == null)
            return JsonData.fail(" uid is null");
        System.out.println("创建项目" + sysProj.getName() + sysProj.getDescr() + sysProj.getPtid() + user1.getId());
//        Integer uid = (Integer) request.getSession().getAttribute("uid");
//        uid = 1;//仅测试
        SysUser user = sysUserService.selectByPrimaryKey(user1.getId());
        String level = sysDeptService.getLevel(user.getDeptId());
        int level1 = 0;
        for (int i = 0; i < level.length(); i++) {
            if (level.charAt(i) == '.') {
                level1++;
            }
        }
        sysProj.setLevel(level1);
        sysProj.setUid(user1.getId());
        sysProj.setStartdate(new Timestamp(new Date().getTime()));
        projService.insertProj(sysProj);
        return JsonData.success(1);
    }


    @RequestMapping("/CreateNewProj")
    @ResponseBody
    public ModelAndView insertProj(@RequestParam("userid") String userid,
                                   HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("NewProj");
        mav.addObject("user_id", userid);
        return mav;
    }
}


