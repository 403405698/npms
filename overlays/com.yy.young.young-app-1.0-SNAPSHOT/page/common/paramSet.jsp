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
    <title>参数配置</title>
    <script type="text/javascript">
        var category = 'young';//配置分组
        var a = {};
        $(function(){
            loadConfig();
        });
        var old;
        //加载配置
        function loadConfig(){
            var keyArr = new Array();
            var arr = $("#pageForm").serializeArray();
            for(var i=0;i<arr.length;i++){
                keyArr.push(arr[i].name);
            }
            jo.postAjax('common/platformConfig/getConfigByCategoryAndKeys.action', {"category":category, "keys":keyArr.join(",")}, function(json){
                if(json && json.code == "0"){
                    //组织数据
                    var o = {};
                    for(var i=0;i<json.data.length;i++){
                        o[json.data[i].CKEY] = typeof (json.data[i].CVALUE) != "undefined" ? json.data[i].CVALUE : "";
                    }
                    joForm.initFormValue($("#pageForm"), o);
                    old = o;//记录配置信息

                }
            });
        }
        //保存配置
        function saveConfig(){
            var configArr = new Array();
            var arr = $("#pageForm").serializeArray();
            for(var i=0;i<arr.length;i++){
                if(typeof (old[arr[i].name]) == "undefined" || old[arr[i].name] != arr[i].value){//当后台传值不含有此配置或者配置发生改变时
                    configArr.push({"CKEY":arr[i].name,"CVALUE":arr[i].value,"CATEGORY":category});
                }
            }
            if(configArr != null && configArr.length > 0){
                jo.postAjax('common/platformConfig/batchUpdateOrInsertConfig.action', {"configs": jo.obj2JsonStr(configArr)}, function(json){
                    if(json && json.code == "0"){
                        jo.showMsg("保存成功!");
                        loadConfig();
                    }else{
                        jo.showMsg("保存失败!");
                    }
                });
            }else{
                jo.showMsg("已是最新配置，无需保存！");
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" isShow="" class="btn btn-sm btn-outline btn-default" onclick="saveConfig()">
                    <i class="fa fa-check-circle" aria-hidden="true"></i>&nbsp;保存
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <tr>
                        <td width="25%" class="active" align="">统一用户域名</td>
                        <td class="tnt">
                            <input type="text" name="URL_UMS" class="form-control input-sm" placeholder="单机部署则为空"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="active" align="">门户系统域名</td>
                        <td class="tnt">
                            <input type="text" name="URL_PORTAL" class="form-control input-sm" placeholder="单机部署则为空"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="active" align="">静态资源域名</td>
                        <td class="tnt">
                            <input type="text" name="URL_STATIC" class="form-control input-sm" placeholder="单机部署则为空"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="active" align="">文件系统域名</td>
                        <td class="tnt">
                            <input type="text" name="URL_FS" class="form-control input-sm" placeholder="单机部署则为空"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="active" align="">内容管理域名</td>
                        <td class="tnt">
                            <input type="text" name="URL_CMS" class="form-control input-sm" placeholder="单机部署则为空"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="active" align="">登录成功后跳转地址</td>
                        <td class="tnt">
                            <input type="text" name="URL_INDEX" class="form-control input-sm" placeholder="登录成功后跳转地址"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" class="active" align="">测试配置</td>
                        <td class="tnt">
                            <input type="text" name="test" class="form-control input-sm" placeholder="" value="2"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
