<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
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
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>数据字典表单</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "pms/pmsDictionary/insert.action",//新增
                    "deleteUrl" : "pms/pmsDictionary/delete.action",//删除
                    "updateUrl" : "pms/pmsDictionary/update.action",//修改
                    "formDataUrl" : "pms/pmsDictionary/get.action"	//查询
                };
                joForm.initFormPage(jParams);//初始化
            });
            //初始化表单值前处理
            joForm.initFormValueBefore = function(oJson){
            };
            //初始化新增页面
            joForm.initFormPageOfAdd = function(){
                $("#bedicId").val(jo.getUrlParam("sId"));
                $("#dicType").val(jo.getUrlParam("sName"));
            }
        </script>
</head>
<body class="">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="joForm.save()">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;保存
                </button>
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="joForm.update()">
                    <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
                </button>
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-danger" onclick="joForm.del()">
                    <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                </button>
            </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <tr>
                        <td width="15%" class="active" align="">主键</td>
                        <td class="tnt">
                            <input type="text"  name="id" class="form-control input-sm readonly-edit"/>
                        </td>
                        <td width="15%" class="active" align="">父 编 号</td>
                        <td class="tnt">
                            <input type="text"  name="pdicId" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">字 典 值</td>
                        <td class="tnt">
                            <input type="text"  name="dicValue" class="form-control input-sm" />
                        </td>
                        <td class="active" align="">字典描述</td>
                        <td class="tnt">
                            <input type="text"  name="dicDesc" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">字典类型</td>
                        <td class="tnt">
                            <input type="text" id="dicType"  name="dicType" class="form-control input-sm" />
                        </td>
                        <td class="active" align="">字典顺序</td>
                        <td class="tnt">
                            <input type="text"  name="dicNum" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">字典编码</td>
                        <td class="tnt">
                            <input type="text" id="bedicId"  name="bedicId" class="form-control input-sm" placeholder="当前配置所属字典编码"/>
                        </td>
                        <td class="active" align="">备　　注</td>
                        <td class="tnt">
                            <input type="text"  name="remark" class="form-control input-sm" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>



<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
