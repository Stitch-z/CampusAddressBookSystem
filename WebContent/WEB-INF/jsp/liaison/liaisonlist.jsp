<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
<title>联系人页面</title>

</head>
<body>
    <%-- 引入公共界面布局 --%>
    <%@include file="../common.jsp"%>
    <div class="layui-body">
        <%-- 用于获取添加好友时的提示信息 --%>
        <input type="hidden" id="addLiaisonCheckMsg" name="addLiaisonCheckMsg" value="${addLiaisonCheckMsg}">

        <%-- 用于发送短信时的提示信息 --%>
        <input type="hidden" id="sendMsg" name="sendMsg" value="${sendMsg}">

        <c:choose>
            <c:when test="${not empty liaisonList}">
                <form id="form1" name="form1" method="post" action="liaisonDeleteSelected?laccount=${account}&lrole=${lrole}">

                    <!--container表示容器，所有内容放进这个容器-->
                    <div class="container" style="padding: 80px;">
                        <!-- row表示 一行的宽度 -->
                        <div class="row">
                            <!--col-md-4 表示使用一行的4/12宽度 -->
                            <div class="col-md-4" >
                                <c:if test="${role=='学生'}">
                                    <c:if test="${lrole=='学生'}">
                                        <h1>同学</h1>
                                    </c:if>
                                    <c:if test="${lrole=='教师'}">
                                        <h1>老师</h1>
                                    </c:if>
                                </c:if>
                                <c:if test="${role=='教师'}">
                                    <c:if test="${lrole=='学生'}">
                                        <h1>学生</h1>
                                    </c:if>
                                    <c:if test="${lrole=='教师'}">
                                        <h1>同事</h1>
                                    </c:if>
                                </c:if>

                            </div>
                        </div>
                        <hr/>
                        <div class="row" style="float:left;display:flex;width:100%;margin-top: 35px;margin-bottom: 8px;">
                            <div class="input-group" style="margin-left: 12px">
                                <%-- 这个是为了在js中获取到--%>
                                <input id="laccount" type="hidden" value="${account}">
                                <input id="lrole" type="hidden" value="${lrole}">

                                <input id="key" type="text" class="form-control" style="width: 250px" placeholder="输入姓名或者电话号码关键字">
                                <span class="input-group-btn"><a class="btn btn-default" onclick="selectByKey(this)">查询</a></span>
                            </div>


                            <div class="col-md-4 col-md-offset-4" >
                                <%--  添加模态框按钮--%>

                                <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addModal" data-laccount="${account}" data-lrole="${lrole}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加</button>
                                <button class="btn btn-danger" type="submit"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 批量删除</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-11">
                                <table class="table table-hover">
                                    <tr >
                                        <th>选择</th>
                                        <th>姓名</th>
                                        <th>性别</th>
                                        <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机</th>
                                        <th>身份</th>
                                        <th></th>
                                    </tr>
                                    <c:forEach items="${liaisonList}" var="liaison">
                                        <tr>
                                            <td><input type="checkbox" name="lnoArray" value="${liaison.lno}"></td>
                                            <td>${liaison.lname}</td>
                                            <td>${liaison.lsex}</td>
                                            <td>${liaison.lphone}</td>
                                            <td>${liaison.lrole}</td>
                                            <td>
                                                <!-- 修改模态框按钮，要传值过去 -->
                                                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#updateModal"
                                                        data-laccount="${account}" data-lno="${liaison.lno}" data-lname="${liaison.lname}"
                                                        data-lsex="${liaison.lsex}" data-lphone="${liaison.lphone}" data-lrole="${lrole}">
                                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span> 修改
                                                </button>

                                                <!-- 发送短信模态框按钮，要传值过去 -->
                                                <c:if test="${role=='学生' or role=='教师'}">
                                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sendModal"
                                                            data-nfrom="${account}" data-nto="${liaison.lnumber}" data-ntoname="${liaison.lname}"
                                                            data-lrole="${lrole}">
                                                        <span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> 发送消息
                                                    </button>
                                                </c:if>

        <%--                                        <a class="btn btn-primary" href="liaisonJoinCarelist?caccount=${liaison.laccount}&cno=${liaison.lno}&cname=${liaison.lname}&csex=${liaison.lsex}&cphone=${liaison.lphone}"> <span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 关注</a>--%>

        <%--                                        <a class="btn btn-danger" href="liaisonJoinBlacklist?baccount=${liaison.laccount}&bname=${liaison.lname}&bsex=${liaison.lsex}&bphone=${liaison.lphone}&baddress=${liaison.laddress}"> <span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span> 拉黑</a>--%>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
            <div class="container" style="padding-left: 50px;padding-top: 10%;padding-right: 110px">
                <div class="jumbotron" style="width: 970px;height: 470px;">
                    <div style="text-align: center;margin-top: 10%;">
                        <h1 style="">还没有联系人哦！！！</h1><br><br><br>
                        <button class="btn btn-success btn-lg" data-toggle="modal" data-target="#addModal" data-laccount="${account}" data-lrole="${lrole}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加联系人</button>
                    </div>

                </div>
            </div>

            </c:otherwise>
        </c:choose>
    </div>

    <!-- 修改模态框 -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <form action="liaisonupdate">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel">修改联系人信息</h3>
                    </div>

                    <div class="modal-body">

                            <input type="hidden" id="laccount2" name="laccount" class="form-control"></input>
                            <input type="hidden" id="lno" name="lno" class="form-control"></input>
                            <input type="hidden" id="lrole2" name="lrole" class="form-control"></input>
                            <div class="form-group">
                                <label class="control-label">姓名：</label>
                                <input type="text" id="lname" name="lname" class="form-control"></input>
                            </div>
                            <div class="form-group">
                                <label class="control-label">性别：</label>
                                <input type="text" id="lsex" name="lsex" class="form-control"></input>
                            </div>
                            <div class="form-group">
                                <label class="control-label">手机号码：</label>
                                <input type="text" id="lphone" name="lphone" class="form-control"></input>
                            </div>

                            <%--  为了获取修改后的手机号码从而可以查询没修改手机号码前的通讯记录--%>
                            <input type="hidden" id="prephone" name="prephone" class="form-control"></input>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div>
    </div>


    <!-- 发送短信模态框 -->
    <div class="modal fade" id="sendModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <form action="sendMsg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel3">短信</h3>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" id="nfrom" name="nfrom" class="form-control"></input>
                        <input type="hidden" id="nto" name="nto" class="form-control"></input>
                        <input type="hidden" id="lrole4"  name="lrole" class="form-control"></input>
<%--                        <input type="hidden" id="lrole2" name="lrole" class="form-control"></input>--%>
                        <div class="form-group">
                            <label class="control-label">发送给：</label>
                            <input type="text" readonly="" id="ntoName" name="ntoName" class="form-control"></input>
                        </div>

                        <div class="form-group">
                            <label class="control-label">短信内容：</label>
                            <textarea type="text" id="ncontent" name="ncontent" style="height: 150px;" class="form-control"></textarea>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">发送</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- 添加模态框 -->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <form action="liaisoninsert">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel2">添加联系人</h3>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" id="laccount3"  name="laccount" class="form-control"/>
                        <input type="hidden" id="lrole3"  name="lrole" class="form-control"/>

                        <div class="form-group">
                            <label class="control-label">编号：</label>
                            <input type="text" name="lnumber" class="form-control"></input>
                        </div>

                        <div class="form-group">
                            <label class="control-label">姓名：</label>
                            <input type="text" name="lname" class="form-control"></input>
                        </div>
                        <div class="form-group">
                            <label class="control-label">性别：</label>
                            <input type="text" name="lsex" class="form-control"></input>
                        </div>
                        <div class="form-group">
                            <label class="control-label">手机号码：</label>
                            <input type="text" name="lphone" class="form-control"></input>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>

<%--由于模态框script放前面无法生效，所以放在了后面--%>
<script>
    function selectByKey(a) {
        var key = $('#key').val();
        var laccount = $('#laccount').val();
        var lrole = $('#lrole').val();
        a.href="toselectliaisonlist?laccount=" + laccount + "&lrole=" + lrole + "&key=" + key;
    }

    $('#updateModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
        modal.find('#laccount2').val(button.data('laccount'));
        modal.find('#lno').val(button.data('lno'));
        modal.find('#lname').val(button.data('lname'));
        modal.find('#lsex').val(button.data('lsex'));
        modal.find('#lphone').val(button.data('lphone'));
        modal.find('#lrole2').val(button.data('lrole'));
        modal.find('#prephone').val(button.data('lphone'));
    })

    $('#sendModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
        modal.find('#nfrom').val(button.data('nfrom'));
        modal.find('#nto').val(button.data('nto'));
        modal.find('#ntoName').val(button.data('ntoname'));
        modal.find('#lrole4').val(button.data('lrole'));
    })

    $('#addModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
        modal.find('#laccount3').val(button.data('laccount'));
        modal.find('#lrole3').val(button.data('lrole'));
    })

    //页面一加载就执行该函数，弹出对话框
    window.onload = function check() {
        var addLiaisonCheckMsg = $('#addLiaisonCheckMsg').val();
        var sendMsg = $('#sendMsg').val();
        if(addLiaisonCheckMsg!=''&&addLiaisonCheckMsg!=null){
            alert(addLiaisonCheckMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#addLiaisonCheckMsg').attr("value","");
        }
        else if(sendMsg!=''&&sendMsg!=null){
            alert(sendMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#sendMsg').attr("value","");
        }
        else {
            return;
        }
    }

</script>