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
            //创建左侧部门树
            createOrgTree("deptTree",function(event,treeId,treeNode){
                if(treeNode.ID != "ROOT"){
                    joView.setTransferParam("deptId="+treeNode.ID+"&deptName="+treeNode.NAME+"&deptLevel="+treeNode.DEPT_LEVEL);
                }else{
                    joView.setTransferParam("");
                }
                joView.params['condition'] = "PARENT_ID="+treeNode.ID;
                joView.select();
            });
            joView.init({grid:$("#mainList")});//初始化页面
        });
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="NAME">部门名称&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="NAME" placeholder="部门名称" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="DEPT_LEVEL">部门层级&nbsp;</label>
                    <select class="form-control input-sm" id="DEPT_LEVEL" name="DEPT_LEVEL">
                        <option value=""></option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label" for="TYPE">类型&nbsp;</label>
                    <select class="form-control input-sm" id="TYPE" name="TYPE">
                        <option value=""></option>
                        <option value="DEPT">部门</option>
                        <option value="COMPANY">单位</option>
                        <option value="OTHER">其他</option>
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
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
            <div id="deptTree" class="ztree">

            </div>
        </div>
        <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="ums/dept/getDeptPage.action"
                       deleteUrl="ums/dept/deleteDept.action" formUrl="page/ums/deptForm.jsp">
                    <col field="NAME" title="部门名称" width="20%" align="" event="click"/>
                    <col field="PARENT_NAME" title="上级部门" width="20%" align=""/>
                    <col field="DEPT_LEVEL" title="部门层级" width="10%" align=""/>
                    <col field="TYPE" title="部门类型" width="20%" align=""/>
                    <col field="[=jo.formatDate('{CREATE_TIME}')]" title="创建时间" width="15%" align="center"/>
                    <col field="NUM" title="排序" width="10%" align=""/>

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
