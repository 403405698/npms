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
    <title>辅助工具</title>
    <script type="text/javascript">
        $(function () {
            var obj = $("#parentHeight");
            var parent = obj.parent();
            obj.css("height", parent.css("height"));
        });
        //大写格式转驼峰
        function up2Tuo(str){
            if(document.getElementById("tuo").checked){
                if(jo.isValid(str)){
                    var arr = str.split("_");
                    if(arr.length > 1){
                        var s = arr[0].toLowerCase();
                        for(var i=1;i<arr.length;i++){
                            s += arr[i].substring(0,1).toUpperCase() + arr[i].substring(1).toLowerCase();
                        }
                        return s;
                    }else{
                        return str.toLowerCase();
                    }
                }else{
                    return "";
                }
            }else{
                return str;
            }
        }
        //转mybatis格式的修改sql
        function str2UpdateSql(){
            var str = $("#str").val();
            if(!str){
                return;
            }
            if(str.charAt(0) == ","){
                str = str.substring(1);
                console.info("第一个字符为逗号',' 去掉...");
            }
            console.info("输入内容为:"+str);
            str = str.trim();
            str = str.replace(/\s/ig,"");
            console.info("去除空格符/换行符后为:"+str);
            var arr = str.split(",");
            var sql = '';//结果
            var c = 0;
            for(var i=0;i<arr.length;i++){
                var col = arr[i];
                sql += '<if test="'+up2Tuo(col)+' != null">\n\t'+col+' = #\{'+up2Tuo(col)+'\}, \n</if>';
                if(i < (arr.length-1)){
                    sql += '\n';
                }
                c++;
            }
            $("#result").val(sql);
            jo.showMsg("输入字段"+arr.length+"个,生成&lt;if>语句"+c+"条!", {icon:1});
        }
        //转mybatis格式的插入sql
        function str2InsertSql(){
            var str = $("#str").val();
            if(!str){
                return;
            }
            if(str.charAt(0) == ","){
                str = str.substring(1);
                console.info("第一个字符为逗号',' 去掉...");
            }
            console.info("输入内容为:"+str);
            str = str.trim();
            str = str.replace(/\s/ig,"");
            console.info("去除空格符/换行符后为:"+str);
            var arr = str.split(",");
            var sql = 'INSERT INTO XXXX (\n';//结果
            var c = 0;
            for(var i=0;i<arr.length;i++){
                var col = arr[i];
                sql += '\t';
                if(i != 0){
                    sql += ',';
                }
                sql += col;
                sql += '\n';
                c++;
            }
            sql += ') VALUES (\n';
            var b = 0;
            for(var i=0;i<arr.length;i++){
                var col = arr[i];
                sql += '\t';
                if(i != 0){
                    sql += ',';
                }
                sql += "#\{"+up2Tuo(col)+"\}\n";
                b++;
            }
            sql += ')';
            if(b!=c){
                jo.alert("出大事了:一个不可能出现的异常出现了!");
            }
            $("#result").val(sql);
            jo.showMsg("输入字段"+arr.length+"个,生成字段"+c+"条!", {icon:1});
        }
    </script>
    <style>
        .center-vertical {
            position:relative;
            top:50%;
            transform:translateY(-50%);
        }
        .Absolute-Center {
            margin: auto;
            position: absolute;
            top: 0; left: 0; bottom: 0; right: 0;
        }
        .height-100{
            height: 100%;
        }
    </style>
</head>
<body class="padding-15">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-5">
            <h6>字段(逗号拼接):</h6>
            <textarea class="form-control" rows="20" id="str"></textarea>
        </div>
        <div class="col-xs-2" id="parentHeight" align="center">
            <div class="center-vertical">
                <label><input id="tuo" type="checkbox" name=""/>自动格式化为驼峰格式</label>
                <br/><br/>
                <button class="btn btn-primary" onclick="str2UpdateSql()">转为修改SQL</button>
                <br/><br/>
                <button class="btn btn-primary" onclick="str2InsertSql()">转为插入SQL</button>
                <br/><br/>
                <button class="btn btn-primary" onclick="$('#str').val('');$('#result').val('');">清空</button>
            </div>
        </div>
        <div class="col-xs-5">
            <h6>结果:</h6>
            <textarea class="form-control" rows="20" id="result"></textarea>
        </div>
    </div>
</div>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>