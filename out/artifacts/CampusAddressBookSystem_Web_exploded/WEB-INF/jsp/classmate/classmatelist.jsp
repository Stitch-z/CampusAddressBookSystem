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
    <title>课程成员界面</title>

</head>
<body>
<%-- 引入公共界面布局 --%>
<%@include file="../common.jsp"%>
<div class="layui-body">
    <%-- 用于获取添加好友时的提示信息 --%>
    <input type="hidden" id="addLiaisonCheckMsg" name="addLiaisonCheckMsg" value="${addLiaisonCheckMsg}">

    <c:choose>
        <c:when test="${not empty liaisonList}">
        <form id="form1" name="form1" method="post" action="">

            <!--container表示容器，所有内容放进这个容器-->
            <div class="container" style="padding: 80px;">
                <!-- row表示 一行的宽度 -->
                <div class="row">
                    <!--col-md-4 表示使用一行的4/12宽度 -->
                    <div class="col-md-4" >
                        <h1>《${cname}》</h1>
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

                    <%--    <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addModal" data-laccount="${account}" data-lrole="${lrole}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加</button>
                        <button class="btn btn-danger" type="submit"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 批量删除</button>--%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-11">
                        <table class="table table-hover">
                            <tr >
                                <th>姓名</th>
                                <th>性别</th>
                                <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机</th>
                                <th>身份</th>
                                <th></th>
                            </tr>
                            <c:forEach items="${liaisonList}" var="liaison">
                                <tr>
                                    <td>${liaison.lname}</td>
                                    <td>${liaison.lsex}</td>
                                    <td>${liaison.lphone}</td>
                                    <td>${liaison.lrole}</td>

                                    <td>
                                        <a class="btn btn-info" href="liaisoninsert?laccount=${account}&lnumber=${liaison.lnumber}&lname=${liaison.lname}&lsex=${liaison.lsex}&lphone=${liaison.lphone}&lrole=${liaison.lrole}&caccount=${caccount}&cname=${cname}">
                                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加到通讯录
                                        </a>
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
                        <h1 style="">课程还没有成员噢！</h1><br><br><br>
                    </div>

                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<%--由于模态框script放前面无法生效，所以放在了后面--%>
<script>
    function selectByKey(a) {
        var key = $('#key').val();
        var laccount = $('#laccount').val();
        var lrole = $('#lrole').val();
        a.href="toselectliaisonlist?laccount=" + laccount + "&lrole=" + lrole + "&key=" + key;
    }

    //页面一加载就执行该函数，弹出对话框
    window.onload = function check() {
        var addLiaisonCheckMsg = $('#addLiaisonCheckMsg').val();
        if(addLiaisonCheckMsg!=''&&addLiaisonCheckMsg!=null){
            alert(addLiaisonCheckMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#addLiaisonCheckMsg').attr("value","");
        }
        else {
            return;
        }
    }

</script>