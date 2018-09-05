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
    <title>方案菜单表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "saveAfter" : "toEdit",
                "addUrl" : "portal/schemeMenu/insert.action",//新增
                "deleteUrl" : "portal/schemeMenu/delete.action",//删除
                "updateUrl" : "portal/schemeMenu/update.action",//修改
                "formDataUrl" : "portal/schemeMenu/getSchemeMenu.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值前处理
        joForm.initFormValueBefore = function(oJson){
        };
        //选择上级菜单
        function choiceParentMenu(idInp, nameInp){
            var schemeId = $("#schemeId").val();
            if(schemeId){
                jo.selectTree('{URL_PORTAL}portal/schemeMenu/getMenuListBySchemeId.action?schemeId='+schemeId,jo.getDefVal(idInp, 'parentId'),jo.getDefVal(nameInp, 'PARENT_NAME'),'id','name', 'parentId',
                        '','','','',function(data){
                            for(var i=0;i<data.length;i++){
                                data[i].icon2 = data[i].icon;
                                data[i].icon = "";//去掉icon因为icon是ztree中的节点图标关键字
                            }
                        });
            }else{
                jo.showMsg("请选择方案");
            }
        }
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
        <tr>
            <td width="15%" class="active" align="">菜单编号</td>
            <td class="tnt">
                <input type="text"  name="id" class="form-control input-sm readonly-edit" />
            </td>
            <td width="15%" class="active" align="">菜单名称</td>
            <td class="tnt">
                <input type="text"  name="name" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">上级编号</td>
            <td class="tnt">
                <div class="input-group">
                    <input type="text" id="parentId" name="parentId" class="form-control input-sm"/>
                    <span class="input-group-btn">
                        <button class="btn btn-default btn-sm" type="button" onclick="choiceParentMenu('parentId', '')">
                            <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                        </button>
                    </span>
                </div>
            </td>
            <td class="active" align="">方案编号</td>
            <td class="tnt">
                <select name="schemeId" onchange="$('#parentId').val('')" id="schemeId" ErrEmpty class="joSelect form-control input-sm" firstItem='{"id":"","name":""}' data="" dataurl="{URL_PORTAL}portal/scheme/getSchemeList.action" keyfield="id" valuefield="name"></select>
                <%--<input type="text"  name="schemeId" class="form-control input-sm" />--%>
            </td>

        </tr>
        <tr>
            <td class="active" align="">菜单链接</td>
            <td class="tnt">
                <input type="text"  name="navHref" class="form-control input-sm" />
            </td>
            <td class="active" align="">图　　标</td>
            <td class="tnt">
                <div class="input-group">
                    <input type="text" id="icon" name="icon" class="form-control input-sm"/>
                    <span class="input-group-btn">
                        <button class="btn btn-default btn-sm" type="button" onclick="choiceIcon('icon')">
                            <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                        </button>
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <td class="active" align="">显示顺序</td>
            <td class="tnt">
                <input type="text"  name="num" class="form-control input-sm" value="99"/>
            </td>
            <td class="active" align="">资源ID</td>
            <td class="tnt">
                <input type="text"  name="navId" readonly class="form-control input-sm" />
            </td>
        </tr>
    </table>
</form>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
