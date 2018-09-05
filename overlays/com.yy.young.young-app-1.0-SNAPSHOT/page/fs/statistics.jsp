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
        $(function () {
            jo.postAjax("{URL_FS}fs/fileInfo/statisFileNum.action", {}, function(json){
                if(json && json.code == "0"){
                    var title = "文件数量统计图";//标题
                    var subTitle = "按类型统计";//子标题
                    var eg = [""];//图例
                    var yData = new Array();//纵坐标
                    var coreData = [
                        {
                            name: '数量',
                            type: 'bar',
                            data: []
                        }
                    ];
                    var data = json.data;
                    for(var i=0;i<data.length;i++){
                        var item = data[i];
                        yData.push(item.typeRemark);
                        coreData[0].data.push(item.num);
                    }
                    createBarChart("orderPic",title,subTitle,eg,yData,coreData);
                    //饼图
                    var eg2 = new Array();
                    var coreData2 = new Array();
                    for(var i=data.length;i>0;i--){
                        var item = data[i-1];
                        eg2.push(item.typeRemark);
                        coreData2.push({value:item.num,name:item.typeRemark});
                    }
                    createPieChart("pie","各类型文件占比","",eg2,coreData2);
                }

            });
        });
        //创建柱状图
        function createBarChart(sEleId,sTitle,sSubTitle,aEg,aYData,aCoreData){
            var option = {
                title: {
                    text: sTitle,
                    subtext: sSubTitle
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data: aEg
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'value',
                    boundaryGap: [0, 0.01]
                },
                yAxis: {
                    type: 'category',
                    data: aYData
                },
                series: aCoreData
            };
            var myChart = echarts.init(document.getElementById(sEleId));
            myChart.setOption(option);
            return myChart;
        }
        //创建饼图
        function createPieChart(sEleId,sTitle,sSubTitle,aEg,aCoreData){
            var option = {
                title : {
                    text: sTitle,
                    subtext: sSubTitle,
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: aEg
                },
                series : [
                    {
                        name: '文件占比',
                        type: 'pie',
                        radius : '55%',
                        center: ['50%', '60%'],
                        data:aCoreData,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            var myChart = echarts.init(document.getElementById(sEleId));
            myChart.setOption(option);
            return myChart;
        }
        //统计
        function statistics(){

        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label">时间范围&nbsp;</label>
                    <input class="form-control input-sm" name="name" onclick="laydate()" placeholder="起始时间" autocomplete="off" type="text"/>
                    ~
                    <input class="form-control input-sm" name="name" onclick="laydate()" placeholder="结束时间" autocomplete="off" type="text"/>
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="statistics()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;统计</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-6">
            <div id="orderPic" style="width: 100%;height: 400px;"></div>
        </div>
        <div class="col-xs-6">
            <div id="pie" style="width: 100%;height: 400px;"></div>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
