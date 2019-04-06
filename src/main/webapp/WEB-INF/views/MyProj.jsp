<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
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
<div id="bd" class="container" v-cloak style="width: 100%;height: 100%;background: rgb(237, 237, 237)">
    <div class="header" style="background: rgb(237, 237, 237);margin: 10px">
        <h1 class="page-header" style="font-size: 36px">
            项目管理
            <small>我的项目</small>
        </h1>
    </div>
    <div class="row table-responsive" style="text-align: center;background: rgb(237, 237, 237)">
        <table class="checkbox-round table table-hover table-responsive table-bordered "
               style="text-align: center;margin: 20px;width: 97%">
            <tr class="row">
                <td>序号</td>
                <td>项目名</td>
                <td>创建时间</td>
                <td>项目类型</td>
                <td>介绍</td>
                <td>
                    <button class="btn btn-success" v-on:click="createProj()">创建项目</button>
                </td>
            </tr>
            <tr class="row" v-for="(proj,index) in projs" v-cloak>
                <td>
                    {{index+1}}
                </td>
                <td>{{proj.name}}</td>
                <td> {{ dateFormat(proj.startdate)}}</td>
                <td>{{proj.ptname}}</td>
                <td>
                    <template v-if="proj.descr == null">
                        无
                    </template>
                    <template v-else>
                        {{proj.descr}}
                    </template>
                </td>
                <td>
                    <div class="btn-group" role="group" aria-label="...">
                        <button class="btn btn-primary " v-on:click="updateModal(proj)">修改</button>
                        <a class="btn btn-info " v-bind:href="'/toProj?id='+proj.id">管理</a>
                        <button class="btn btn-danger" v-on:click="deleteC(proj)">删除</button>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <!-- 创建项目 -->
    <div id="addModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <button class="close" data-dismiss="modal">&times;
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">添加</h1>
                </div>
                <div class="modal-body" style="overflow-y: hidden">
                    <form class="form-group" id="addForm">
                        <div class="form-group">
                            <label>项目名</label>
                            <input class="form-control" name="name"/>
                        </div>
                        <div class="form-group">
                            <label>项目类型</label>
                            <select class="form-control" name="ptid">
                                <template v-for="type in types">
                                    <option v-bind:value="type.id">{{type.name}}</option>
                                </template>

                            </select>
                        </div>
                        <div class="form-group">
                            <label>项目介绍</label>
                            <textarea class="form-control" name="descr" cols="3" rows="3">
                            </textarea>
                        </div>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="add">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改展示窗口 -->
    <div id="updateModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <button class="close" data-dismiss="modal">&times;
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">修改</h1>
                </div>
                <div class="modal-body" style="overflow-y: scroll">
                    <form id="updateForm">
                        <div class="form-group">
                            <label>项目名</label>
                            <input class="form-control" name="name"/>
                        </div>
                        <div class="form-group">
                            <label>项目类型</label>
                            <select class="form-control" name="ptid">
                                <template v-for="type in types">
                                    <template v-if="type.id==currentTypeid">
                                        <option selected v-bind:v-bind:value="type.id">{{type.name}}</option>
                                    </template>
                                    <template v-else>
                                        <option v-bind:value="type.id">{{type.name}}</option>
                                    </template>
                                </template>

                            </select>
                        </div>
                        <div class="form-group">
                            <label>项目介绍</label>
                            <textarea class="form-control" name="descr" cols="3" rows="3">
                            </textarea>
                        </div>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="update">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal">取消</button>
                        </div>
                        <input type="hidden" name="id">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
<script>
    var vu = new Vue({
            el: "#bd",
            data: {
                projs: {},
                typeFileName: {},
                types: {},
                currentTypeid: {},
            },
            mounted() {
                this.$options.methods.topage(1);
            },
            methods: {
                updateModal: function (proj) {
                    vu.currentTypeid = proj.ptid;
                    console.log(vu.currentTypeid);
                    if (Object.keys(vu.types).length == 0) {
                        var dse = $("#updateForm").find("select[name='ptid']");
                        dse.empty();
                        axios.get('${APP_PATH}/FindAllProjType')
                            .then(function (response) {
                                var result = response.data;
                                if (result.ret) {
                                    vu.types = result.data;
                                } else {
                                    alert(result.msg);
                                }
                            });
                    }
                    $("#updateForm").find("input[name='id']").val(proj.id);
                    $("#updateForm").find("input[name='name']").val(proj.name);
                    $("#updateForm").find("textarea[name='descr']").val(proj.descr);
                    $("#updateModal").modal();
                },
                update: function () {
                    var formData = new FormData($("#updateForm")[0]);
                    axios.post('${APP_PATH}/updateProj.action', formData)
                        .then(function (response) {
                            var result = response.data;
                            if (result.ret) {
                                alert("更新成功");
                                $("#updateModal").modal("hide");
                                vu.$options.methods.topage(1);
                            } else {
                                alert(result.msg);
                                $("#updateModal").modal("hide");
                            }
                        });
                },
                createProj: function () {
                    if (Object.keys(vu.types).length == 0) {
                        var dse = $("#addForm").find("select[name='ptid']");
                        dse.empty();
                        axios.get('${APP_PATH}/FindAllProjType')
                            .then(function (response) {
                                var result = response.data;
                                if (result.ret) {
                                    vu.types = result.data;
                                } else {
                                    alert(result.msg);
                                }
                            });
                    }

                    $("#addModal").modal();
                },
                add: function () {
                    var formData = new FormData($("#addForm")[0]);
                    axios.post('${APP_PATH}/insertProj.action', formData)
                        .then(function (response) {
                            var result = response.data;
                            if (result.ret) {
                                alert("创建成功");
                                $("#addModal").modal("hide");
                                vu.$options.methods.topage(1);
                            } else {
                                alert(result.msg);
                            }
                        });
                },
                topage: function (page) {
                    axios.get('${APP_PATH}/getMyProj.action')
                        .then(function (response) {
                            vu.projs = response.data.data;
                        });
                },
                deleteC: function (proj) {
                    if (confirm("您确定要删除项目" + proj.name + " ?")) {
                        axios.get('${APP_PATH}/delectProj.action?id=' + proj.id)
                            .then(function (response) {
                                var data = response.data;
                                if (data.ret) {
                                    alert("删除成功");
                                    vu.$options.methods.topage(1);
                                } else {
                                    alert(data.msg);
                                }
                            })
                    }
                },
                dateFormat: function (time) {
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
                },
            }
        })
    ;
</script>
</body>
</html>