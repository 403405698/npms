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
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>数据源配置表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "saveAfter" : "toEdit",
                "addUrl" : "cms/dataSource/insert.action",//新增
                "deleteUrl" : "cms/dataSource/delete.action",//删除
                "updateUrl" : "cms/dataSource/update.action",//修改
                "formDataUrl" : "cms/dataSource/getDataSource.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值前处理
        joForm.initFormValueBefore = function(oJson){
            /*oJson.createTime = jo.formatDate(oJson.createTime);
            oJson.updateTime = jo.formatDate(oJson.updateTime);*/
        };
        //初始化编辑表单后置处理函数
        joForm.initFormValueAfter = function(){
            var info = "创建人：" + joForm.formData.createUser + "&nbsp;&nbsp;&nbsp;&nbsp;单位：" + joForm.formData.companyId
                    + "<br/>创建时间：" + jo.formatTime(joForm.formData.createTime)
                    + "&nbsp;&nbsp;&nbsp;&nbsp;更新时间：" + jo.formatTime(joForm.formData.updateTime);
            $("#createInfo").html(info);
        };
        //转为大写
        function allToUp(){
            $("#joinSql").val($("#joinSql").val().toUpperCase());
            $("#whereSql").val($("#whereSql").val().toUpperCase());
            $("#orderSql").val($("#orderSql").val().toUpperCase());
        }
        //在光标处插入
        function insertText(sInpId,sText){
            var obj = document.getElementById(sInpId);
            var str = sText;
            if (document.selection) {
                obj.focus();
                var sel = document.selection.createRange();
                sel.text = str;
            } else if (typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number') {
                var startPos = obj.selectionStart;
                var endPos = obj.selectionEnd;
                var tmpStr = obj.value;
                obj.value = tmpStr.substring(0, startPos) + str + tmpStr.substring(endPos, tmpStr.length);
            } else {
                obj.value += str;
            }
        }
    </script>
    <style type="text/css">
        .helpUl{list-style: none;padding:0px;margin:0px;color:#2932E1;font-weight: bold;cursor:pointer;}
        .helpUl li{display:inline-block;padding:0px 5px;}
        .remark{color:#111111;cursor:default;font-weight:normal;}
        .helpUl li:not(.remark):hover{text-decoration: underline;background-color:#DEDEDE;}
    </style>
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
            <td width="15%" class="active must" align="">数据源编号</td>
            <td class="tnt">
                <input type="text"  name="id" class="form-control input-sm readonly-edit" ErrEmpty />
            </td>
            <td width="15%" class="active" align="">数据源名称</td>
            <td class="tnt">
                <input type="text"  name="name" class="form-control input-sm"/>
            </td>
        </tr>
        <tr>
            <td class="active must" align="">显示顺序</td>
            <td class="tnt">
                <input type="text"  name="num" class="form-control input-sm" ErrEmpty>
            </td>
            <td class="active" align="">所属模块</td>
            <td class="tnt">
                <select name="moduleId" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/module/getModuleList.action" keyfield="id" valuefield="name"></select>
            </td>
        </tr>
        <tr>
            <td class="active must" align="">业 务 表</td>
            <td class="tnt" colspan="3">
                <select onchange="$('#cols').val('')" id="tableId" name="tableId" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/table/getTableList.action" keyfield="id" valuefield="{id}（{name}）"></select>
                <%--<input type="text"  name="tableId" class="form-control input-sm" ErrEmpty>--%>
            </td>
        </tr>
        <tr>
            <td class="active must" align="">查询字段</td>
            <td class="tnt" colspan="3">
                <%--<input type="text"  name="cols" class="form-control input-sm" ErrEmpty>--%>
                <div class="input-group" style="width: 100%;">
                    <input type="text" id="cols" name="cols" class="form-control input-sm"/>
                    <span class="input-group-btn">
                        <button class="btn btn-default btn-sm" type="button" onclick="cms.choiceColsByTable($('#tableId').val())">
                            <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                        </button>
                    </span>
                    <span class="input-group-btn">
                        别名:O
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <td class="active" align="">常量选择</td>
            <td class="tnt" colspan="3">
                <ul class="helpUl">
                    <li class="remark">业务常量：</li>
                    <li onclick="insertText('whereSql','_userId')">用户ID</li>
                    <li onclick="insertText('whereSql','_userName')">用户名字</li>
                    <li onclick="insertText('whereSql','_userRoleId')">用户角色ID</li>
                    <li onclick="insertText('whereSql','_userCompanyId')">用户单位ID</li>
                    <li onclick="insertText('whereSql','_userCompanyName')">用户单位名称</li>
                </ul>
                <ul class="helpUl">
                    <li class="remark">DATE类型时间常量：</li>
                    <li onclick="insertText('whereSql','_d_today')">当天</li>
                    <li onclick="insertText('whereSql','_d_month')">当前月</li>
                    <li onclick="insertText('whereSql','_d_lastYear')">去年</li>
                    <li onclick="insertText('whereSql','_d_thisYear')">今年</li>
                    <li onclick="insertText('whereSql','_d_nextYear')">明年</li>
                </ul>
                <ul class="helpUl">
                    <li class="remark">VARCHAR类型时间常量：</li>
                    <li onclick="insertText('whereSql','_s_today')">当天</li>
                    <li onclick="insertText('whereSql','_s_month')">当前月</li>
                    <li onclick="insertText('whereSql','_s_lastYear')">去年</li>
                    <li onclick="insertText('whereSql','_s_thisYear')">今年</li>
                    <li onclick="insertText('whereSql','_s_nextYear')">明年</li>
                    <li class="remark" style="color:red;">（判断区间时使用between关键字）</li>
                </ul>
                <ul class="helpUl">
                    <li class="remark">运算符常量：</li>
                    <li onclick="insertText('whereSql',';=;')">等于</li>
                    <li onclick="insertText('whereSql',';!=;')">不等于</li>
                    <li onclick="insertText('whereSql',';>;')">大于</li>
                    <li onclick="insertText('whereSql',';<;')">小于</li>
                    <li onclick="insertText('whereSql',';between;')">between</li>
                    <li onclick="insertText('whereSql',';like;')">like</li>
                    <li onclick="insertText('whereSql',';in;')">in</li>
                    <li onclick="insertText('whereSql',';and;')">and</li>
                    <li onclick="insertText('whereSql',';or;')">or</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td class="active" align="">查询条件</td>
            <td class="tnt" colspan="3">
                <textarea type="text" id="whereSql" name="whereSql" class="form-control input-sm" placeholder="查询条件,例如:NAME=张三;and;ID=7"></textarea>
            </td>
        </tr>
        <tr>
            <td class="active" align="">排序语句</td>
            <td class="tnt" colspan="3">
                <input type="text" id="orderSql" name="orderSql" class="form-control input-sm" placeholder="例如:ID ASC,省略ORDER BY "/>
            </td>

        </tr>
        <tr>
            <td class="active" align="">关联查询SQL<br/>（暂时无效）</td>
            <td class="tnt" colspan="3">
                <textarea type="text" id="joinSql" name="joinSql" class="form-control input-sm"></textarea>
            </td>
        </tr>
        <tr>
            <td class="active" align="">备　　注</td>
            <td class="tnt" colspan="3">
                <input type="text"  name="remark" class="form-control input-sm"/>
            </td>
        </tr>
    </table>
    <p class="font-red">建议SQL书写全部采用大写形式<%--，<span onclick="allToUp()" class="font-blue cursor-hand">点我</span>进行格式化！</p>--%>
    <p id="createInfo" style="color: red;"></p>
</form>
<script type="text/javascript">
    jo.formatUI();
</script>
</body>
</html>
