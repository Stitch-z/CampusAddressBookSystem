<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://www.layuicdn.com/layui-v2.5.0/css/layui.css">
    <script src="https://www.layuicdn.com/layui-v2.5.0/layui.js"></script>
    <script>
        //导航栏
        //注意：导航 依赖 element 模块，否则无法进行功能性操作
        layui.use('element', function(){
            var element = layui.element;

        });

    </script>



</head>
<body >

<div class="layui-layout layui-layout-admin">
    <div class="layui-header layui">
        <div class="layui-logo">校园通讯录管理系统</div>
        <%--            <ul class="layui-nav layui-layout-left">
                        <li class="layui-nav-item"><a href="">联系人</a></li>
                        <li class="layui-nav-item"><a href="">通话记录</a></li>
                        <li class="layui-nav-item"><a href="">特别关心</a></li>
                        <li class="layui-nav-item">
                            <a href="javascript:;">其它系统</a>
                            <dl class="layui-nav-child">
                                <dd><a href="">邮件管理</a></dd>
                                <dd><a href="">消息管理</a></dd>
                                <dd><a href="">授权管理</a></dd>
                            </dl>
                        </li>

                    </ul>--%>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="">${role}：${name}</a>
                <dl class="layui-nav-child">
                    <dd><a href="userlist?uaccount=${account}">个人信息</a></dd>
                    <dd><a href="toUpdatePwd?uaccount=${account}&pwd=${pwd}">修改密码</a></dd>
                    <dd><a href="out">退出</a></dd>
                </dl>

            </li>

        </ul>

    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <c:if test="${role=='学生'}">
                        <a href="javascript:;">通讯录</a>
                        <dl class="layui-nav-child">
                            <dd><a href="liaisonlist?laccount=${account}&lrole=学生">同学</a></dd>
                            <dd><a href="liaisonlist?laccount=${account}&lrole=教师">老师</a></dd>
                        </dl>
                    </c:if>
                    <c:if test="${role=='教师'}">
                        <a href="javascript:;">通讯录</a>
                        <dl class="layui-nav-child">
                            <dd><a href="liaisonlist?laccount=${account}&lrole=学生">学生</a></dd>
                            <dd><a href="liaisonlist?laccount=${account}&lrole=教师">同事</a></dd>
                        </dl>
                    </c:if>
                </li>
                <c:if test="${role=='学生'}">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;">大学课程</a>
                        <dl class="layui-nav-child">
                            <dd><a href="courselist?saccount=${account}&flag=all">所有课程</a></dd>
                            <dd><a href="courselist?saccount=${account}&flag=selected">已选课程</a></dd>
                            <dd><a href="courselist?saccount=${account}&flag=notSelected">未选课程</a></dd>
                        </dl>
                    </li>
                </c:if>
                <c:if test="${role=='教师'}">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;">大学课程</a>
                        <dl class="layui-nav-child">
                            <dd><a href="courselist?saccount=${account}&flag=all">所有课程</a></dd>
                            <dd><a href="teacherCourselist?taccount=${account}&flag=teach">所教课程</a></dd>
                        </dl>
                    </li>
                </c:if>
                <c:if test="${role=='管理员'}">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;">管理所有账号</a>
                        <dl class="layui-nav-child">
                            <dd><a href="findAllUser?urole=学生">所有学生账号</a></dd>
                            <dd><a href="findAllUser?urole=教师">所有教师账号</a></dd>
                            <dd><a href="findAllUser?urole=管理员">所有管理员账号</a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="courselist?flag=all">管理所有课程</a>
                    </li>
                </c:if>

                <c:if test="${role=='学生' or role=='教师'}">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="notifylist?nto=${account}&ntype=短信">收件箱</a>
                    </li>
                </c:if>

<%--                    <li class="layui-nav-item"><a href="historylist?haccount=${account}">通话记录</a></li>--%>
<%--                    <li class="layui-nav-item"><a href="">老师</a></li>--%>
<%--                    <li class="layui-nav-item"><a href="blacklist?baccount=${account}">黑名单</a></li>--%>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="notifylist?nto=${account}&role=${role}&ntype=消息">消息通知</a>
                </li>
            </ul>
        </div>
    </div>

</div>

</body>
</html>
