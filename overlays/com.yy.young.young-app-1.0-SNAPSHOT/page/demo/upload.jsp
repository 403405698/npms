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
    <%--上传插件--%>
    <%@ include file="/common/uploadHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>上传插件测试</title>
    <script type="text/javascript">
        $(function () {

        });
        function upload(){
            jo.uploadFile('{URL_PORTAL}ums/app/getAppList.action', function(isSuccess, file, result){
                alert("回调函数:参数1为是否成功,boolean类型;\n参数2是file对象");
                alert("返回的结果为==="+jo.obj2JsonStr(result));
            }, {UPLOAD_FILE_TYPES:'jpg'});
        }

        function upload2(){
            jo.uploadFile('{URL_PORTAL}ums/app/getAppList.action', function(isSuccess, file, result){
                alert("回调函数:参数1为是否成功,boolean类型;\n参数2是file对象");
                alert("返回的结果为==="+jo.obj2JsonStr(result));
            }, {UPLOAD_FILE_TYPES:'png'});
        }


    </script>
</head>
<body>
<br/>
<button id="" class="btn btn-primary" onclick="upload()">上传文件</button>
<br/><br/>
<button id="" class="btn btn-primary" onclick="upload()">上传文件-限制类型为jpg</button>
<br/><br/>
<button id="" class="btn btn-primary" onclick="upload2()">上传文件-限制类型为png</button>
<hr/>
<br/><br/>
<select class="joSelect" dataUrl="ums/user/getUserPage" keyField="ID" valueField="NAME"></select>
<select class="joSelect" dataUrl="ums/role/getRolePage" keyField="ID" valueField="NAME"></select>
<select class="joSelect" dataUrl="ums/dept/getDeptPage" keyField="ID" valueField="NAME"></select>
<select class="joSelect" dataUrl="ums/navigate/getNavigatePage" keyField="ID" valueField="NAME"></select>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
