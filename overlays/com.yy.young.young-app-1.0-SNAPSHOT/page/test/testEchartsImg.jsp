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
    <script src="<%=URL_STATIC%>static/plugin/echarts/echarts.js"></script>
    <title>统计分析</title>
    <script type="text/javascript">
        var myChart;
        $(function () {
            var option = {
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: [820, 932, 901, 934, 1290, 1330, 1320],
                    type: 'line',
                    areaStyle: {}
                }]
            };
            myChart = echarts.init(document.getElementById("orderPic"));
            myChart.setOption(option);
        });
        function statistics(){
            $("#sss").val(myChart.getDataURL({
                pixelRatio: 2,
                backgroundColor: '#fff'
            }));
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <button type="button" class="btn btn-primary btn-sm" onclick="statistics()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;获取图片</button>
    <div class="row">
        <div class="col-xs-6">
            <div id="orderPic" style="width: 100%;height: 400px;"></div>
        </div>
        <div class="col-xs-6">
            <div id="pie" style="width: 100%;height: 400px;"><textarea id="sss"></textarea></div>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
