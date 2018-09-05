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
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--jo--%>
    <%--<%@ include file="/common/joHead.jsp"%>--%>
    <%--代码编辑器--%>
    <link href="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/lib/codemirror.css" rel="stylesheet"/>
    <link href="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/theme/seti.css" rel="stylesheet"/>
    <script src="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/lib/codemirror.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/mode/xml/xml.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/mode/css/css.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/mode/javascript/javascript.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/mode/htmlmixed.js"></script>
    <!--括号匹配-->
    <script src="<%=URL_STATIC%>static/plugin/codemirror-5.29.0/addon/edit/matchbrackets.js"></script>
    <title>YOUNG</title>
</head>
<body>
<%--<script id="code" type="text/plain" style="width:100%;"></script>--%>
<textarea id="code"></textarea>
<script type="text/javascript">
    $(function () {

    });
    /*var cof = {
     toolbars : [['fullscreen', '']]
     ,initialFrameHeight : '200'
     ,elementPathEnabled : false
     ,autoClearinitialContent:true
     ,allowDivTransToP: false
     ,sourceEditorFirst: true    //初始化后自动进入源码模式
     ,enterTag: ""
     };
     var code = UE.getEditor('code', cof);*/
    var mixedMode = {
        name: "htmlmixed",
        scriptTypes: [{matches: /\/x-handlebars-template|\/x-mustache/i,
            mode: null},
            {matches: /(text|application)\/(x-)?vb(a|script)/i,
                mode: "vbscript"}]
    };
    var code = CodeMirror.fromTextArea(document.getElementById("code"), {
        mode: mixedMode,
        selectionPointer: true,
        theme:"seti",//主题
        matchBrackets:true,//括号匹配
        lineNumbers:true
    });
    var old = "";//编辑过后的旧值
    //设置内容
    function setContent(str){
        if(str){
            old = encodeURIComponent(str);//编码字符串
            code.setValue(str);
        }else{
            code.setValue("//js");
        }

    }
    //获取内容
    function getContent(){
        var n = code.getValue();//取到html值
        if(old == encodeURIComponent(n)){
            return null;
        }
        return n;
    }
</script>
</body>
</html>
