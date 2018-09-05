<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link href="<%=URL_STATIC%>static/plugin/jo/joUI.css" rel="stylesheet"/>
<script src="<%=URL_STATIC%>static/plugin/jo/jo.js"></script>
<script src="<%=URL_STATIC%>static/plugin/jo/jo-adapt.js"></script>
<%--<script src="<%=URL_STATIC%>static/plugin/jo/jo-page-view.js"></script>--%>
<script src="<%=URL_STATIC%>static/newjs/rh_jo_page_view.js"></script>
<%--使用overlay的jo-page-form.js--%>
<script src="<%=URL_STATIC%>static/plugin/jo/jo-page-form.js"></script>
<%--jo统一监听由于使用的低版本jquery,会因为.live()绑定事件报错--%>
<script type="text/javascript" charset="UTF-8">
    //兼容jquery低版本.live()方法
    $.fn.live = function(sEvent,func){
        console.log("[jo] Higner version jquery support .live()!");
        $(this).on(sEvent,func);
    };
</script>
<%--<script src="<%=URL_STATIC%>static/plugin/jo/jo-listener.js"></script>--%><%--暂且先注释--%>