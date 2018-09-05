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
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>部门表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "ID",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "ums/dept/insertDept.action",//新增
                "deleteUrl" : "ums/dept/deleteDept.action",//删除
                "updateUrl" : "ums/dept/updateDept.action",//修改
                "formDataUrl" : "ums/dept/getDeptList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //部门名称发生变化时设置部门简称
        function setShortName(str){
            $("#SHORT_NAME").val(jo.getDefVal(str, ""));
        }
        //初始化新增页
        joForm.initFormPageOfAdd = function(){
            $("#PARENT_ID").val(jo.getUrlParam("deptId"));
            $("#PARENT_NAME").val(jo.getUrlParam("deptName"));
            if(jo.isValid(jo.getUrlParam("deptLevel"))){
                $("#DEPT_LEVEL").val(parseInt(jo.getUrlParam("deptLevel"))+1);
            }
        };
    </script>
</head>
<body class="padding-15">
<%--按钮栏--%>
<div class="form-group button-bar">
    <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;新增
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.update()">
        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.del()">
        <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
    </button>
</div>
<%--按钮栏--%>
<form id="pageForm" name="pageForm" action="" method="post">
        <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <%--<table class="joForm"  cellpadding="3" cellspacing="0">--%>
            <tr>
                <td width="15%" class="active" align="">编　　号</td>
                <td class="tnt">
                    <%--<input type="text" name="ID"/>--%>
                    <input type="text" name="ID" class="form-control input-sm" placeholder="编号为空时将使用系统默认值">
                </td>

                <td width="15%" class="active must">部门名称</td>
                <td>
                    <input type="text" name="NAME" class="form-control input-sm" ErrEmpty onchange="setShortName(this.value)">
                </td>
            </tr>
            <tr>
                <td class="active">类　　型</td>
                <td>
                    <%--<input type="text" name="TYPE" class="form-control input-sm">--%>
                    <select class="form-control input-sm" name="TYPE">
                        <option value="DEPT">部门</option>
                        <option value="COMPANY">单位</option>
                        <option value="OTHER">其他</option>
                    </select>
                </td>
                <td class="active">创建时间</td>
                <td>
                    <input type="text" name="CREATE_TIME" <%--onclick="laydate()"--%> readonly class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active must">部门简称</td>
                <td>
                    <input type="text" id="SHORT_NAME" name="SHORT_NAME" class="form-control input-sm" ErrEmpty>
                </td>
                <td class="active must">上级部门</td>
                <td>
                    <%--<input type="text" name="PARENT_ID" style="width:calc(100% - 65px);"/>
                    <input type="button" value="选择" onClick=""/>--%>
                    <div class="input-group">
                        <input type="hidden" id="PARENT_ID" name="PARENT_ID" class="form-control input-sm" ErrEmpty="上级部门不可以为空">
                        <input type="text" id="PARENT_NAME" name="PARENT_NAME" class="form-control input-sm">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceOrg()">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                </td>

            </tr>
            <tr>
                <td class="active must">部门层级</td>
                <td>
                    <input type="text" id="DEPT_LEVEL" name="DEPT_LEVEL" value="1" class="form-control input-sm" ErrEmpty>
                </td>
                <td class="active must">排　　序</td>
                <td>
                    <input type="text" name="NUM" value="99" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>
            <tr>
                <td class="active">编号全路径</td>
                <td>
                    <input type="text" name="WHOLE_ID" readonly class="form-control input-sm">
                </td>
                <td class="active">名称全路径</td>
                <td>
                    <input type="text" name="WHOLE_NAME" readonly class="form-control input-sm">
                </td>
            </tr>


        </table>
    </form>
</body>
</html>
