package com.mmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @RequestMapping("index.page")
    public ModelAndView index(@RequestParam(value="username")String usernamenow,@RequestParam(value="user_id")String userid) {
        ModelAndView mav=new ModelAndView("admin");
        mav.addObject("username", usernamenow);
        mav.addObject("user_id", userid);
        System.out.println("ididid"+userid);
        System.out.println("获取用户名"+usernamenow);
        return mav;
    }
}
