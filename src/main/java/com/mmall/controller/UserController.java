package com.mmall.controller;

import com.mmall.common.JsonData;
import com.mmall.model.SysUser;
import com.mmall.service.SysUserService;
import com.mmall.util.MD5Util;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@Controller
public class UserController {

    @Resource
    private SysUserService sysUserService;

    @RequestMapping("/logout.page")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getSession().invalidate();
        String path = "signin.jsp";
        response.sendRedirect(path);
    }

    @RequestMapping("/logintest.action")//仅postman测试用
    @ResponseBody
    public JsonData logintest(@RequestParam("id") Integer id, HttpServletRequest request) throws IOException, ServletException {
        SysUser user = sysUserService.selectByPrimaryKey(id);
        request.getSession().setAttribute("user", user);
        return JsonData.success(1);
    }

    @RequestMapping("/login.page")
    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        SysUser sysUser = sysUserService.findByKeyword(username);
        String errorMsg = "";
        String ret = request.getParameter("ret");
        //System.out.println(ret);
        if (StringUtils.isBlank(username)) {
            errorMsg = "用户名不可以为空";
        } else if (StringUtils.isBlank(password)) {
            errorMsg = "密码不可以为空";
        } else if (sysUser == null) {
            errorMsg = "查询不到指定的用户";
        } else if (!sysUser.getPassword().equals(MD5Util.encrypt(password))) {
            errorMsg = "用户名或密码错误";
        } else if (sysUser.getStatus() != 1) {
            errorMsg = "用户已被冻结，请联系管理员";
        } else {
            // login success
            request.getSession().setAttribute("user", sysUser);

            if (StringUtils.isNotBlank(ret)) {
                response.sendRedirect(ret);
            } else {
                response.sendRedirect("/admin/index.page"); //TODO
            }
        }

        request.setAttribute("error", errorMsg);
        request.setAttribute("username", username);
        if (StringUtils.isNotBlank(ret)) {
            request.setAttribute("ret", ret);
        }
        String path = "signin.jsp";
        request.getRequestDispatcher(path).forward(request, response);
    }

    @RequestMapping("/toUpdatePassword")
    public ModelAndView toUpdatePassword(int uid, HttpServletRequest request) {
        request.setAttribute("user_id", uid);
        ModelAndView mav = new ModelAndView("toUpdatePassword");
        return mav;
    }

    @RequestMapping("/showPersonal")
    public ModelAndView showPersonal(int uid, HttpServletRequest request) {
        request.setAttribute("user_id", uid);
        ModelAndView mav = new ModelAndView("showPersonal");
        return mav;
    }

    @RequestMapping("/getUser.action")
    @ResponseBody
    public JsonData getUser(Integer uid) {
        if (null == uid || uid < 0) {
            return JsonData.fail("uid is null!");
        }
        SysUser user = sysUserService.selectByPrimaryKey(uid);
        return JsonData.success(user);
    }

    @RequestMapping("/updatePass.action")
    @ResponseBody
    public JsonData updatePass(String oldPassWord, String newPassWord, Integer uid) {
        SysUser user = sysUserService.selectByPrimaryKey(uid);
        System.out.println("MD5Util.encrypt(oldPassWord):"+MD5Util.encrypt(oldPassWord));
        if (!user.getPassword().equals(MD5Util.encrypt(oldPassWord)))
            return JsonData.fail("pass is erro!");
        String MD5Password = MD5Util.encrypt(newPassWord);
        user.setPassword(MD5Password);
        sysUserService.updateUser(user);
        return JsonData.success(1);
    }

    @RequestMapping("/updateUser.action")
    @ResponseBody
    public JsonData updateUser(SysUser sysUser) {
        if(sysUser.getId()==null)
            return JsonData.fail("id is null");
        System.out.println("sysUser.getId():"+sysUser.getId());
        System.out.println("sysUser.getUsername():"+sysUser.getUsername());
        sysUserService.updateUser(sysUser);
        return JsonData.success(1);
    }

  /*  @RequestMapping(value = "/updateUser.action", method = RequestMethod.POST)
    public ModelAndView updateUser
            (@RequestParam(value = "user_id") String user_id,
             @RequestParam(value = "newusername") String newusername,
             @RequestParam(value = "newpassword") String newpassword,
             @RequestParam(value = "newtelephone") String newtelephone,
             @RequestParam(value = "newmail") String newmail, HttpServletRequest request, Model model, HttpSession session)
            throws Exception {
        System.out.println("将要修改的id" + user_id);
        System.out.println(newmail);
        String MD5Password = MD5Util.encrypt(newpassword);
        System.out.println(MD5Password);
        int uid = Integer.parseInt(user_id);
        sysUserService.updateUser(uid, newusername, MD5Password, newtelephone, newmail);
        ModelAndView mav = new ModelAndView("../../signin");
        return mav;
    }
*/
}
