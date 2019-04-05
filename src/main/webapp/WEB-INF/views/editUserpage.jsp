<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="/assets/fly-3.0/res/layui/css/layui.css">
    <link rel="stylesheet" href="/assets/fly-3.0/res/css/global.css">
</head>
<body>

<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" href="/">
        </a>
        <!-- <ul class="layui-nav fly-nav layui-hide-xs">
           <li class="layui-nav-item layui-this">
             <a href="/"><i class="iconfont icon-jiaoliu"></i>交流</a>
           </li>
         </ul>-->
        <ul class="layui-nav fly-nav-user">
            <!-- 未登入的状态 -->
            <li class="layui-nav-item">
                <a href="user/login.html"></a>
            </li>
            <li class="layui-nav-item">
                <a href="user/reg.html"></a>
            </li>

        </ul>
    </div>
</div>

<div class="layui-container fly-marginTop">
    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user">
            <ul class="layui-tab-title">
                <li class="layui-this">修改个人信息</li>
            </ul>
            <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                <div class="layui-tab-item layui-show">
                    <div class="layui-form layui-form-pane">
                        <form action="updateuser.action" method="post">
                            <div class="layui-form-item">
                                <label for="L_email" class="layui-form-label">新用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="L_email" name="newusername" required lay-verify="required"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="L_pass1" class="layui-form-label">新密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="L_pass1" name="newpassword" required lay-verify="required"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="L_pass2" class="layui-form-label">电话</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="L_pass2" name="newtelephone" required
                                           lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="L_pass" class="layui-form-label">邮箱</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="L_pass" name="newmail" required lay-verify="required"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <input name="user_id" value="${user_id}" type="hidden"><br>
                                <input type="submit" class="layui-btn" value="修改"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>