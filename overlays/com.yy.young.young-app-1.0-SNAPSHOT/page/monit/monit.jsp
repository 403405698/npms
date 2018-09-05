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
    <script src="<%=URL_STATIC%>static/plugin/echarts/theme/macarons.js"></script>
    <title>监控中心</title>
    <script type="text/javascript">
        $(function () {
            var memoryGauge = new MonitChart("memoryGauge", {
                backgroundColor: '#ffffff',
                grid : {
                    left: 15,
                    right: 15,
                    top: 15,
                    bottom: 15,
                    containLabel:true
                },
                tooltip : {
                    formatter: "{a} <br/>{b} : {c}%"
                },
                series: [
                    {
                        name: 'JVM内存',
                        type: 'gauge',
                        detail: {formatter:'{value}%'},
                        data: [{value: 0, name: '内存使用率'}]
                    }
                ]
            }, function(node){
                printlog(this.id + " : 内存仪表图更新.");
                if(node){
                    this.option.series[0].data[0].value = ((node.totalMemory - node.freeMemory) / node.totalMemory * 100).toFixed(2);
                    this.chart.setOption(this.option, true);
                    $("#totalMemory").text(node.totalMemory);
                    $("#freeMemory").text(node.freeMemory);
                    $("#maxMemory").text(node.maxMemory);
                }
            });
            var memoryLine = new MonitChart("memoryLine", {
                backgroundColor: '#ffffff',
                grid : {
                    left: 15,
                    right: 25,
                    top: 15,
                    bottom: 15,
                    containLabel:true
                },
                tooltip: {
                    trigger: 'axis',
                    formatter: function (params) {
                        var param = params[0];
                        return param.name.split('@')[0] + '<br/>已用(kb) : ' + param.name.split('@')[1]  + '<br/>总量(kb) : ' + param.name.split('@')[2] + '<br/>' + '占比 : ' + param.value[1] + ' %';
                    },
                    axisPointer: {
                        animation: false
                    }
                },
                xAxis: {
                    type: 'time',
                    splitLine: {
                        show: false
                    }
                },
                yAxis: {
                    type: 'value',
                    boundaryGap: [0, '100%'],
                    splitLine: {
                        show: false
                    },
                    min: 0,
                    max: 100
                },
                series: [{
                    name: 'JVM内存使用率',
                    type: 'line',
                    symbol: 'emptyCircle',
                    symbolSize: 8,
                    hoverAnimation: false,
                    data: []
                }]
            }, function(node){
                printlog(this.id + " : 内存使用率动态折线图更新.");
                if(node){
                    if(this.option.series[0].data.length > 20){//保持数量在10个
                        this.option.series[0].data.shift();//删除第一个元素
                    }
                    var item = {
                        name: jo.formatTime(node.timestamp)+'@'+(node.totalMemory - node.freeMemory)+'@'+node.totalMemory,
                        value: [jo.formatTime(node.timestamp), ((node.totalMemory - node.freeMemory) / node.totalMemory * 100).toFixed(2)]
                    };
                    this.option.series[0].data.push(item);
                    this.chart.setOption(this.option, true);
                }
            });
            subject.charts.push(memoryGauge);//放入图表
            subject.charts.push(memoryLine);//放入图表
            subject.charts.push(new MonitChart('', '', function(node){
                printlog("线程监控更新.");
                if(node){
                    $("#currentThreadCount").text(node.currentThreadCount);
                    $("#peakThreadCount").text(node.peakThreadCount);
                    $("#daemonThreadCount").text(node.daemonThreadCount);
                    $("#totalThreadCount").text(node.totalThreadCount);
                }
            }));//放入线程监控
            subject.charts.push(new MonitChart('', '', function(node){
                printlog("gc监控更新.");
                if(node){
                    Grid("gcList").loadData(node.gcInfoList);
                }
            }));//gc
            subject.charts.push(new MonitChart('', '', function(node){
                printlog("内存区监控更新.");
                if(node){
                    Grid("memoryPoolList").loadData(node.memoryPoolInfoList);
                }
            }));//memoryPoolList
            subject.charts.push(new MonitChart('', '', function(node){
                printlog("节点基本信息更新.");
                if(node){
                    Grid("baseList").loadData([node]);
                }
            }));//baseList
            //subject.start();
        });
        //主题对象,负责控制整个流程
        var subject = {
            time : 5000,//定时器间隔
            charts : [],//图表对象数组
            count : 0,//请求数量统计
            timeoutId: null,
            flag : false,//开关
            getStatus : function(){
                printlog("发起第 "+(++this.count)+" 次状态查询:");
                jo.postAjax("common/monitor/getStatus", {}, function(json){
                    if(json && json.code == 0 && json.data && json.data[0]){
                        var node = json.data[0];
                        for(var i=0;i<subject.charts.length;i++){
                            var chart = subject.charts[i];
                            chart.update(node);//调用更新回调
                        }
                    }
                });
                //请求完成后固定时间后递归调用
                this.timeoutId = window.setTimeout(function(){
                    subject.getStatus();//递归
                }, this.time);
            },
            start : function(){
                if(!this.flag){
                    printlog("控制器启动------定时器间隔 "+this.time+" ms------当前注册图表数量 "+this.charts.length+" 个-----------");
                    this.getStatus();
                    this.flag = true;
                    $("#state").html('<span class="font-green">监控已开启</span>');
                }
            },
            stop : function(){
                if(this.flag){
                    printlog("控制器关闭------执行查询 "+this.count+" 次------当前注册图表数量 "+this.charts.length+" 个-----------");
                    window.clearTimeout(this.timeoutId);
                    this.flag = false;
                    $("#state").html('<span class="font-red">监控已暂停</span>');
                }
            }
        };
        /**
        * 监控图类
        * @param id dom容器id
        * @param option echarts图表option参数
        * @param updateFunc 图表刷新函数,参数为NodeStatus对象(来自服务端)
        * @constructor
         */
        function MonitChart(id, option, updateFunc){
            if(id){
                this.id = id;
                this.chart = echarts.init(document.getElementById(id), "macarons");//初始化
                this.option = option;
                this.chart.setOption(option);//图表初始展示
            }
            this.update = updateFunc;
        }
        //内存池行处理
        function mpTrHandle(item){
            //item["usageStr"] = "init=" + item.usage.init + "used" + item.usage.used + "committed" + item.usage.committed + "max" + item.usage.max;
            item.init = parseInt(item.usage.init / 1024);
            item.used = parseInt(item.usage.used / 1024);
            item.committed = parseInt(item.usage.committed / 1024);
            item.max = parseInt(item.usage.max / 1024);
        }
        //控制台输出
        var logCount = 0;
        function printlog(msg){
            console.log('['+jo.formatTime(new Date())+'] ' + msg);
            /*if(logCount > 200){//日志输出次数到达限度,则清空
                $("#console").html('');
                logCount = 0;
            }
            logCount++;
            $("#console").append('<div style="margin-right: 15px;">['+jo.formatTime(new Date())+'] '+msg+'</div>');
            $("#console").scrollTop($("#console")[0].scrollHeight);*/
        }
        //添加一行
        function appendTr(){
            var _html = '<tr>' +
                    '<td><input type="text" class="form-control input-sm" value="http://"/></td>' +
                    '<td><input type="text" class="form-control input-sm"/></td>' +
                    '<td><input type="text" class="form-control input-sm" value="8080"/></td>' +
                    '<td><input type="text" class="form-control input-sm" value="/common/monitor/getStatus"/></td></tr>';
            $("#nodeBox").append(_html);
        }
        //删除一行
        function delTr(){
            if($("#nodeBox").find("tr").length > 1){
                $($("#nodeBox").find("tr")[$("#nodeBox").find("tr").length - 1]).remove();
            }
        }
        function getMemUse(freeMemory, totalMemory){
            var p = ((1-freeMemory/totalMemory)*100).toFixed(2);
            if(p > 80){
                return '<span class="font-red">'+p+'</span>';
            }else if(p > 60){
                return '<span class="font-yellow">'+p+'</span>';
            }else if(p > 40){
                return '<span class="font-blue">'+p+'</span>';
            }else{
                return '<span class="font-green">'+p+'</span>';
            }

        }
    </script>
    <style>
        body .table > tbody > tr > td{/*对于表单中的内容,不作处理*/
            overflow:visible;white-space:normal;text-overflow: inherit;
        }
        .title{
            line-height: 1.7;
            padding: 8px 12px 8px 12px;
            /*border-left: red solid 5px;*/
            background-color: white;
            font-weight: bolder;
            font-size: 14px;
            border-top: #E7EAEC solid 5px;
            border-bottom: #E7EAEC solid 1px;
        }
        .no-padding{
            padding: 0px;
        }
        .row-padding{
            padding: 0px 15px;
        }
        .row-margin{
            margin-top: 15px;
        }
        /*计数块*/
        .count{
            padding: 15px;background-color: white;
            text-align: center;line-height: 1.7;
        }
        .count-number{
            font-weight: bolder;font-size: 18px;
        }
        .count-text{
            font-weight: bolder;
        }

        .font-red{
            color: #F96868;
        }
        .font-blue{
            color: #62A8EA;
        }
        .font-green{
            color: #46BE8A;
        }
        .font-yellow{
            color: #F2A654;
        }
    </style>
</head>
<body style="background-color: #FAFAFA;">
<div class="container-fluid">
    <div class="row row-padding row-margin">
        <div class="col-md-12 no-padding">
            <div class="title">
                <i class="fa fa-fw fa-list-alt" aria-hidden="true"></i>&nbsp;控制台
                &nbsp;&nbsp;
                <button isShow="" type="button" class="btn btn-sm btn-primary" onclick="subject.start()">
                    <i class="fa fa-play" aria-hidden="true"></i>&nbsp;开始监控
                </button>
                &nbsp;&nbsp;
                <button isShow="" type="button" class="btn btn-sm btn-info" onclick="subject.stop()">
                    <i class="fa fa-stop" aria-hidden="true"></i>&nbsp;暂停监控
                </button>
                &nbsp;&nbsp;
                <span id="state"><span>
                <%--<button isShow="" type="button" class="btn btn-sm btn-warning" onclick="$('#console').html('')">
                    <i class="fa fa-stop" aria-hidden="true"></i>&nbsp;清空控制台
                </button>--%>
            </div>
        </div>
    </div>
    <%--<div class="row row-padding">
        <div class="col-md-8" style="background-color: white;padding-top: 15px;padding-bottom: 15px;" id="nodeList">
            <table class="table table-bordered table-striped" style="margin-bottom: 0px;">
                <thead>
                    <tr>
                        <th width="100px">协议</th>
                        <th>节点IP</th>
                        <th width="100px">端口号</th>
                        <th>监视器URI</th>
                    </tr>
                </thead>
                <tbody id="nodeBox">
                    <tr>
                        <td>
                            <input type="text" class="form-control input-sm" value="http://"/>
                        </td>
                        <td>
                            <input type="text" class="form-control input-sm" value="<%=request.getServerName()%>"/>
                        </td>
                        <td>
                            <input type="text" class="form-control input-sm" value="<%=request.getServerPort()%>"/>
                        </td>
                        <td>
                            <input type="text" class="form-control input-sm" value="/common/monitor/getStatus"/>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" align="center">
                            <button type="button" class="btn btn-sm btn-success" onclick="appendTr()">
                                <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;添加一行
                            </button>
                            &nbsp;&nbsp;
                            <button type="button" class="btn btn-sm btn-success" onclick="delTr()">
                                <i class="fa fa-minus" aria-hidden="true"></i>&nbsp;删除一行
                            </button>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="col-md-4" style="background-color: white;padding-top: 15px;padding-bottom: 15px;height:auto;max-height: 200px;overflow-y: auto;word-break: break-all;" id="console">

        </div>
    </div>--%>

    <div class="row row-padding row-margin">
        <div class="col-md-12 no-padding">
            <div class="title"><i class="fa fa-fw fa-desktop" aria-hidden="true"></i>&nbsp;节点参数</div>
        </div>
    </div>
    <div class="row row-padding">
        <div class="col-md-12" style="background-color: white;padding-top: 15px;padding-bottom: 15px;">
            <table class="table table-bordered table-hover table-striped" id="baseList" style="margin-bottom: 0px;">
                <col field="_seq" title="#" width="4%" align=""/>
                <col field="ip" title="ip" width="15%" align=""/>
                <col field="osName" title="操作系统" width="12%" align=""/>
                <col field="javaVersion" title="java版本" width="12%" align=""/>
                <col field="jvmName" title="JVM" width="15%" align=""/>
                <col field="fileEncoding" title="文件编码" width="10%" align=""/>
                <col field="userName" title="操作系统用户" width="12%" align=""/>
                <col field="{userTimezone}<br/>{userCountry} - {userLanguage}" title="时区-地区" width="15%" align=""/>
                <col field="[=getMemUse({freeMemory},{totalMemory})]" title="内存使用(%)" width="12%" align=""/>
            </table>
        </div>
    </div>
    <div class="row row-padding row-margin">
        <div class="col-md-12 no-padding">
            <div class="title"><i class="fa fa-fw fa-random" aria-hidden="true"></i>&nbsp;线程监控</div>
        </div>
    </div>
    <div class="row row-padding">
        <div class="col-sm-3 col-xs-6 no-padding">
            <div class="count">
                <div class="count-number font-blue" id="currentThreadCount">0</div>
                <div class="count-text">当前线程数(含守护线程)</div>
            </div>
        </div>
        <div class="col-sm-3 col-xs-6 no-padding">
            <div class="count">
                <div class="count-number font-green" id="daemonThreadCount">0</div>
                <div class="count-text">守护线程数</div>
            </div>
        </div>
        <div class="col-sm-3 col-xs-6 no-padding">
            <div class="count">
                <div class="count-number font-red" id="peakThreadCount">0</div>
                <div class="count-text">峰值线程数</div>
            </div>
        </div>
        <div class="col-sm-3 col-xs-6 no-padding">
            <div class="count">
                <div class="count-number font-yellow" id="totalThreadCount">0</div>
                <div class="count-text">启动过的线程总数</div>
            </div>
        </div>
    </div>
    <div class="row row-padding row-margin">
        <div class="col-md-12 no-padding">
            <div class="title"><i class="fa fa-fw fa-cubes" aria-hidden="true"></i>&nbsp;JVM内存使用</div>
        </div>
    </div>
    <div class="row row-padding">
        <div class="col-md-3 no-padding">
            <div id="memoryGauge" style="height: 250px;"></div>
        </div>
        <div class="col-md-9 no-padding">
            <div id="memoryLine" style="height: 250px;"></div>
        </div>
    </div>
    <div class="row row-padding" style="border-top: #E7EAEC solid 1px;">
        <div class="col-sm-4 no-padding">
            <div class="count">
                <div class="count-number font-blue" id="totalMemory">0</div>
                <div class="count-text">内存总量(kb)</div>
            </div>
        </div>
        <div class="col-sm-4 no-padding">
            <div class="count">
                <div class="count-number font-green" id="freeMemory">0</div>
                <div class="count-text">空闲内存(kb)</div>
            </div>
        </div>
        <div class="col-sm-4 no-padding">
            <div class="count">
                <div class="count-number font-yellow" id="maxMemory">0</div>
                <div class="count-text">最大内存(kb)</div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="container-fluid no-padding">
                <div class="row row-padding row-margin">
                    <div class="col-md-12 no-padding">
                        <div class="title"><i class="fa fa-fw fa-server" aria-hidden="true"></i>&nbsp;内存区监控</div>
                    </div>
                </div>
                <div class="row row-padding">
                    <div class="col-md-12" style="background-color: white;padding-top: 15px;padding-bottom: 15px;">
                        <table class="table table-bordered table-hover table-striped" id="memoryPoolList" style="margin-bottom: 0px;" trHandle="mpTrHandle">
                            <col field="name" title="内存区" width="20%" align="" event="click"/>
                            <col field="init" title="初始化(kb)" width="15%" align="right"/>
                            <col field="used" title="已使用(kb)" width="15%" align="right"/>
                            <col field="committed" title="可用(kb)" width="15%" align="right"/>
                            <col field="max" title="最大值(kb)" width="15%" align="right"/>
                            <col field="{usageThresholdCount} 次" title="超出阀值" width="15%" align=""/>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="container-fluid no-padding">
                <div class="row row-padding row-margin">
                    <div class="col-md-12 no-padding">
                        <div class="title"><i class="fa fa-fw fa-fire-extinguisher" aria-hidden="true"></i>&nbsp;GC监控</div>
                    </div>
                </div>
                <div class="row row-padding">
                    <div class="col-md-12" style="background-color: white;padding-top: 15px;padding-bottom: 15px;">
                        <table class="table table-bordered table-hover table-striped" id="gcList" style="margin-bottom: 0px;">
                            <col field="name" title="垃圾收集器" width="25%" align="" event="click"/>
                            <col field="count" title="GC次数" width="15%" align=""/>
                            <col field="time" title="GC总耗时(ms)" width="15%" align=""/>
                            <col field="[={time}/1000]" title="GC总耗时(s)" width="15%" align=""/>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
