<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <title>关于我们</title>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/newlogin/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/newlogin/css/style.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/newlogin/css/aboutUs.css">

    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">
</head>

<body>
<div class="container-fluid">
    <div class="header clear">
        <div class="left">
            <img src="<%=URL_STATIC%>static/newlogin/image/logo.jpg" alt="">
            <h2>中国环境科学研究院人事档案管理系统</h2>
        </div>
        <div class="right">
            <a href="<%=URL_PORTAL%>page/portal/index.jsp" type="button" class="btn btn-primary">返回登录</a>
        </div>
    </div>

    <div class="aboutUs-content">
        <div class="aboutUs-content-wrap">
            <h3>关于我们</h3>
            <p>中国环境科学研究院（Chinese Research Academy of Environmental Sciences）成立于1978年12月31日，隶属中华人民共和国环境保护部。</p>
            <p class="mar">中国环境科学研究院围绕国家可持续发展战略，开展创新性、基础性重大环境保护科学研究，致力于为国家经济社会发展和环境决策提供战略性、前瞻性和全局性的科技支撑，服务于经济社会发展中重大环境问题的工程技术与咨询需要。</p>
            <p class="mar">根据2017年11月研究院官网显示，中国环境科学研究院有职工近400人，有5名中国工程院院士；有1个国家重点实验室，7个国家环境保护重点实验室；有博士生108人，硕士生137人，有在站博士后研究人员18名。</p>
            <p class="mar">伴随着改革开放的步伐，经中共中央批准，中国环境科学研究院于1978年12月31日正式成立 ，隶属中华人民共和国环境保护部。作为国家级社会公益非营利性环境保护科研机构，中国环科院围绕国家可持续发展战略，开展创新性、基础性重大环境保护科学研究，致力于为国家经济社会发展和环境决策提供战略性、前瞻性和全局性的科技支撑，服务于经济社会发展中重大环境问题的工程技术与咨询需要，为国家可持续发展战略和环境保护事业发挥了重要作用。</p>
        </div>
    </div>

    <div class="footer">
        <p>Copyright @ 2018-2020 中国环境科学研究院人事档案管理系统</p>
    </div>
</div>
</body>

</html>