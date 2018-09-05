<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>社保计算器</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp" %>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp" %>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp" %>
    <%--jo--%>
    <%@ include file="/common/joHead.jsp" %>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/layui.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/font/font2/iconfont.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/home.css">
    <script src="<%=URL_STATIC%>static/prototype/js/layui.js"></script>
    <script src="<%=URL_STATIC%>static/prototype/js/sal-calculator_no.js"></script>
    <script src="<%=URL_STATIC%>static/prototype/js/cityMap_no.js"></script>
    <style>
        .layui-input-inline {
            width: 180px;
        }

        .layui-input-inline input {
            height: 32px;
            background: #FCFCFC;
            border: 1px solid #DDDDDD;
            border-radius: 4px;
        }

        .layui-form {
            padding-top: 30px;
            padding-bottom: 30px;
            /* padding-right: 30px; */
            position: relative;
        }

        .edit-item {
            margin-bottom: 10px;
        }

        .lang input {
            width: 490px;
        }

        .layui-form-label {
            width: 100px;
            font-size: 12px;
            color: #4A4A4A;
            font-family: 'PingFangSC-Regular', "Arial", "Microsoft YaHei", "黑体", "宋体", sans-serif;
        }

        button.reset {
            width: 220px;
            background: #FFFFFF;
            border: 1px solid #378CEF;
            border-radius: 4px;
            color: #378CEF;
        }

        button.reset:hover {
            color: #378CEF;
            border: 1px solid #378CEF;
        }

        button.count {
            width: 220px;
            background: #62abff;
            color: #fff;
            border-color: #62abff;
        }

        button.count:hover {
            color: #fff;
        }

        .line {
            width: 100%;
            height: 1px;
            background: #E9E9E9;
            margin-top: 22px;
            margin-bottom: 16px;
        }

        .result {
            font-size: 18px;
            color: #000000;
            letter-spacing: 0;
            font-family: 'PingFangSC-Regular', "Arial", "Microsoft YaHei", "黑体", "宋体", sans-serif;
            text-align: center;
            margin-bottom: 10px;
        }

        .box0 {
            width: 180px;
            float: left;
            display: inline;
        }

        .box1 {
            width: 180px;
            float: left;
            display: inline;
        }

        .box2 {
            width: 180px;
            float: left;
            display: inline;
        }
    </style>
    <script type="text/javascript">
        //计算按钮
        $("#compute").click(function () {
            if (!currCityObj) {
                alert("没有获取到城市数据");
                return;
            }
            var inputSally = $("#salText"), salVal = inputSally.val();
            if (!rg.test(salVal)) {//输入的薪资不是数字时，薪资设置为0
                salVal = 0;
                inputSally.val(salVal);
            } else {
                salVal = salVal * 1;
            }
            //社保基数
            var socBase = $("#socialBase"), baSoVal = socBase.val();
            if (!rg.test(baSoVal)) {
                socBase.val(currCityObj.baseInsur);
            } else {
                currCityObj.baseInsur = baSoVal * 1;
            }
            //公积金基数
            var funBase = $("#afundsBase"), baFuVal = funBase.val();
            if (!rg.test(baFuVal)) {
                funBase.val(currCityObj.basefunds);
            } else {
                currCityObj.basefunds = baFuVal * 1;
            }
            //税收起征点
            var threshold = parseFloat($('#threshold').val() || 0);
            // 是否交公积金
            var checkedHousing = $(".moreother input:first").prop("checked");
            //根据当前的收入计算保险及缴税费用
            var salDetail = incomeDetail(salVal, currCityObj, proportion, threshold, checkedHousing);
            $(".tables-cont").css("display", "block");
            //显示数据到表格
            $(".pie-chart").css("display", "block");
            $(".my-salary").css("display", "block");
            showDetail(salDetail);
            //绘制税后薪资饼图
            afterSalary(salDetail);
            //绘制个人薪资详情饼图
            personDetail(salDetail);
            //单位成本详情饼图
            companyDetail(salDetail);
            // 显示推荐职位
            posRecommend(currCityId, salVal);
            //评星效果
            get_rate(salDetail.salAfterTax);
        });
    </script>
</head>

<body>
<form class="layui-form layui-row" action="">
    <input id="curr-city" type="hidden" value="530">

    <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
        <label class="layui-form-label">税前工资</label>
        <div class="layui-input-inline">
            <input id="salText" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
        元
    </div>

    <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
        <label class="layui-form-label">起 征 点：</label>
        <div class="layui-input-inline">
            <select name="" lay-verify="" id="threshold">
                <option value="3500">3500</option>
                <option value="4800">4800</option>
            </select>
        </div>

    </div>
    <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
        <label class="layui-form-label">社保基数：</label>
        <div class="layui-input-inline">
            <input id="socialBase" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
   <%-- <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
        <label class="layui-form-label">公积金基数：</label>
        <div class="layui-input-inline">
            <input id="afundsBase" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>--%>
    <div class="edit-item layui-col-md10 layui-col-xs10 layui-col-md-offset1 layui-col-xs-offset1"
         style="text-align: center;">
        <button class="layui-btn layui-btn-primary reset">重置</button>
        <button id="compute" class="layui-btn layui-btn-primary count" type="button">计算</button>
    </div>

    <div class="line edit-item layui-col-md12 layui-col-xs12"></div>


    <div class="container">
        <div class="box0">
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                <label class="layui-form-label"></label>
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                养老保险金：
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                医疗保险金：
            </div>

            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                失业保险金：
            </div>
          <%--  <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                基本住房公积金：
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                补充住房公积金：
            </div>--%>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                工伤保险金：
            </div>

            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                生育保险金：
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                共计支出：
            </div>

            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                扣除四金后月薪：
            </div>

            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                个人所得税：
            </div>

            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">

                税后月薪：
            </div>


        </div>
        <div class="box1">

            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span> 个人应缴部分  </span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gr_yl"></span>&emsp;
                    <span id="gr_yl_sl"></span>

                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gr_yiliao"></span>&emsp;
                    <span id="gr_yiliao_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gr_sy"></span>&emsp;
                    <span id="gr_sy_sl"></span>
                </div>

            </div>
           <%-- <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gr_gjj"></span>&emsp;
                    <span id="gr_gjj_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="show_personal_exgjj"></span>&emsp;
                    <span>(0%)</span>
                </div>

            </div>--%>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span></span>
                    <span></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span></span>
                    <span></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gr_zzc"></span>
                    <span></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="sh_yx"></span>
                    <span></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="geshui"></span>
                    <span></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="sh_xz"></span>
                    <span></span>
                </div>

            </div>
        </div>
        <div class="box2">
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span> 单位应缴部分</span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_yl"></span>&emsp;
                    <span id="gs_yl_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_yiliao"></span>&emsp;
                    <span id="gs_yiliao_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_sy"></span>&emsp;
                    <span id="gs_sy_sl"></span>
                </div>

            </div>
          <%--  <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_gjj"></span>&emsp;
                    <span id="gs_gjj_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="show_org_exgjj"></span>&emsp;
                    <span>(0%)</span>
                </div>

            </div>--%>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_gs"></span>&emsp;
                    <span id="gs_gs_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_shengyu"></span>&emsp;
                    <span id="gs_shengyu_sl"></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span id="gs_zzc"></span>
                    <span></span>
                </div>

            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <div class="layui-input-inline">
                    <span> </span>
                    <span></span>
                </div>
                <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                    <div class="layui-input-inline">
                        <span> </span>
                        <span></span>
                    </div>

                </div>
                <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                    <div class="layui-input-inline">
                        <span> </span>
                        <span></span>
                    </div>

                </div>
            </div>
        </div>
    </div>


</form>


<script>
    $(function () {
        layui.use(['form', 'laydate'], function () {
            var form = layui.form;
            var laydate = layui.laydate;
            // laydate.render({
            //     elem: '#time',
            // });
        });
    })
</script>
</body>

</html>