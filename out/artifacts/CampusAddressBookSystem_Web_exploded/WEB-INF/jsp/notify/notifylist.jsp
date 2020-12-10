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
<title>消息通知界面</title>
</head>
<body>
    <%--    引入公共界面布局--%>
    <%@include file="../common.jsp"%>

    <div class="layui-body">
        <input type="hidden" id="replyMsg" name="replyMsg" value="${replyMsg}">

        <c:choose>
            <c:when test="${not empty notifyList}">
            <form id="form1" name="form1" method="post" action="notifyDeleteSelected?nto=${account}&ntoRole=${role}&ntype=${ntype}">
                <!--container表示容器，所有内容放进这个容器-->
                <div class="container" style="padding: 80px;">
                    <!-- row表示 一行的宽度-->
                    <div class="row">
                        <!--col-md-4 表示使用一行的4/12宽度 -->
                        <div class="col-md-4" >
                            <c:if test="${ntype=='消息'}">
                                <h1>消息通知</h1>
                            </c:if>
                            <c:if test="${ntype=='短信'}">
                                <h1>收件箱</h1>
                            </c:if>
                        </div>
                    </div>
                    <hr/>
                    <div class="row" style="float:left;display:flex;width:100%;margin-top: 20px;margin-bottom: 15px;">

                        <div class="col-lg-offset-10" >
                            <%--添加模态框按钮--%>
    <%--                        <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addModal" data-caccount="${account}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加</button>--%>
                            <button class="btn btn-danger" type="submit"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 批量删除</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-11">

                            <c:forEach items="${notifyList}" var="notify">
                                <div class="panel panel-info">
                                    <div class="panel-heading">

                                        <h3 class="panel-title">
                                            <input type="checkbox" name="nnoArray" value="${notify.nno}">  来自于 ${notify.nfromName}
                                        </h3>

                                        <c:if test="${notify.nstate=='已读'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> ${notify.nstate}
                                            </div>
                                        </c:if>

                                        <c:if test="${notify.nstate=='未读'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span> ${notify.nstate}
                                            </div>
                                        </c:if>
                                        <c:if test="${notify.nstate=='已同意'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> ${notify.nstate}
                                            </div>
                                        </c:if>
                                        <c:if test="${notify.nstate=='已拒绝'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> ${notify.nstate}
                                            </div>
                                        </c:if>
                                    </div>


                                    <div class="panel-body">
                                        ${notify.ncontent}

                                        <c:if test="${role=='教师' and notify.nstate=='未审核'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <a class="btn btn-success" href="notifyExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&nto=${notify.nto}&ntoName=${notify.ntoName}&ncourse=${notify.ncourse}&ncontent=${notify.ncontent}&nstate=已同意&ntype=消息"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 同意</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                                <a class="btn btn-warning"  href="notifyExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&nto=${notify.nto}&ntoName=${notify.ntoName}&ncourse=${notify.ncourse}&ncontent=${notify.ncontent}&nstate=已拒绝&ntype=消息"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 拒绝</a>
                                            </div>
                                        </c:if>


                                        <c:if test="${role=='管理员' and notify.nstate=='未审核'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <a class="btn btn-success" href="notifyAdminExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&ncourse=${notify.ncourse}&ncourseName=${notify.ncourseName}&ncourseTaccount=${notify.ncourseTaccount}&ncourseTeacher=${notify.ncourseTeacher}&ncontent=${notify.ncontent}&nstate=已同意&ntype=消息"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 同意</a>
                                                <a class="btn btn-warning" href="notifyAdminExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&ncourse=${notify.ncourse}&ncourseName=${notify.ncourseName}&ncourseTaccount=${notify.ncourseTaccount}&ncourseTeacher=${notify.ncourseTeacher}&ncontent=${notify.ncontent}&nstate=已拒绝&ntype=消息"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 拒绝</a>
                                            </div>
                                        </c:if>

                                        <c:if test="${notify.nstate=='未读' and notify.ntype=='消息'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <a class="btn btn-info" href="updateNotify?nno=${notify.nno}&nto=${notify.nto}&nstate=已读&ntype=消息"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 已读</a>
    <%--                                        <a class="btn btn-warning" style="float:right;" href="notifyExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nto=${notify.nto}&ncontent=${notify.ncontent}&nstate=已拒绝"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 拒绝</a>--%>
                                            </div>
                                        </c:if>

                                        <c:if test="${notify.nstate=='未读' and notify.ntype=='短信'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <a class="btn btn-info" href="updateNotify?nno=${notify.nno}&nto=${notify.nto}&nstate=已读&ntype=短信"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 已读</a>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sendModal"
                                                        data-nfrom="${notify.nfrom}" data-nto="${notify.nto}" data-ntoname="${notify.nfromName}">
                                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> 回复
                                                </button>
                                            </div>
                                        </c:if>

                                        <c:if test="${notify.nstate=='已读' and notify.ntype=='短信'}">
                                            <div align="right" style="margin-top: -18px;">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sendModal"
                                                        data-nfrom="${notify.nfrom}" data-nto="${notify.nto}" data-ntoname="${notify.nfromName}">
                                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> 回复
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
    <%--
                            <table class="table table-hover">
                                <tr >
                                    <th>选择</th>
                                    <th>来自</th>
                                    <th>消息内容</th>
                                    <th>状态</th>
                                    <th></th>
                                </tr>
                                <c:forEach items="${notifyList}" var="notify">
                                    <tr>
                                        <td><input type="checkbox" name="nnoArray" value="${notify.nno}"></td>
                                        <td>${notify.nfromName}</td>
                                        <td>${notify.ncontent}</td>
                                        <td>${notify.nstate}</td>
                                        <td>
    &lt;%&ndash;
                                            <!-- 模态框按钮，要传值过去 -->
                                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#updateModal" data-caccount="${account}" data-cno="${care.cno}" data-cname="${care.cname}" data-csex="${care.csex}" data-cphone="${care.cphone}" data-caddress="${care.caddress}">
                                                <span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span> 修改
                                            </button>
                                            &lt;%&ndash; 移出特别关心名单的话，就只是单纯地将其从特别关心表删除 &ndash;%&gt;
                                            <c:if test="${role=='教师' and notify.nstate=='未审核'}">
                                                <a class="btn btn-success" href="notifyExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&nto=${notify.nto}&ntoName=${notify.ntoName}&ncourse=${notify.ncourse}&ncontent=${notify.ncontent}&nstate=已同意&ntype=消息"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 同意</a>
                                                &lt;%&ndash; 拉黑特别关心名单的话，就是将其从特别关心表删除且加入黑名单 &ndash;%&gt;
                                                <a class="btn btn-warning" href="notifyExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&nto=${notify.nto}&ntoName=${notify.ntoName}&ncourse=${notify.ncourse}&ncontent=${notify.ncontent}&nstate=已拒绝&ntype=消息"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 拒绝</a>
                                            </c:if>


                                            <c:if test="${role=='管理员' and notify.nstate=='未审核'}">
                                                <a class="btn btn-success" href="notifyAdminExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&ncourse=${notify.ncourse}&ncourseName=${notify.ncourseName}&ncourseTaccount=${notify.ncourseTaccount}&ncourseTeacher=${notify.ncourseTeacher}&ncontent=${notify.ncontent}&nstate=已同意&ntype=消息"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 同意</a>
                                                &lt;%&ndash; 拉黑特别关心名单的话，就是将其从特别关心表删除且加入黑名单 &ndash;%&gt;
                                                <a class="btn btn-warning" href="notifyAdminExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nfromName=${notify.nfromName}&ncourse=${notify.ncourse}&ncourseName=${notify.ncourseName}&ncourseTaccount=${notify.ncourseTaccount}&ncourseTeacher=${notify.ncourseTeacher}&ncontent=${notify.ncontent}&nstate=已拒绝&ntype=消息"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 拒绝</a>
                                            </c:if>

                                            <c:if test="${notify.nstate=='未读' and notify.ntype=='消息'}">
                                                <a class="btn btn-info" href="updateNotify?nno=${notify.nno}&nto=${notify.nto}&nstate=已读&ntype=消息"> <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 已读</a>
                                                &lt;%&ndash; 拉黑特别关心名单的话，就是将其从特别关心表删除且加入黑名单
                                                <a class="btn btn-warning" href="notifyExamine?nno=${notify.nno}&nfrom=${notify.nfrom}&nto=${notify.nto}&ncontent=${notify.ncontent}&nstate=已拒绝"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 拒绝</a>&ndash;%&gt;
                                            </c:if>

                                            <c:if test="${notify.ntype=='短信'}">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sendModal"
                                                        data-nfrom="${notify.nfrom}" data-nto="${notify.nto}" data-ntoname="${notify.nfromName}">
                                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> 回复
                                                </button>
                                            </c:if>

                                        </td>

                                    </tr>
                                </c:forEach>
                            </table>--%>
                        </div>
                    </div>
                </div>
            </form>
            </c:when>
            <c:otherwise>
                <div class="container" style="padding-left: 50px;padding-top: 10%;padding-right: 110px">
                    <div class="jumbotron" style="width: 970px;height: 470px;">
                        <div style="text-align: center;margin-top: 10%;">
                            <h1 style="">空空如也！</h1><br><br><br>
                        </div>

                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>


    <!-- 发送短信模态框 -->
    <div class="modal fade" id="sendModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <form action="replyMsg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel3">短信</h3>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" id="nfrom" name="nfrom" class="form-control"></input>
                        <input type="hidden" id="nto" name="nto" class="form-control"></input>
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

</body>
</html>

<script>

    function selectByKey(a) {
        var key = $('#key').val();
        var caccount = $('#caccount').val();
        a.href="toselectcarelist?caccount=" + caccount + "&key=" + key;
    }

    $('#sendModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var modal = $(this)
        modal.find('#nfrom').val(button.data('nfrom'));
        modal.find('#nto').val(button.data('nto'));
        modal.find('#ntoName').val(button.data('ntoname'));
    })

    //页面一加载就执行该函数，弹出对话框
    window.onload = function addBlack() {
        var replyMsg = $('#replyMsg').val();
        if(replyMsg!=''&&replyMsg!=null){
            alert(replyMsg);
            //blackMsg置为空，就不会加载重复弹出
            $('#replyMsg').attr("value","");
        }
        else {
            return;
        }
    }
</script>

