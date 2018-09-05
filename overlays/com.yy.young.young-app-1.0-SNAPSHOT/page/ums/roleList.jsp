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
    <title>角色管理</title>
    <script type="text/javascript">
        $(function(){
            //创建左侧单位树
            createCompanyTree("companyTree",function(event,treeId,treeNode){
                joView.setTransferParam("deptId="+treeNode.ID+"&deptName="+treeNode.NAME);
                joView.params['condition'] = "COMPANY_ID="+treeNode.ID;
                joView.select();
            });
            joView.params['condition'] = "COMPANY_ID="+loginUser.companyId;
            joView.init({grid:$("#mainList")});//初始化页面

        });
        joView.handleItem = function(oItem,iIndex){
            if(oItem["TYPE"] == "ADMIN"){
                oItem.TYPE_CN = "<plan title='管理员角色可以在指定管理范围内对系统资源执行操作' class='role_admin'>管理员角色</plan>";
            }else if(oItem["TYPE"] == "NORMAL"){
                oItem.TYPE_CN = "<plan title='普通角色具有系统内相关功能的使用权限' class='role_normal'>普通角色</plan>";
            }else{
                oItem.TYPE_CN = "<plan title='' class='role_other'>"+oItem["TYPE"]+"</plan>";
            }
        };
        function getOper(roleId){
            return "<a href='javascript:;' onclick='setAuth2Role(\""+roleId+"\")'>授权</a>";
        }
        function setAuth2Role(roleId){
            jo.showWin(URL_UMS + "page/ums/setAuthDialog.jsp?roleId="+roleId, "530px", "425px", "授权");
        }
    </script>
</head>
<style>
    .role_admin{
        color:white;background-color: red;padding: 1px 5px;
    }
    .role_normal{
        color:white;background-color: orange;padding: 0px 5px;
    }
    .role_other{
        color:white;background-color: gray;padding: 0px 5px;
    }
</style>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="NAME">角色名称&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="NAME" placeholder="角色名称" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="TYPE">角色类型&nbsp;</label>
                    <select class="form-control input-sm" id="TYPE" name="TYPE">
                        <option value=""></option>
                        <option value="ADMIN">管理员角色</option>
                        <option value="NORMAL">普通角色</option>
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
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
            <div id="companyTree" class="ztree">

            </div>
        </div>
        <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="ums/role/getRolePage.action"
                       deleteUrl="ums/role/deleteRole.action" formUrl="page/ums/roleForm.jsp">
                    <col field="NAME" title="角色名称" width="20%" align="" event="click"/>
                    <col field="RANGE_NAME" title="管理范围" width="15%" align=""/>
                    <col field="REMARK" title="备注" width="10%" align=""/>
                    <col field="TYPE_CN" title="类型" width="10%" align=""/>
                    <col field="COMPANY_NAME" title="所属单位" width="15%" align=""/>
                    <col field="NUM" title="排序" width="7%" align=""/>
                    <col field="[=getOper('{ID}')]" title="操作" width="15%" align=""/>
                    <%--<col field="[=jo.formatTime({C_CREATEDATE})]" title="发布时间" width="15%" align="center"/>--%>
                </table>
            </div>
            <%--/grid--%>

            <%--分页条--%>
            <div class="page-bar" gridId="mainList">

            </div>
            <%--/分页条--%>
        </div>
    </div>
</div>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
