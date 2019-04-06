package com.mmall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.mmall.model.SysUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @RequestMapping("index.page")
    public ModelAndView index(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin");
        SysUser sysUser = (SysUser) session.getAttribute("user");
        mav.addObject("username", sysUser.getUsername());
        mav.addObject("user_id", sysUser.getId());
        return mav;
    }
}
