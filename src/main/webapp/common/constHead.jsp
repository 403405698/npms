<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="com.yy.young.common.util.CommonJsonUtil" %>
<%@ page import="com.yy.young.common.util.CommonUtil" %>
<%@ page import="com.yy.young.common.config.DomainHandler" %>
<%@ page import="com.yy.young.base.util.GlobalConstants" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
  String URL_UMS = DomainHandler.get(GlobalConstants.URL_CONFIG_KEY.URL_UMS);
  String URL_PORTAL = DomainHandler.get(GlobalConstants.URL_CONFIG_KEY.URL_PORTAL);
  String URL_STATIC = DomainHandler.get(GlobalConstants.URL_CONFIG_KEY.URL_STATIC);
  String URL_FS = DomainHandler.get(GlobalConstants.URL_CONFIG_KEY.URL_FS);
  String URL_CMS = DomainHandler.get(GlobalConstants.URL_CONFIG_KEY.URL_CMS);
%>
<base href="<%=basePath%>">
<script type="text/javascript">
  var loginUser = <%= CommonJsonUtil.bean2JsonStr(CommonUtil.getLoginUser(request))%>;//current login user info
  var contextPath = '<%=basePath%>';
  var URL_UMS = '<%=URL_UMS%>' ? '<%=URL_UMS%>' : contextPath;//统一用户域名
  var URL_PORTAL = '<%=URL_PORTAL%>' ? '<%=URL_PORTAL%>' : contextPath;//门户域名
  var URL_STATIC = '<%=URL_STATIC%>' ? '<%=URL_STATIC%>' : contextPath;//静态域名
  var URL_FS = '<%=URL_FS%>' ? '<%=URL_FS%>' : contextPath;//文件系统域名
  var URL_CMS = '<%=URL_CMS%>' ? '<%=URL_CMS%>' : contextPath;//内容管理系统域名

  //系统url对象
  var SYSURL = {
    UMS : URL_UMS
    ,PORTAL : URL_PORTAL
    ,STATIC : URL_STATIC
    ,FS : URL_FS
    ,URL_CMS : URL_CMS
  };
  window.UEDITOR_HOME_URL = URL_STATIC + "static/plugin/UEditor/"
</script>