<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./css/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script src="./js/jquery-1.12.4.js"></script>
    <script src="./js/vue.min.js"></script>
    <script src="./js/axios.min.js"></script>
    <script src="./css/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body style=";height: 100%;">
<div id="bd" class="container" v-cloak style="width: 100%;height: 100%;">
    <div class="header" style=";margin: 10px">
        <h1 class="page-header" style="font-size: 36px">
            个人信息管理
            <small>密码修改</small>
        </h1>
    </div>
    <form id="updateForm" style="width: 200px;margin:0 auto">
        <div class="form-group">
            <label>原密码</label>
            <input class="form-control" type="password" name="oldPassWord"/>
        </div>
        <div class="form-group">
            <label>新密码</label>
            <input class="form-control" type="password" name="newPassword" id="newPassword"/>
        </div>
        <div class="form-group">
            <label>确认密码</label>
            <input class="form-control" type="password" name="rePassword" id="rePassword"/>
        </div>
        <div class="text-center">
            <span class="btn btn-primary" v-on:click="update">修改</span>
        </div>
        <input type="hidden" name="uid" v-bind:value="user.id">
    </form>
</div>

<script>
    var vu = new Vue({
        el: "#bd",
        data: {
            user: {},
        },
        mounted() {
            this.$options.methods.getUser(1);
        },
        methods: {
            update: function () {
                if ($("#rePassword").val() == $("#newPassword").val()) {
                    var formData = new FormData($("#updateForm")[0]);
                    axios.post('/updatePass.action', formData)
                        .then(function (response) {
                            var result = response.data;
                            if (result.ret) {
                                alert("更新成功,请重新登录");
                                window.open("/signin.jsp", "_parent");
                            } else {
                                alert(result.msg);
                            }
                        });
                } else {
                    alert("两次密码输入不一致");
                }
            },
            getUser: function () {
                axios.get('${APP_PATH}/getUser.action?uid=' + ${user_id})
                    .then(function (response) {
                        var result = response.data;
                        if (result.ret) {
                            vu.user = result.data;
                        } else {
                            alert(result.msg);
                        }
                    });
            },
        }
    });
</script>
</body>
</html>