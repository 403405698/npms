<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>社保计算器</title>
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
    </head>

    <body>
    <input id="curr-city" type="hidden" value="530">
        <form class="layui-form layui-row" action="">
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">收入类型</label>
                <div class="layui-input-inline">
                    <select name="" lay-verify="">
                                <option value=""></option>
                                <option value="工资、薪金所得(月薪)">工资、薪金所得(月薪)</option>
                            </select>
                </div>
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">税前工资</label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">各项社会保险费</label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">起征点</label>
                <div class="layui-input-inline">
                    <select name="" lay-verify="">
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
                <button class="layui-btn layui-btn-primary count">计算</button>
            </div>

            <div class="line edit-item layui-col-md12 layui-col-xs12"></div>

            <div class="layui-col-md12 layui-col-xs12 result">
                个人所得税计算结果
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">应纳税所得额</label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="0">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">适用税率 </label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="0">
                </div>
                %
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">速算扣除数</label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="0">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">应缴税款</label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="1200">
                </div>
                元
            </div>
            <div class="edit-item layui-col-md8 layui-col-xs8 layui-col-md-offset2 layui-col-xs-offset2">
                <label class="layui-form-label">实发工资</label>
                <div class="layui-input-inline">
                    <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" value="11300">
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