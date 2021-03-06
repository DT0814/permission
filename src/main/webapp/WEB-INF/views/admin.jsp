﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.mmall.common.RequestHolder" %>
<%@ page import="com.mmall.model.SysUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/common/backend_common.jsp"/>
</head>

<body class="no-skin">
<div id="navbar" class="navbar navbar-default">
    <div class="navbar-container">
        <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler">
            <span class="sr-only">Toggle sidebar</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>

        <div class="navbar-header pull-left">
            <a href="/admin/page.do" class="navbar-brand">
                <small>


                </small>
            </a>
        </div>
        <div class="navbar-buttons navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <li style="float:right">
                <li><a href="#">${username }</a></li>
                <li><a href="#" onclick="loginOut()">注销</a></li>
            </ul>
        </div>

    </div>

</div>

<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>

    <div id="sidebar" class="sidebar responsive">
        <script type="text/javascript">
            try {
                ace.settings.check('sidebar', 'fixed')
            } catch (e) {
            }
        </script>


        <ul class="nav nav-list">
            <li class="active">
                <a class="popstyle">
                    <i class="menu-icon fa fa-tachometer"></i>
                    <span class="menu-text"> 首页 </span>
                </a>
                <b class="arrow"></b>
            </li>
            <li class="">
                <a href="#" class="dropdown-toggle">
                    &nbsp;
                    <i class="glyphicon glyphicon-file"></i>
                    <span class="menu-text"> &nbsp;项目管理 </span>
                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>
                <ul class="submenu">
                    <c:if test="${user.adm == 1}">
                        <li class="">
                            <a class="popstyle" href="/ToProjTypeManage?userid=${user_id}" target="_blank">
                                <i class="menu-icon fa fa-caret-right"></i>
                                项目类型管理
                            </a>
                            <b class="arrow"></b>
                        </li>
                    </c:if>
                    <li class="">
                        <a class="popstyle" href="/toMyProj" target="_blank">
                            <i class="menu-icon fa fa-caret-right"></i>
                            我的项目
                        </a>
                        <b class="arrow"></b>
                    </li>
                    <li class="">
                        <a class="popstyle" href="/toProjManage" target="_blank">
                            <i class="menu-icon fa fa-caret-right"></i>
                            所有项目
                        </a>
                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>
            <li class="">
                <a href="#" class="dropdown-toggle">
                    &nbsp;
                    <i class="glyphicon glyphicon-home"></i>
                    <span class="menu-text">&nbsp; 信息管理</span>
                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <li class="">
                        <a class="popstyle" href="/sys/dept/dept.page" target="_blank">
                            <i class="menu-icon fa fa-caret-right"></i>
                            用户/部门管理
                        </a>
                        <b class="arrow"></b>
                    </li>

                </ul>
            </li>

            <li class="">
                <a href="#" class="dropdown-toggle"> &nbsp;
                    <i class="glyphicon glyphicon-user"></i>
                    <span class="menu-text"> &nbsp;个人信息管理</span>
                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>
                <ul class="submenu">
                    <li class="">
                        <a class="popstyle" href="/toUpdatePassword?uid= ${user_id}" target="_blank">
                            <i class="menu-icon fa fa-caret-right"></i>
                            密码修改
                        </a>
                        <b class="arrow"></b>
                    </li>
                    <li class="">
                        <a class="popstyle" href="/showPersonal?uid= ${user_id}" target="_blank">
                            <i class="menu-icon fa fa-caret-right"></i>
                            信息管理
                        </a>
                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>
        </ul>
        <!-- /.nav-list -->
        <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
            <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left"
               data-icon2="ace-icon fa fa-angle-double-right"></i>
        </div>

        <script type="text/javascript">
            try {
                ace.settings.check('sidebar', 'collapsed')
            } catch (e) {
            }
        </script>
    </div>

    <div class="main-content">
        <iframe id="innerFrame" src="/toMyProj" width="99%" style="min-height: 768px;height: 100%"></iframe>
    </div>
    <!-- /.main-content -->

    <a href="index.html#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse display">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>
<!-- /.main-container -->


<!-- basic scripts -->

<!--[if !IE]> -->
<script src="/assets/js/jquery-2.1.0.min.js"></script>

<!-- <![endif]-->

<!--[if IE]>
<script src="/assets/js/jquery-1.11.0.min.js"></script>
<![endif]-->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='/assets/js/jquery.min.js'>" + "<" + "/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='/assets/js/jquery1x.min.js'>" + "<" + "/script>");
</script>
<![endif]-->

<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
<script src="/assets/js/excanvas.min.js"></script>
<![endif]-->
<script src="/assets/js/jquery-ui.custom.min.js"></script>
<script src="/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="/assets/js/jquery.easypiechart.min.js"></script>
<script src="/assets/js/jquery.sparkline.min.js"></script>
<script src="/assets/js/flot/jquery.flot.min.js"></script>
<script src="/assets/js/flot/jquery.flot.pie.min.js"></script>
<script src="/assets/js/flot/jquery.flot.resize.min.js"></script>

<!-- ace scripts -->
<script src="/assets/js/ace-elements.min.js"></script>
<script src="/assets/js/ace.min.js"></script>

<script>
    function loginOut() {
        if (confirm("您确定要注销登录么")) {
            window.open("/logout.page","_self");
        }
    }

    $(document).ready(function () {
        $(".popstyle").removeAttr("target");
        $(".popstyle").each(function () {
            var $this = $(this)
            tmp = $this.attr("href");
            $this.attr("data", tmp);
            $this.attr("href", "javascript:void(0)");
        })

        $(".popstyle").click(function () {
            var $this = $(this)
            $("iframe").attr(
                'src',
                $this.attr("data")
            );
        });

        $(".direct").click(function () {
            var $this = $(this)
            $("iframe").attr(
                'src',
                $this.attr("data-value")
            );
        });
    });
</script>
</body>
</html>

