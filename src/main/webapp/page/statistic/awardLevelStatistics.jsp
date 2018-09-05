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
    <script src="<%=URL_STATIC%>static/plugin/echarts/echarts.js"></script>
    <title>奖励情况分布统计</title>
    <script type="text/javascript">
        //系统录入所有人员数量
        var allUserCount;
        //获取系统录入所有人员数量
        getAllUserCount();
        //系统录入所有科技奖数量
        var allTechAwardCount;
        //获取系统录入所有科技奖数量
        getAllTechAwardsCount();

        //奖励层次国家级
        var awardLevel;
        //奖励层次省部级
        var awardLeve2;
        //奖励层次厅级及以下
        var awardLeve3;
        var deptId;

        //初始化图表属性
        $(function(){

            //加载角色信息
            getRoleNameAndDeptName();

            //加载奖励层次数据
            loadAwardLevel();
            //加载奖励层次饼状图
            var myChart1 = echarts.init(document.getElementById("awardLevelPie"));
            myChart1.setOption(option1);

            //加载奖励层次柱状图
            var myChart2 = echarts.init(document.getElementById("awardLevelBar"));
            myChart2.setOption(option2);

            //加载系统总人数
            $("#allAwardsCount").html(allTechAwardCount);

        });





        //加载奖励层次属性
        function loadAwardLevel(){
            jo.postAjax("pms/statistic/getAwardLevel",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    //国家级
                    awardLevel = info["attr1"];
                    //省部级
                    awardLeve2 = info["attr2"];
                    //厅级及以下
                    awardLeve3 = info["attr3"];

                    //尚无资料
                    noInfo = allTechAwardCount - awardLevel - awardLeve2 - awardLeve3;
                    if(noInfo<0){
                        noInfo = 0;
                    }
                    //加载奖励层次饼状图
                    option1 = {
                        title : {
                            text: '奖励层次分布饼状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: ['国家级','省部级','厅级及以下','尚未填写']
                        },
                        series : [
                            {
                                name: '奖励层次',
                                type: 'pie',
                                radius : '55%',
                                center: ['50%', '60%'],
                                label: {
                                    normal: {
                                        show: true,
                                        formatter: '{b}: {c}({d}%)'
                                    }
                                },
                                data:[
                                    {value:awardLevel, name:'国家级'},
                                    {value:awardLeve2, name:'省部级'},
                                    {value:awardLeve3, name:'厅级及以下'},
                                    {value:noInfo, name:'尚未填写'}
                                ],
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



                    //柱状图
                    option2 = {
                        title : {
                            text: '奖励层次分布柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['国家级','省部级','厅级及以下','尚未填写'],
                            axisLabel :{
                                interval:0,
                                rotate:0,
                                formatter:function(val){
                                    return val.split("").join("\n");
                                }
                            }
                        },
                        yAxis: {
                            type: 'value'
                        },
                        grid: { // 控制图的大小，调整下面这些值就可以，
                            x: 40,
                            x2: 100,
                            y2: 180,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
                        },
                        series: [{
                            label: {
                                normal: {
                                    show: true,
                                    formatter: '{c}'
                                }
                            },
                            data: [awardLevel, awardLeve2,awardLeve3, noInfo],
                            type: 'bar',
                            itemStyle: {
                                emphasis: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }]
                    };


                    var list = [];
                    list.push({option:"国家级", num:awardLevel});
                    list.push({option:"省部级", num:awardLeve2});
                    list.push({option:"厅级及以下", num:awardLeve3});
                    list.push({option:"尚无填写", num:noInfo});
                    list.push({option:"总数", num:allTechAwardCount});
                    Grid("awardLevelList").loadData(list);



                }
            });
        }
        //查询系统内所有用户数量
        function getAllUserCount(){
            jo.postAjax("pms/statistic/getAllUserCount",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    allUserCount = info["attr1"];
                }
            });
        }


        //查询系统内所有科技奖数量
        function getAllTechAwardsCount(){
            jo.postAjax("pms/statistic/getAllTechAwardsCount",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    allTechAwardCount = info["attr1"];
                }
            });
        }

        //1.获取部门名称、角色名称、部门编号
        //2.根据角色名称查询部门人数
        function getRoleNameAndDeptName(){
            jo.postAjax("pms/statistic/getRoleNameAndDeptName",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    deptName = data[4];
                    roleName = data[1];

                    if("人事处"==roleName){
                        $("#personType").show();
                    }else if(roleName.indexOf("二级单位领导")>-1){
                        deptId = data[2];
                        $("#deptId").hide();
                        $("#deptOtherName").html(deptName);
                    }
                }
            });
        }
    </script>

</head>
<body>
<div class="container-fluid" style="margin: 15px 0px;">

    <div class="row">
        <div class="col-xs-12 form-inline">
            <div class="form-group">
                <label class="control-label">部门：&nbsp;</label>
                <select id="deptId" name="deptId" class="joSelect form-control input-sm" data="" dataurl="pms/statistic/getDeptList" keyfield="deptId" valuefield="deptName" firstitem='{"deptId":"","deptName":""}'></select>
                <span id="deptOtherName"></span>
            </div>
            <button type="button" class="btn btn-primary btn-sm" onclick="loadInfo()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div id="a" style="width: 100%;height: 80px;float: left;border: 1px solid silver;text-align: center;background-color: aliceblue;">
                <h3>环科院科技奖数量统计</h3>
                <h5 >系统录入所有科技奖数量：<span id="allAwardsCount"></span></h5>
            </div>
        </div>
    </div>

    <div class="row" style="margin-top: 15px;">
        <div class="col-sm-6 col-md-6 col-lg-6">
            <div id="awardLevelPie" style="height: 600px;"><%--奖励层次情况饼状图--%>
            </div>
        </div>
        <div class="col-sm-6 col-md-6 col-lg-6">
            <div id="awardLevelBar" style="height: 600px;"><%--奖励层次情况柱状图--%>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 15px;margin-bottom: 15px;">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <table class="table table-bordered table-hover table-striped table-condensed" id="awardLevelList" style="">
                <col field="_seq" title="排序" width="20%" align=""/>
                <col field="option" title="奖励层次" width="50%" align=""/>
                <col field="num" title="数量" width="30%" align="" order="num"/>
            </table>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
