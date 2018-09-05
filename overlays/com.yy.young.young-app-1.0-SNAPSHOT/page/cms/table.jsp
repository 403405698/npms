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
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>YOUNG</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "cms/table/insertTable.action",//新增
                "deleteUrl" : "cms/table/deleteTable.action",//删除
                "updateUrl" : "cms/table/updateTable.action",//修改
                "formDataUrl" : "cms/table/getTableList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值之前,格式化时间
        joForm.initFormValueBefore = function(oJson){
            oJson.createTime = jo.formatTime(oJson.createTime);
        };
        //初始化编辑表单后置处理函数
        joForm.initFormValueAfter = function(){
            var info = "创建人：" + joForm.formData.createUser + "&nbsp;&nbsp;&nbsp;&nbsp;单位：" + joForm.formData.companyId + "&nbsp;&nbsp;&nbsp;&nbsp;创建时间：" + joForm.formData.createTime;
            $("#createInfo").html(info);
        };
        //表名大写
        function toUpper(obj){
            obj.value = obj.value.toUpperCase();
        }

        //查看字段信息
        var looked = false;//查看字段信息标志位
        function lookTableFieldInfo(){
            if(looked){
                joView.select();
            }else{
                var tableId = jo.getUrlParam("id");
                if(jo.isValid(tableId)){
                    var param = {grid:$("#fieldsList"),PKName:"id",checkStyle:"none",dataUrl:"{URL_CMS}cms/tableCol/getColByTable.action?tableId="+tableId};
                    joView.init(param);//初始化页面
                    looked = true;
                }else{
                    jo.alert("请先保存基础信息!");
                }

            }
        };
        var oldFieldNum = 0;//记录原始字段数
        //初始化试图后置处理
        joView.setGridDataAfter = function(oList){
            if(jo.isValid(oList)){
                oldFieldNum = oList.length;//记录原始字段数
            }
        };
        //处理数据项
        var typeArr = [{key:"VARCHAR2",text:"VARCHAR2"}
            ,{key:"CHAR",text:"CHAR"}
            ,{key:"NUMBER",text:"NUMBER"}
            ,{key:"DATE",text:"DATE"}
            ,{key:"CLOB",text:"CLOB/TEXT"}
            ,{key:"FLOAT",text:"FLOAT"}];
        //获取数据类型下拉选择框
        function getTypeHtmlOfSelect(){
            var _type = "<select class='grid-input form-control input-sm' name='type' onchange='typeChange(this)'>";
            for(var i=0;i<typeArr.length;i++){
                _type += "<option value='"+typeArr[i]["key"]+"'>"+typeArr[i]["text"]+"</option>";
            }
            _type += "</select>";
            return _type;
        }
        //数据类型选择事件
        function typeChange(obj){
            var td = obj.parentNode;
            var lenTd = td.nextSibling;
            if(obj.value == "DATE" || obj.value == "CLOB"){//类型为时间和大字段的则清空
                lenTd.innerHTML = "";
            }else if(obj.value == "FLOAT"){
                lenTd.innerHTML = '<input class="grid-input text-center form-control input-sm" type="text" name="length"/>'+'<input class="grid-input text-center form-control input-sm" type="text" name="floatLength"/>';
            }else{
                lenTd.innerHTML = '<input class="grid-input text-center form-control input-sm" type="text" name="length"/>';
            }
        }
        joView.handleItem = function(oItem,iIndex){
            oItem._opt = "<a href='javascript:joView.del(\""+oItem.id+"\");'>删除</a><input name='id' class='grid-input' type='hidden' value='"+oItem.id+"'/>";
            oItem.num = "<input onchange='modifyCol("+iIndex+")' ErrEmpty ErrNumber name='num' class='grid-input text-center form-control input-sm' type='text' value='"+oItem.num+"'/>";
            oItem.field = "<input onchange='modifyCol("+iIndex+")' ErrEmpty name='field' readonly class='grid-input form-control input-sm' type='text' value='"+jo.getDefVal(oItem.field, "")+"'/>";
            if(oItem.type == "DATE" || oItem.type == "CLOB"){
                oItem.length = "";
            }else if(oItem.type == "FLOAT"){
                oItem.length = "<input onchange='modifyCol("+iIndex+")' ErrEmpty ErrNumber name='length' class='grid-input text-center form-control input-sm' type='text' value='"+jo.getDefVal(oItem.length, "")+"'/>"
                +"<input onchange='modifyCol("+iIndex+")' ErrEmpty ErrNumber name='floatLength' class='grid-input text-center form-control input-sm' type='text' value='"+jo.getDefVal(oItem.floatLength, "")+"'/>";
            }else{
                oItem.length = "<input onchange='modifyCol("+iIndex+")' ErrEmpty ErrNumber name='length' class='grid-input text-center form-control input-sm' type='text' value='"+jo.getDefVal(oItem.length, "")+"'/>";
            }
            var _type = "<select onchange='modifyCol("+iIndex+");typeChange(this)' class='grid-input form-control input-sm' name='type'>";
            for(var i=0;i<typeArr.length;i++){
                if(oItem.type == typeArr[i]["key"]){
                    _type += "<option value='"+typeArr[i]["key"]+"' selected='selected'>"+typeArr[i]["text"]+"</option>";
                }else{
                    _type += "<option value='"+typeArr[i]["key"]+"'>"+typeArr[i]["text"]+"</option>";
                }
            }
            _type += "</select>";
            oItem.type = _type;

            if(jo.isValid(oItem.notNull) && oItem.notNull == "1"){
                oItem.notNull = "<input onclick='modifyCol("+iIndex+")' name='notNull' type='checkbox' checked=true/>";
            }else{
                oItem.notNull = "<input onclick='modifyCol("+iIndex+")' name='notNull' type='checkbox'/>";
            }

            oItem.remark = "<input onchange='modifyCol("+iIndex+")' name='remark' class='grid-input form-control input-sm' type='text' value='"+jo.getDefVal(oItem.remark, "")+"'/>";
        };
        //插入一行
        function appendRow(){
            var table = $("#fieldsList");
            var num = getLastOrder() + 10;
            var _html = '<tr>';
            _html += '<td class="num"><input ErrEmpty ErrNumber class="grid-input text-center form-control input-sm" type="text" value="'+num+'" name="num"/></td>';
            _html += '<td class="field"><input ErrEmpty class="grid-input form-control input-sm" type="text" name="field"/></td>';
            _html += '<td class="type">'+getTypeHtmlOfSelect()+'</td>';
            _html += '<td class="length"><input ErrEmpty ErrNumber class="grid-input text-center form-control input-sm" type="text" name="length"/></td>';
            _html += '<td class="notNull" align="center"><input type="checkbox" name="notNull"/></td>';
            _html += '<td class="remark"><input class="grid-input form-control input-sm" type="text" value="" name="remark"/></td>';
            _html += '<td class="opt" align="center">'+"<a onclick='delTr(this);' style='cursor: pointer;'>删除</a>"+'</td>';
            _html += '</tr>';
            table.append(_html);
        }
        //删除行
        function delTr(obj){
            jo.remove(obj.parentNode.parentNode);
        }
        //获取行,参数为索引,从0开始
        function getRow(idx){
            var table = document.getElementById("fieldsList");
            var rows = table.rows;
            if(rows.length > idx){
                return rows[idx];
            }
            return null;
        }
        //获取某数据行的某列
        function getCell(rowIndex, colIndex){
            var row = getRow(rowIndex);
            if(row){
                if(row.cells.length > colIndex){
                    return row.cells[colIndex];
                }
            }
            return null;
        }
        //获取最后一行的序号值
        function getLastOrder(){
            if(document.getElementById("fieldsList").rows.length > 1){
                var cell = getCell(document.getElementById("fieldsList").rows.length-1, 0);//最后一行的第一列
                var num = $(cell).find("input[name='num']").val();
                return jo.getDefVal(parseInt(num), 0);
            }
            return 0;
        }
        //表格行转字段对象
        function row2FieldObj(row){
            if(row){
                var obj = {};
                var inputs = $(row).find("input");
                for(var i=0;i<inputs.length;i++){
                    var inp = inputs[i];
                    if($(inp).attr("name") == "notNull"){
                        if(inp.checked){
                            obj.notNull = "1";
                        }else{
                            obj.notNull = "0";
                        }
                    }else{
                        obj[$(inp).attr("name")] = $(inp).val();
                    }
                }
                var selects = $(row).find("select");
                for(var i=0;i<selects.length;i++){
                    var select = selects[i];
                    obj[$(select).attr("name")] = $(select).val();
                }
                return obj;
            }
            return null;
        }
        //标记修改字段
        var modCols = {};
        //标记字段被修改
        function modifyCol(idx){
            modCols[(idx+1)] = "mod";
            console.info("第"+(idx+1)+"行字段发生改动!");
        }
        //删除后对修改标记进行重置,避免标记的行号发生混乱
        joView.delSuccessOver = function(){
            modCols = {};
        };
        //保存字段配置
        function saveFields(){
            var tableId = jo.getUrlParam("id");
            if(!jo.isValid(tableId)){
                jo.alert("获取表名失败!");
                return;
            }
            if(jo.checkForm($("#fieldsList"))){
                var table = document.getElementById("fieldsList");
                var rows = table.rows;
                var arr = new Array();
                for(var i=1;i<rows.length;i++){
                    //判断当前行是否发生改动,对修改做约束
                    if(i <= oldFieldNum){
                        //存在改动标记,才存入待修改数组
                        if(jo.isValid(modCols[i]) && modCols[i] == "mod"){
                            arr.push(row2FieldObj(rows[i]));
                        }
                    }else{
                        arr.push(row2FieldObj(rows[i]));
                    }
                }
                if(arr.length > 0){
                    var arrStr = jo.obj2JsonStr(arr);
                    jo.postAjax("{URL_CMS}cms/tableCol/batchSaveTableCol.action", {"tableId":tableId, "cols":arrStr}, function(json){
                        if(json && json.code == 0){
                            jo.showMsg("保存成功");
                            joView.reloadCurrentPage();
                        }else{
                            jo.showMsg(jo.getDefVal(json.info, "保存失败!"));
                        }
                    });
                }else{
                    jo.showMsg("暂无字段变更!");
                }

            }
        }
    </script>
    <style>
        .grid-input{width: 100%;}
    </style>
</head>
<body>
<div class="nav-tabs-horizontal nav-tabs-inverse" data-approve="nav-tabs">
    <ul class="nav nav-tabs" role="tablist" id="tab-option">
        <li class="active" role="presentation">
            <a data-toggle="tab" href="#baseInfo" aria-controls="exampleTabsInverseOne" role="tab" aria-expanded="true">
                基础信息
            </a>
        </li>
        <li role="presentation" class="">
            <a data-toggle="tab" href="#colsInfo" aria-controls="exampleTabsInverseTwo" role="tab" aria-expanded="false" onclick="lookTableFieldInfo()">
                字段信息
            </a>
        </li>
    </ul>
    <div class="tab-content padding-20">
        <div class="tab-pane active" id="baseInfo" role="tabpanel">
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
                        <td width="15%" class="active must" align="">表　　名</td>
                        <td class="tnt">
                            <input type="text" name="id" class="form-control input-sm readonly-edit" onchange="toUpper(this)" placeholder="表名默认大写" ErrEmpty="模块编号不允许为空">
                        </td>

                        <td width="15%" class="active must">注　　释</td>
                        <td>
                            <input type="text" name="name" class="form-control input-sm" ErrEmpty>
                        </td>
                    </tr>
                    <tr>
                       <%-- <td class="active">所属模块</td>
                        <td>
                            <select name="moduleId" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/module/getModuleList.action" keyfield="id" valuefield="name"></select>
                        </td>--%>
                        <td class="active">所属业务</td>
                        <td colspan="3">
                            <select name="businessId" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/business/getBusinessList.action" keyfield="id" valuefield="name"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="active must">排　　序</td>
                        <td>
                            <input type="text" name="num" value="99" class="form-control input-sm" ErrEmpty>
                        </td>
                        <td class="active must">是否主表</td>
                        <td>
                            <div class="radio" style="margin: 0px;">
                                <label>
                                    <input type="radio" name="master" value="1" checked="checked">是
                                </label>
                                <label>
                                    <input type="radio" name="master" value="0">否
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active">备　　注</td>
                        <td colspan="3">
                            <input type="text" name="remark" class="form-control input-sm" >
                        </td>
                    </tr>
                </table>
                <p id="createInfo" style="color: red;"></p>
            </form>
        </div>
        <div class="tab-pane" id="colsInfo" role="tabpanel">
            <div class="container-fluid">
                <div class="row">
                    <div class="form-group button-bar">
                        <button type="button" isShow="" class="btn btn-sm btn-outline btn-default" onclick="saveFields()">
                            <i class="fa fa-save" aria-hidden="true"></i>&nbsp;保存
                        </button>
                        <button type="button" isShow="" class="btn btn-sm btn-outline btn-default" onclick="appendRow()">
                            <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;添加一行
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover table-striped table-condensed" id="fieldsList" dataUrl=""
                               deleteUrl="{URL_CMS}cms/tableCol/deleteTableCol.action" formUrl="">
                            <col field="num" title="序号" width="70px" align=""/>
                            <col field="field" title="字段名" width="20%" align=""/>
                            <col field="type" title="字段类型" width="15%" align=""/>
                            <col field="length" title="字段长度" width="10%" align=""/>
                            <col field="notNull" title="必填" width="50px" align=""/>
                            <col field="remark" title="字段注释" width="15%" align=""/>
                            <col field="_opt" title="操作" width="10%" align=""/>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    jo.formatUI();
</script>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
