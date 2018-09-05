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
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>YOUNG</title>
    <script type="text/javascript">
        $(function () {
            var panelgis = new Ext.Panel({
                id: 'panelgis',
                title: 'GIS',
                region: 'center',
                height: $(window).height(),
                layout: "fit",
                margins: '0 0 0 0',
                renderTo:'map',
                collapsible: false,
                resizable: false,
                listeners:
                {
                    'resize': function (p, width, heigth, oldwidth, oldheigth, obj) {
                        this.doLayout();
                    }
                }
            });
            var options = {
                topToolBar: false,
                layerManagerDisplay: false,
                initRestrictExtent: YCGIS.CreateExtent('-180', '-90', '180', '90'),
                //projection: "EPSG:3857",
                InitLayerFlag: "TotalGis",
                useAutomaticLegend: false
            };

            // YCGIS.SetPath("/GIS/");
            YCGIS.SetMapPath();
            var gisPanel = YCGIS.CreateGisPanel("gispanel", options);
            panelgis.add(gisPanel);
            YCGIS.SetMapCenter(YCGIS.Map, 116, 40, 10);
            YCGIS.GisPanelRefresh(gisPanel, panelgis);
        });
        //搜索提示
        function searchPrompt(){
            $('#searchTips').show();
        }
        //关闭搜索提示
        function closePrompt(){
            $('#searchTips').hide();
        }
        //切换为路线查询
        function changeWay(){
            closePrompt();//关闭搜索提示
            $("#searchWay").show();
        }
        //关闭路线查询
        function closeWay(){
            $("#searchWay").hide();
        }
        //路线tab点击事件
        function wayTabClk(obj){
            $(obj).parent().children().removeClass("way-cur");
            $(obj).addClass("way-cur");
        }
    </script>
    <style>
        html,body,.full-screen{
            width: 100%;
            height: 100%;
            background-color: grey;
        }
        .map-search-bar{
            width: 425px;
            height: auto;
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 800;
        }
        .map-search-tips{
            width: 370px;
            height: auto;
            display: none;
            background-color: white;
        }
        .map-search-way{
            width:370px;
            height: auto;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: 801;
            display: none;
            background-color: white;
        }
        .map-search-way-content{
            width: 100%;
            padding: 5px 35px;
        }
        .border-none{
            border:none;
        }
        .map-way-inp{
            width: 100%;
            height: 35px;
            line-height: 35px;
        }
        .way-cur{
            border: #DDDDDD solid 1px;
            border-bottom: white solid 1px;
            padding: 0px;
            margin: 0px;
            font-weight: bold;
        }

        .olButton,#panelgis_header{
            display: none;
        }
    </style>
    <link href="http://111.202.160.39:8088/Module/Turangjiance/map/GIS/YCGISCss/style.css" rel="stylesheet" />
    <link href="http://111.202.160.39:8088/Module/Turangjiance/map/Ext4/resources/css/ext-all.css" rel="stylesheet" />
    <script src="http://111.202.160.39:8088/Module/Turangjiance/map/Ext4/ext-all.js"></script>
    <script src="http://111.202.160.39:8088/Module/Turangjiance/map/Ext4/locale/ext-lang-zh_CN.js"></script>
</head>
<body>
<%--检索区域--%>
<div class="map-search-bar">
    <div class="input-group" style="box-shadow: grey;">
        <%--搜索框,当光标移入时触发搜索提示--%>
        <input type="text" class="form-control border-none" placeholder="搜地点、查公交、找路线" onfocus="searchPrompt()">
        <span class="input-group-btn">
            <button class="btn btn-default border-none" style="border-left: #EEEEEE solid 1px;" type="button" onclick="changeWay()" onmouseover="window.tidx1 = jo.tips('路线',this,{tips:3});" onmouseout="jo.close(tidx1);">
                <i class="fa fa-search" aria-hidden="true"></i>
            </button>
            <button class="btn btn-default border-none" type="button" onmouseover="window.tidx2 = jo.tips('搜索',this,{tips:3});" onmouseout="jo.close(tidx2);" style="width: 55px;background-color: #3385FF;color: white;">
                <i class="fa fa-search" aria-hidden="true"></i>
            </button>
        </span>
    </div>
    <%--搜索提示,光标移入输入框时触发--%>
    <div class="map-search-tips padding-12" id="searchTips">
        <br/>
        <div style="margin-left:20px;background-color: #009f95; font-size: 16px; color: white;float: left;width: 80px;height: 40px;line-height: 40px;text-align: center;">
            酒店
        </div>
        <div style="margin-left:20px;background-color: #1AB394; font-size: 16px; color: white;float: left;width: 80px;height: 40px;line-height: 40px;text-align: center;">
            美食
        </div>
        <div style="margin-left:20px;background-color: #4C9ED9; font-size: 16px; color: white;float: left;width: 80px;height: 40px;line-height: 40px;text-align: center;">
            景点
        </div>
        <div style="clear: both;"></div>
        <br/>
        <p style="padding-left: 20px;">环境科学研究院</p>
        <p style="padding-left: 20px;">天宫院</p>
        <br/>
    </div>
    <%--/搜索提示--%>
    <%--路线查询--%>
    <div class="map-search-way" id="searchWay">
        <ul class="nav nav-tabs">
            <li class="way-cur" onclick="wayTabClk(this)"><a style="height: 33px;width: 75px;text-align: center;" href="javascript:">公交</a></li>
            <li onclick="wayTabClk(this)"><a style="height: 33px;width: 75px;text-align: center;" href="javascript:">驾车</a></li>
            <li onclick="wayTabClk(this)"><a style="height: 33px;width: 75px;text-align: center;" href="javascript:">步行</a></li>
            <li onclick="wayTabClk(this)"><a style="height: 33px;width: 75px;text-align: center;" href="javascript:">骑行</a></li>
        </ul>

        <%--关闭路线查询按钮--%>
        <button style="position: absolute;right: 0px;top: 0px;border-left: #EEEEEE solid 1px;" class="btn btn-default border-none" type="button" onclick="closeWay()" onmouseover="window.tidx3 = jo.tips('关闭路线',this,{tips:3});" onmouseout="jo.close(tidx3);">
            <i class="fa fa-close" aria-hidden="true"></i>
        </button>

        <div class="map-search-way-content">
            <input type="text" class="map-way-inp border-none" placeholder="输入起点或在图区上选点"/>
            <hr style="padding: 0px;margin: 0px;"/>
            <input type="text" class="map-way-inp border-none" placeholder="输入终点"/>
        </div>


    </div>
    <%--/路线查询--%>
</div>
<%--/检索区域--%>

<%--地图区域--%>
<div id="map" class="full-screen"></div>
<%--/地图区域--%>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<script src="http://111.202.160.39:8088/Module/Turangjiance/map/GIS/YCGIS1.js"></script>
<script src="http://111.202.160.39:8088/Module/Turangjiance/map/GIS/uybus.js"></script>
</body>
</html>
