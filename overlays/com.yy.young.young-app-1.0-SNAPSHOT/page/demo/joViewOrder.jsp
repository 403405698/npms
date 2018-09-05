<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp"%>
    <%--jo--%>
    <%@ include file="/common/joHead.jsp"%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title></title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList")});//初始化页面
        });
        joView.handleItem = function(oItem, iIndex){
            oItem.STATE = (oItem.STATE == 1 ? "<font color='green'>启用</font>" : "<font color='red'>禁用</font>") + "&nbsp;<a href='javascript:changeState(\""+oItem.STATE+"\",\""+oItem.ID+"\");' title='切换状态'><i class=\"fa fa-exchange\" aria-hidden=\"true\"></i></a>";
            oItem.SEX = oItem.SEX == 1 ? "男" : "女";
        };
        //切换状态
        function changeState(oldState, id){
            var state = oldState == 1 ? 0 : 1;
            jo.postAjax("{URL_UMS}ums/user/updateUser.action", {STATE:state,ID:id}, function(json){
                if(json && json.code == 0){
                    jo.showMsg("状态切换成功!");
                    joView.reloadCurrentPage();
                }else{
                    jo.showMsg(jo.getDefVal(json.info, "切换失败"));
                }
            });
        }
        //密码重置
        function resetPassword(){
            var ids = jo.getCheckBoxValue("ID");
            if(jo.isValid(ids)){
                jo.confirm("确定要将选中用户的密码重置?", function(){
                    jo.postAjax("{URL_UMS}ums/user/resetPassword.action", {ids:ids}, function(json){
                        if(json && json.code == 0){
                            jo.showMsg("密码重置成功!");
                        }else{
                            jo.showMsg(jo.getDefVal(json.info, "密码重置失败"));
                        }
                    });
                });
            }else{
                jo.alert("请勾选需要密码重置的用户!");
            }
        }
        //打开给用户分配角色弹窗
        var loaded = false;
        function toSetRole2User(){
            var users = jo.getCheckBoxValue();
            if(jo.isValid(users)){
                if(!loaded){
                    createRoleTree("setRoleDialog", null, true);
                    loaded = true;
                }
                jo.showDialog($("#setRoleDialog"), "choiceRole", true, {btn:"确定", yes:function(){
                    var roles = jo.getZTreeCheckedNodesIds("setRoleDialog");
                    if(jo.isValid(roles)){
                        jo.postAjax("{URL_UMS}ums/role/batchMakeUserAndRole.action",{userId:users,roleId:roles},function(json){
                            if(json && json.code == 0){
                                jo.showMsg("操作成功!");
                            }else{
                                jo.showMsg(jo.getDefVal(json.info, "操作失败!"));
                            }
                        });
                    }
                    jo.close("choiceRole");
                }});
            }else{
                jo.alert("请勾选待操作用户!");
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="NAME">姓名&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="NAME" placeholder="用户名" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="SEX">性别&nbsp;</label>
                    <select class="form-control input-sm" id="SEX" name="SEX">
                        <option value=""></option>
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="joView.select()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
            </form>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.add()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="resetPassword()">
                    <i class="fa fa-undo" aria-hidden="true"></i>&nbsp;密码重置
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="toSetRole2User()">
                    <i class="fa fa-at" aria-hidden="true"></i>&nbsp;分配角色
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--grid--%>
            <div class="table-responsive">
                <table id="mainList" class="table table-bordered table-hover table-striped table-condensed" dataUrl="ums/user/getUserPage.action"
                       deleteUrl="ums/user/deleteUser.action" formUrl="page/ums/userForm.jsp">
                    <%--<col field="ID" title="编号" width="10%" align="left"/>--%>
                    <col field="{NAME}" title="姓名" width="15%" align="center" event="click"/>
                    <col field="ACCOUNT" title="账号" width="10%" align=""/>
                    <col field="BIRTHDAY" title="出生日期" width="10%" align="" order="BIRTHDAY"/>
                    <col field="SEX" title="性别" width="5%" align=""/>
                    <col field="TEL" title="电话" width="10%" align="left"/>
                    <col field="EMAIL" title="邮箱" width="20%" align="left"/>
                    <col field="COMPANY_NAME" title="单位" width="10%" align=""/>
                    <col field="STATE" title="状态" width="10%" align=""/>
                    <col field="NUM" title="排序" width="5%" align=""/>
                    <%--<col field="[=jo.formatTime({C_CREATEDATE})]" title="发布时间" width="15%" align="center"/>--%>
                </table>
            </div>
            <%--/grid--%>
            <%--分页条--%>
            <div class="page-bar" gridId="mainList">
                <%--<div class="pull-left">当前第1页，每页
                <select class="input-sm">
                    <option value=""></option>
                    <option value="20">20</option>
                    <option value="100">100</option>
                </select>
                条，共100条记录</div>
                <ul class="pagination pull-right">
                    <li><a>首页&lt;%&ndash;&laquo;&ndash;%&gt;</a></li>
                    <li class="disabled"><a>上一页</a></li>
                    <li><a>1</a></li>
                    <li class="active"><a>2</a></li>
                    <li><a>3</a></li>
                    <li><a>下一页</a></li>
                    <li><a>尾页&lt;%&ndash;&raquo;&ndash;%&gt;</a></li>
                </ul>--%>
            </div>
            <%--/分页条--%>
        </div>
    </div>
</div>



<div id="setRoleDialog" class="ztree" style="display: none;">

</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
