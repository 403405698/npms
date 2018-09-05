<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>个人所得税计算器</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--jo--%>
    <%@ include file="/common/joHead.jsp"%>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/layui.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/font/font2/iconfont.css">
    <script src="<%=URL_STATIC%>static/prototype/js/layui.js"></script>
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
        </style>
    <script type="text/javascript">
        function clearResult_index()
        {
            $("#lblTaxableIncome")[0].innerText="0";
            $("#lblTaxRate")[0].innerText="0";
            $("#lblQuick")[0].innerText="0";
            $("#txtTax")[0].value="";
            $("#txtRealIncome")[0].value="";
        }
        ////////////////////////index
        function btnCalc_onClick_index()
        {
            clearResult_index();
            var income = parseFloat($("#txtIncome").val());
            if(isNaN(income)) {
                alert("无效的收入金额");
                $("#txtIncome")[0].focus();
                $("#txtIncome")[0].select();
                return;
            }
            $("#txtIncome").val(income);

            var insure = parseFloat($("#txtInsure").val());
            if(isNaN(insure)) {
                alert("无效的各项社会保险费金额");
                $("#txtInsure")[0].focus();
                $("#txtInsure")[0].select();
                return;
            }
            $("#txtInsure").val(insure);
            var baseLine=$("#selBaseLine").val();

            var taxableIncome = income - insure - baseLine;
            if(taxableIncome <=0){
                alert("您无需缴纳个人所得税!");
                $("#txtIncome")[0].focus();
                $("#txtIncome")[0].select();
                return;
            }

            var R,Q;
            var A=taxableIncome;
            A=A.toFixed(2);
            if(A<=1500){R=0.03;Q=0;}
            else if(A>1500 && A<=4500){R=0.1;Q=105}
            else if(A>4500 && A<=9000){R=0.2;Q=555}
            else if(A>9000 && A<=35000){R=0.25;Q=1005}
            else if(A>35000 && A<=55000){R=0.3;Q=2755}
            else if(A>55000 && A<=80000){R=0.35;Q=5505}
            else{R=0.45;Q=13505;}
            var tax=taxableIncome * R -Q;
            tax = Math.round(tax*100)/100;
            var realIncome=income - insure - tax;
            realIncome = Math.round(realIncome*100)/100;
            $("#lblTaxableIncome")[0].innerText=taxableIncome.toFixed(2);
            $("#lblTaxRate")[0].innerText=R*100;
            $("#lblQuick")[0].innerText=Q;
            $("#txtTax")[0].value=tax;
            $("#txtRealIncome")[0].value=realIncome;
            $("#txtIncome")[0].select();
        }
    </script>
    </head>

    <body>
        <form class="layui-form layui-row" action="">
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">收入类型</label>
                <div class="layui-input-inline">
                    <select name="" lay-verify="">
                              <%--  <option value=""></option>--%>
                                <option value="工资、薪金所得(月薪)">工资、薪金所得(月薪)</option>
                            </select>
                </div>
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">税前工资</label>
                <div class="layui-input-inline">
                    <input id="txtIncome" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">各项社会保险费</label>
                <div class="layui-input-inline">
                    <input id="txtInsure" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">起征点</label>
                <div class="layui-input-inline">
                    <select name="" lay-verify="" id="selBaseLine">
                                <option value=""></option>
                                <option value="3000">3000</option>
                                <option value="3500">3500</option>
                                <option value="4000">4000</option>
                            </select>
                </div>
                元
            </div>

            <div class="edit-item layui-col-md10 layui-col-xs10 layui-col-md-offset1 layui-col-xs-offset1" style="text-align: center;">
                <button class="layui-btn layui-btn-primary reset">重置</button>
                <button type="button"  id="btnCalc"  class="layui-btn layui-btn-primary count" onclick="btnCalc_onClick_index()">计算</button>
            </div>

            <div class="line edit-item layui-col-md12 layui-col-xs12"></div>

            <div class="layui-col-md12 layui-col-xs12 result">
                个人所得税计算结果
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">应纳税所得额</label>
                <div class="layui-input-inline">
                    <input id="lblTaxableIncome" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="0" readonly="readonly">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">适用税率 </label>
                <div class="layui-input-inline">
                    <input id="lblTaxRate" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="0" readonly="readonly">
                </div>
                %
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">速算扣除数</label>
                <div class="layui-input-inline">
                    <input id="lblQuick" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="0" readonly="readonly">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">应缴税款</label>
                <div class="layui-input-inline">
                    <input  id="txtTax" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input"readonly="readonly">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">实发工资</label>
                <div class="layui-input-inline">
                    <input id="txtRealIncome" type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" readonly="readonly">
                </div>
                元
            </div>
        </form>



        <script>
            $(function() {
                layui.use(['form', 'laydate'], function() {
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