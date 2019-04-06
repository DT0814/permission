<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="v-on" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>Fly Template v3.0 所有页面目录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./css/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link href="${APP_PATH }/css/custom-styles.css" rel="stylesheet"/>
    <link href="${APP_PATH }/css/checkbox3.min.css" rel="stylesheet"/>
    <link href="${APP_PATH}/css/pintuer.css" rel="stylesheet">
    <link href="${APP_PATH}/css/admin.css" rel="stylesheet">
    <script src="${APP_PATH }/js/jquery-1.12.4.js"></script>
    <script src="${APP_PATH }/css/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/js/vue.min.js"></script>
    <script src="${APP_PATH }/js/axios.min.js"></script>
    <script src="${APP_PATH }/css/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<div id="bd" class="container" v-cloak style="width: 100%;height: 100%;background: rgb(237, 237, 237)">
    <div class="header" style="background: rgb(237, 237, 237);margin: 10px">
        <h1 class="page-header" style="font-size: 36px">
            我的项目:
            <small>${ProjName}</small>
        </h1>
    </div>
    <div class="row" style="background:rgb(237, 237, 237)">
        <div class="col-md-12" style="margin: 10px">
            <div class="panel-heading">
                用户信息表
            </div>
            <table class="table table-hover table-bordered"
                   style="text-align: center" v-cloak>
                <tr>
                    <td>序号</td>
                    <td>文件名</td>
                    <td>上传时间</td>
                    <td>是否上传</td>
                    <td>操作</td>
                </tr>
                <tr v-for="(f,index) in files" v-cloak>
                    <td>{{index+1 }}</td>
                    <td>{{f.filename}}</td>
                    <td>{{ dateFormat(f.startdate)}}</td>
                    <td>
                        <template v-if="f.uid==null">
                            <div class="form-group">
                                <div class="field">
                                    <span type="text" style="height: 32px;border:1px solid #f1f1f1">
                                        暂未上传
                                    </span>
                                </div>
                            </div>
                        </template>
                        <template v-else>
                            <div class="form-group">
                                <div class="field">
                                    <span type="text" style="height: 32px;border:1px solid #f1f1f1">
                                         已上传文件名:{{f.fname}}
                                        <a class="btn btn-info " v-bind:href="'/user/downFile.action?id='+f.fid">下载</a>
                                    </span>
                                </div>
                            </div>
                        </template>
                    </td>
                    <td>
                        <div class="btn-group" role="group" aria-label="...">
                            <template v-if="f.uid==null">
                            </template>
                            <template v-else>
                                <template v-if="f.type!=0">
                                    <a class="btn btn-info " target="_blank"
                                       v-bind:href="'pdfjs/web/viewer.html?file='+ f.location">预览</a>
                                </template>
                            </template>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    var vu = new Vue({
        el: "#bd",
        data: {
            files: {},
            pfid: {},
        },
        mounted() {
            this.$options.methods.topage(1);
        },
        methods: {
            topage: function (num) {
                axios.get('${APP_PATH}/getAllFileNameAndFileByPid.action?id=' +${Pid})
                    .then(function (response) {
                        var result = response.data;
                        if (result.ret) {
                            vu.files = result.data;
                        } else {
                            alert(result.msg);
                        }
                    })
            },
            dateFormat: function (time) {
                if (null == time) {
                    return '暂未上传';
                } else {
                    var date = new Date(time);
                    var year = date.getFullYear();
                    /* 在日期格式中，月份是从0开始的，因此要加0
                     * 使用三元表达式在小于10的前面加0，以达到格式统一  如 09:11:05
                     * */
                    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                    var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                    var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                    var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
                    // 拼接
                    return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
                }
            }
        },
    });
</script>
</body>
</html>