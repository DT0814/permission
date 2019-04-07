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
                                <button class="btn btn-primary " v-on:click="uploadModal(f)">上传</button>
                            </template>
                            <template v-else>
                                <button class="btn btn-primary " v-on:click="updateFileModal(f)">修改</button>
                                <template v-if="f.type!=0">
                                    <a class="btn btn-info " target="_blank"
                                       v-bind:href="'pdfjs/web/viewer.html?file='+ f.location">预览</a>
                                </template>
                                <button class="btn btn-danger " v-on:click="deleteFile(f)">删除</button>
                            </template>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 进度条 -->
    <div id="jdModal" class="modal fade" style="z-index: 2000">
        <div class="modal-dialog" style="width: 350px;">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="progress">
                        <div class="progress-bar progress-bar-info progress-bar-striped active" style="width: 50%;">
                            <div class="progress-value" name="value">50%</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 上传 -->
    <div id="uploadModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 400px">
                <div class="modal-body">
                    <button class="close" data-dismiss="modal">
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">上传文件</h1>
                </div>
                <div class="modal-body" style="width: 400px">
                    <form id="uplaodFrom">
                        <div class="form-group">
                            <div class="field">
                                <div class="report-file">
                                    <span>上传文件</span>
                                    <input tabindex="3" size="3"
                                           name="file" class="file-prew" type="file"
                                           onchange="document.getElementById('uplaodLable').value=this.value">
                                </div>
                                <br/>
                                <input type="text" id="uplaodLable"
                                       style="height: 40px;border:1px solid #f1f1f1;width: 70%"/>
                            </div>
                        </div>
                        <input type="hidden" name="pid"/>
                        <input type="hidden" name="pfid"/>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="upload">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改 -->
    <div id="updateFileModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 400px">
                <div class="modal-body">
                    <button class="close" data-dismiss="modal">
                    </button>
                </div>
                <div class="modal-title">
                    <h1 class="text-center">修改</h1>
                </div>
                <div class="modal-body" style="width: 400px">
                    <form id="updateFileForm">
                        <div class="form-group">
                            <div class="field">
                                <div class="report-file">
                                    <span>修改文件</span>
                                    <input tabindex="3" size="3"
                                           name="file" class="file-prew" type="file"
                                           onchange="document.getElementById('updateFileLable').value=this.value">
                                </div>
                                <br/>
                                <input type="text" id="updateFileLable"
                                       style="height: 40px;border:1px solid #f1f1f1;width: 70%"/>
                            </div>
                        </div>
                        <input type="hidden" name="id"/>
                        <div class="text-right">
                            <span class="btn btn-primary" v-on:click="update">提交</span>
                            <button class="btn btn-danger" data-dismiss="modal">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</div>


<script type="text/javascript">
    var vu = new Vue({
        el: "#bd",
        data: {
            files: {},
            pfid: {},
            pid: {},
        },
        mounted() {
            this.$options.methods.topage(1);
            this.pid = ${Pid};
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
            upload: function () {
                $("#jdModal").modal({backdrop: 'static', keyboard: false});
                var div = $("#jdModal").find("div[name='value']");
                var formData = new FormData($("#uplaodFrom")[0]);
                let config = {
                    onUploadProgress: function (progressEvent) {
                        var complete = (progressEvent.loaded / progressEvent.total * 100 | 0)
                        div.html(complete + "%");
                        div.parent().attr("style", "width: " + complete + "%;");
                        this.jindu = complete
                    },
                    headers: {'Content-Type': 'multipart/form-data'}
                };
                axios.post('${APP_PATH}/upFile.action', formData, config)
                    .then(function (response) {
                        $("#jdModal").modal("hide");
                        var result = response.data;
                        if (result.ret) {
                            alert("添加成功");
                        } else {
                            alert(result.msg);
                        }
                        vu.$options.methods.topage(1);
                        $("#uploadModal").modal("hide");
                    });
            },
            update: function () {
                $("#jdModal").modal({backdrop: 'static', keyboard: false});
                var div = $("#jdModal").find("div[name='value']");
                var formData = new FormData($("#updateFileForm")[0]);
                let config = {
                    onUploadProgress: function (progressEvent) {
                        var complete = (progressEvent.loaded / progressEvent.total * 100 | 0)
                        div.html(complete + "%");
                        div.parent().attr("style", "width: " + complete + "%;");
                        this.jindu = complete
                    },
                    headers: {'Content-Type': 'multipart/form-data'}
                };
                axios.post('${APP_PATH}/updateFile.action', formData, config)
                    .then(function (response) {
                        $("#jdModal").modal("hide");
                        var result = response.data;
                        if (result.ret) {
                            alert("修改成功");
                        } else {
                            alert(result.msg);
                        }
                        vu.$options.methods.topage(1);
                        $("#updateFileModal").modal("hide");
                    });
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
            },
            uploadChange: function (event, id) {
                $("#uploadLable" + id).text($(event.currentTarget).val());
            },
            uploadModal: function (f) {
                vu.$options.methods.emptyFrom($("#uplaodFrom").find("input"));
                $("#uplaodFrom").find("input[name='pfid']").val(f.id);
                $("#uplaodFrom").find("input[name='pid']").val(vu.pid);
                $("#uploadModal").modal();
            },
            updateFileModal: function (f) {
                vu.$options.methods.emptyFrom($("#updateFileForm").find("input"));
                $("#updateFileForm").find("input[name='id']").val(f.fid);
                $("#updateFileModal").modal();
            },
            deleteFile: function (f) {
                if (confirm("您确定要删除文件" + f.fname + " ?")) {
                    axios.get('${APP_PATH}/delectFile.action?id=' + f.fid).then(function (response) {
                        var data = response.data;
                        if (data.ret) {
                            alert("删除成功");
                        } else {
                            alert(data.msg);
                        }
                        vu.$options.methods.topage(1);
                    })
                }
            },
            emptyFrom: function (ele) {
                $.each(ele, function () {
                    $(this).val("");
                })
            },
        },
    });
</script>
</body>
</html>