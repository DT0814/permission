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
<div id="bd" class="container" v-cloak style="width: 100%;height: 100%;background: rgb(237, 237, 237)">
    <div class="header" style="background: rgb(237, 237, 237);margin: 10px">
        <h1 class="page-header" style="font-size: 36px">
            项目管理
            <small>所有项目</small>
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
                <td></td>
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

                        <template v-if="proj.isMy">
                            <button class="btn btn-primary " v-on:click="updateModal(proj)">修改</button>
                            <a class="btn btn-info " v-bind:href="'/toProj?id='+proj.id">管理</a>
                        </template>
                        <template v-else>
                            <a class="btn btn-info " v-bind:href="'/toOtherProj?id='+proj.id">查看</a>
                        </template>
                        <template v-if="proj.isMy">
                            <button class="btn btn-danger" v-on:click="deleteC(proj)">删除</button>
                        </template>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <!-- 文件名展示 -->
    <div id="showFileName" class="modal fade">
        <div class="modal-dialog" style="width: 40%;min-height: 40%">
            <div class="modal-content">
                <div class="modal-body">
                    <button v-on:click="addClose" class="close" data-dismiss="modal">&times;
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">文件名列表</h1>
                </div>
                <div class="modal-body" style="overflow:auto">
                    <table class="table table-hover tdWrap" style="text-align: center;table-layout:fixed;">
                        <tr>
                            <td>序号</td>
                            <td>名称</td>
                            <td><span class="btn btn-success " v-on:click="createFileName()">添加</span></td>
                        </tr>
                        <tr v-for="(fn,index) in typeFileName">
                            <td>{{index+1}}</td>
                            <td>{{fn.filename}}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="...">
                                    <button class="btn btn-primary " v-on:click="updateFileNameModal(fn)">修改</button>
                                    <button class="btn btn-danger" v-on:click="deleteFileNameC(fn)">删除</button>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 添加展示窗口 -->
    <div id="addModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <button v-on:click="addClose" class="close" data-dismiss="modal">&times;
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">添加</h1>
                </div>
                <div class="modal-body" style="overflow-y: hidden">
                    <form class="form-group" id="addForm">
                        <div class="form-group">
                            <label>项目类型名</label>
                            <input class="form-control" name="name"/>
                        </div>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="add">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal" v-on:click="addClose">取消</button>
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
                    <button class="close" v-on:click="updateClose" data-dismiss="modal">
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">修改</h1>
                </div>
                <div class="modal-body" style="overflow-y: scroll">
                    <form id="updateForm">
                        <div class="form-group">
                            <label>项目类型名</label>
                            <input class="form-control" name="name"/>
                        </div>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="update">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal" v-on:click="updateClose">取消</button>
                        </div>
                        <input type="hidden" name="id">
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 添加项目类型文件名 -->
    <div id="addFileNameModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <button v-on:click="addClose" class="close" data-dismiss="modal">&times;
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">添加</h1>
                </div>
                <div class="modal-body" style="overflow-y: hidden">
                    <form class="form-group" id="addFileNameForm">
                        <div class="form-group">
                            <label>文件名</label>
                            <input class="form-control" name="filename"/>
                        </div>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="addFileName">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal" v-on:click="addClose">取消</button>
                        </div>
                        <input type="hidden" name="ptid">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改项目类型文件名 -->
    <div id="updateFileNameModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <button class="close" v-on:click="updateClose" data-dismiss="modal">
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">修改</h1>
                </div>
                <div class="modal-body" style="overflow-y: scroll">
                    <form id="updateFileNameForm">
                        <div class="form-group">
                            <label>文件名</label>
                            <input class="form-control" name="filename"/>
                        </div>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="updateFileName">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal" v-on:click="updateClose">取消</button>
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
                ptid: {},
            },
            mounted() {
                this.$options.methods.topage(1);
            },
            methods: {
                updateModal: function (ty) {
                    $("#updateForm").find("input[name='id']").val(ty.id);
                    $("#updateForm").find("input[name='name']").val(ty.name);
                    $("#updateModal").modal();
                },
                update: function () {
                    var formData = new FormData($("#updateForm")[0]);
                    axios.post('${APP_PATH}/updateProjType.action', formData)
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
                createTpye: function () {
                    $("#addModal").modal();
                },
                add: function () {
                    var formData = new FormData($("#addForm")[0]);
                    axios.post('${APP_PATH}/insertProjType.action', formData)
                        .then(function (response) {
                            var result = response.data;
                            if (result.ret) {
                                alert("添加成功");
                                $("#addModal").modal("hide");
                                vu.$options.methods.topage(1);
                            } else {
                                alert(result.msg);
                            }
                        });
                },
                topage: function (page) {
                    axios.get('${APP_PATH}/getAllProj.action')
                        .then(function (response) {
                            vu.projs = response.data.data;
                        });
                },
                deleteC: function (ty) {
                    if (confirm("您确定要删除项目类型" + ty.name + " ?")) {
                        axios.get('${APP_PATH}/delectProjType.action?id=' + ty.id)
                            .then(function (response) {
                                var data = response.data;
                                if (data.ret) {
                                    alert("删除成功");
                                    vu.$options.methods.topage(1);
                                }
                            })
                    }
                },
                showFileNameModal: function (ty) {
                    vu.ptid = ty.id;
                    vu.$options.methods.fTopage();
                    $("#showFileName").modal();
                },
                createFileName: function () {
                    $("#addFileNameForm").find("input[name='ptid']").val(vu.ptid);
                    $("#addFileNameModal").modal();
                },
                addFileName: function () {
                    var formData = new FormData($("#addFileNameForm")[0]);
                    axios.post('${APP_PATH}/insertProjFName.action', formData)
                        .then(function (response) {
                            var result = response.data;
                            if (result.ret) {
                                alert("添加成功");
                                $("#addFileNameModal").modal("hide");
                                vu.$options.methods.fTopage(1);
                            } else {
                                alert(result.msg)
                                $("#addFileNameModal").modal("hide");
                            }
                        });
                },
                updateFileNameModal: function (fn) {
                    $("#updateFileNameForm").find("input[name='id']").val(fn.id);
                    $("#updateFileNameForm").find("input[name='filename']").val(fn.filename);
                    $("#updateFileNameModal").modal();
                },
                deleteFileNameC: function (fn) {
                    if (confirm("您确定要删除项目类型" + fn.filename + " ?")) {
                        axios.get('${APP_PATH}/delectProjFName.action?id=' + fn.id)
                            .then(function (response) {
                                var data = response.data;
                                if (data.ret) {
                                    alert("删除成功");
                                    vu.$options.methods.fTopage(fn.ptid);
                                }
                            })
                    }
                },
                updateFileName: function () {
                    var formData = new FormData($("#updateFileNameForm")[0]);
                    axios.post('${APP_PATH}/updatProjFNameById.action', formData)
                        .then(function (response) {
                            var result = response.data;
                            if (result.ret) {
                                alert("更新成功");
                                $("#updateFileNameModal").modal("hide");
                                vu.$options.methods.fTopage(1);
                            } else {
                                alert(result.msg);
                                $("#updateFileNameModal").modal("hide");
                            }
                        });
                },
                fTopage: function () {
                    axios.get('${APP_PATH}/getProjFNameByPtid.action?ptid=' + vu.ptid)
                        .then(function (response) {
                            vu.typeFileName = response.data.data;
                        });
                },
                addClose: function () {
                    $(".modal-body").scrollTop(0);
                },
                updateClose: function () {
                    $(".modal-body").scrollTop(0);
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