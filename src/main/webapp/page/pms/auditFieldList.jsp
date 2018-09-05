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
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>自动化创建</title>
    <script type="text/javascript">
        var grid;
        $(function(){
            grid = new Grid($("#mainList"));
            var m = '<%=path%>';
            $("#moduleName").val(m.substring(1));
        });

        function selectTable(){
            var tableName = $("#table").val();
            if(tableName){
                jo.postAjax("{URL_CMS}cms/db/getColumsByTableName.action", {"tableName":tableName}, function(json){
                    if(json && json.code == "0"){
                        n = 0;
                        grid.loadData(json.data);
                        var str = up2Tuo(tableName);
                        if (tableName.indexOf("tb_") == 0 && tableName.indexOf("TB_")) {//去除tb开头的前缀
                            str = wordOne2Up(up2Tuo(tableName.substring(3)));
                        }
                        $("#ClassName").val(wordOne2Up(str));
                    }
                });
            }else{
                jo.alert("请选择数据库表");
            }
        }
        var n = 0;
        function getNum(){
            return ++n;
        }
        //定义代码生成用到的参数
        var tableName,className,pkName,pkVar,modelName,ClassName,namespace,classWholePath,packageName,remark,author,logFlag;
        //初始化参数
        function initParam(){
            tableName = $("#table").val();//表名
            packageName = jo.getDefVal($("#packageName").val(), "com.yy.young");//包名
            modelName = jo.getDefVal($("#moduleName").val(), "xx");
            pkName = jo.getDefVal($("#pkName").val(), "ID");//主键字段
            pkVar = up2Tuo(pkName);//主键字段对应的变量名
            remark = jo.getDefVal($("#remark").val(), "xxx");
            author = jo.getDefVal($("#author").val(), "rookie");
            if($("#ClassName").val()){
                ClassName = $("#ClassName").val();//模型类名
                className = wordOne2Low(ClassName);
            }else{
                className = up2Tuo(tableName);//表名驼峰格式
                if (tableName.indexOf("tb_") == 0 && tableName.indexOf("TB_")) {//去除tb开头的前缀
                    className = up2Tuo(tableName.substring(3));
                }
                ClassName = wordOne2Up(className);//模型类名
            }
            namespace = packageName+'.'+modelName+'.mapper.'+className;//mapper的namespace
            classWholePath = packageName+'.'+modelName+".model."+ClassName;//实体类全路径
            if(jo.getCheckBoxValue("log")){
                logFlag = true;
            }else{
                logFlag = false;
            }
        }
        //创建模型类
        function createModelClass(){
            var data = grid.data;
            if(data){
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.model;';
                code = appendLine(code, '', 0);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.type == "Date"){
                        code = appendLine(code, 'import java.util.Date;', 0);
                        code = appendLine(code, '', 0);
                        break;
                    }
                }
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'实体类', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '', 0);
                code += 'public class '+wordOne2Up(className)+"{\n";
                for(var i=0;i<data.length;i++){
                    code += "\n";
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    code += v.getBaseCode();
                }
                for(var i=0;i<data.length;i++){
                    code += "\n";
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    code += v.getGetterCode();
                    code += "\n";
                    code += v.getSetterCode();
                }
                code += "\n}";
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","模型类");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });

            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //java变量
        function Variable(name,type,remark,qualifier){
            this.name = up2Tuo(name);//变量名
            this.qualifier = jo.getDefVal(qualifier, "private");//修饰符
            if(type){
                if(type.indexOf("char") > -1 || type.indexOf("CHAR") > -1){
                    this.type = "String";
                }else if(type.indexOf("date") > -1 || type.indexOf("DATE") > -1 || type.indexOf("time") > -1){
                    this.type = "Date";
                }else if(type.indexOf("int") > -1 || type.indexOf("num") > -1 || type.indexOf("NUM") > -1){
                    this.type = "int";
                }else{
                    this.type = "String";
                }
            }else{
                this.type = "String";//变量类型
            }
            this.remark = jo.getDefVal(remark, this.name);//备注
            this.getBaseCode = function(){
                return "    "+this.qualifier + " " + this.type + " " + this.name + ";//"+this.remark;
            }
            this.getGetterCode = function(){
                var _c = "    "+'public '+this.type+" get"+wordOne2Up(this.name);
                _c += "() {\n";
                _c += "    "+"    return "+this.name+";";
                _c += "\n    "+"}";
                return _c;
            }
            this.getSetterCode = function(){
                var _c = "    "+"public void set"+wordOne2Up(this.name);
                _c += "("+this.type+" "+this.name+") {\n";
                _c += "    "+"    this."+this.name+" = "+this.name+";";
                _c += "\n    "+"}";
                return _c;
            }
        }
        //单词首字母大写
        function wordOne2Up(str){
            return str.substring(0,1).toUpperCase() + str.substring(1);
        }
        //单词首字母小写
        function wordOne2Low(str){
            return str.substring(0,1).toLowerCase() + str.substring(1);
        }
        //大写格式转驼峰
        function up2Tuo(str){
            if(jo.isValid(str)){
                var arr = str.split("_");
                if(arr.length > 1){
                    var s = arr[0].toLowerCase();
                    for(var i=1;i<arr.length;i++){
                        s += arr[i].substring(0,1).toUpperCase() + arr[i].substring(1).toLowerCase();
                    }
                    return s;
                }else{
                    return str.toLowerCase();
                }
            }else{
                return "";
            }
        }

        //创建mapper文件
        function createMapper(){
            var data = grid.data;
            if(data){
                initParam();
                var code = '<?xml version="1.0" encoding="UTF-8" ?>'
                        +'\n'+'<!DOCTYPE mapper'
                        +'\n'+'PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"'
                        +'\n'+'"http://mybatis.org/dtd/mybatis-3-mapper.dtd">'
                        +'\n'+'<mapper namespace="'+namespace+'">';
                code = appendLine(code, "<!--查询字段信息-->", 1);
                code = appendLine(code, '<sql id="searchCol">', 1);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(i != 0){
                        code = appendLine(code, ',O.'+item.field+' AS "'+ v.name+'"', 2);
                    }else{
                        code = appendLine(code, 'O.'+item.field+' AS "'+ v.name+'"', 2);
                    }

                }
                code = appendLine(code, "</sql>", 1);
                code = appendLine(code, "<!--关联查询相关sql-->", 1);
                code = appendLine(code, '<sql id="joinSql">', 1);
                code = appendLine(code, '</sql>', 1);
                code = appendLine(code, '<!-- 查询 -->', 1);
                code = appendLine(code, '<select id="get'+wordOne2Up(className)+'List" parameterType="'+classWholePath+'" resultType="'+classWholePath+'">', 1);
                code = appendLine(code, 'SELECT', 2);
                code = appendLine(code, '<include refid="searchCol"></include>', 3);
                code = appendLine(code, 'FROM '+tableName+' O', 2);
                code = appendLine(code, '<include refid="joinSql"></include>', 3);
                code = appendLine(code, '<where>', 2);
                code = appendLine(code, '<if test="'+pkVar+' != null and '+pkVar+' != \'\'">', 3);
                code = appendLine(code, 'AND O.'+pkName+' = #\{'+pkVar+'\}', 4);
                code = appendLine(code, '</if>', 3);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.name == "name"){
                        code = appendLine(code, '<if test="name != null and name != \'\'">', 3);
                        code = appendLine(code, 'AND O.NAME like \'%$\{name}%\'', 4);
                        code = appendLine(code, '</if>', 3);
                    }else if(v.name == "parentId"){
                        code = appendLine(code, '<if test="parentId != null and parentId != \'\'">', 3);
                        code = appendLine(code, 'AND O.PARENT_ID = #\{parentId}', 4);
                        code = appendLine(code, '</if>', 3);
                    }
                }
                code = appendLine(code, '</where>', 2);
                code = appendLine(code, '</select>', 1);
                code = appendLine(code, '<!--根据编号查询-->', 1);
                code = appendLine(code, '<select id="get'+wordOne2Up(className)+'ById" resultType="'+classWholePath+'">', 1);
                code = appendLine(code, 'SELECT', 2);
                code = appendLine(code, '<include refid="searchCol"></include>', 3);
                code = appendLine(code, 'FROM '+tableName+' O', 2);
                code = appendLine(code, '<include refid="joinSql"></include>', 3);
                code = appendLine(code, 'WHERE O.'+pkName+'=#\{'+pkVar+'\}', 2);
                code = appendLine(code, '</select>', 1);
                code = appendLine(code, '<!-- 插入 -->', 1);
                code = appendLine(code, '<insert id="insert" parameterType="'+classWholePath+'">', 1);
                code = appendLine(code, 'INSERT INTO '+tableName+'(', 2);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    if(i != 0){
                        code = appendLine(code, ','+item.field, 3);
                    }else{
                        code = appendLine(code, item.field, 3);
                    }
                }
                code = appendLine(code, ') VALUES(', 2);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(i != 0){
                        code = appendLine(code, ',#\{'+ v.name+'}', 3);
                    }else{
                        code = appendLine(code, '#\{'+ v.name+'}', 3);
                    }
                }
                code = appendLine(code, ')', 2);
                code = appendLine(code, '</insert>', 1);
                code = appendLine(code, '<!-- 修改 -->', 1);
                code = appendLine(code, '<update id="update" parameterType="'+classWholePath+'">', 1);
                code = appendLine(code, 'UPDATE '+tableName, 2);
                code = appendLine(code, '<set>', 2);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    if(item.field != pkName){//主键不进行修改
                        var v = new Variable(item.field, item.type, item.remark);
                        code = appendLine(code, '<if test="'+ v.name +' != null">', 3);
                        code = appendLine(code, item.field+' = #\{'+ v.name+'},', 4);
                        code = appendLine(code, '</if>', 3);
                    }
                }
                code = appendLine(code, '</set>', 2);
                code = appendLine(code, 'WHERE '+pkName+'=#\{'+pkVar+'}', 3);
                code = appendLine(code, '</update>', 1);
                code = appendLine(code, '<!-- 删除 -->', 1);
                code = appendLine(code, '<delete id="delete">', 1);
                code = appendLine(code, 'DELETE FROM '+tableName+' WHERE '+pkName+' = #\{'+pkVar+'}', 2);
                code = appendLine(code, '</delete>', 1);
                code = appendLine(code, '</mapper>', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","Mapper");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建服务接口
        function createService(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.service;';
                code = appendLine(code, '', 0);
                code = appendLine(code, 'import com.yy.young.dal.util.Page;', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.model.'+ClassName+';', 0);
                code = appendLine(code, 'import java.util.List;', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'服务接口', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, 'public interface I'+ClassName+'Service {', 0);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 获取数据列表', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, 'List<'+ClassName+'> get'+ClassName+'List('+ClassName+' '+className+') throws Exception;', 1);//list
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 获取数据列表(分页)', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @param page 分页参数', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, 'List<'+ClassName+'> get'+ClassName+'Page('+ClassName+' '+className+', Page page) throws Exception;', 1);//分页
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 根据'+pkVar+'获取信息', 1);
                code = appendLine(code, ' * @param '+pkVar, 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, ClassName+' get'+ClassName+'(String '+pkVar+') throws Exception;', 1);//one
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 修改', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, 'int update'+ClassName+'('+ClassName+' '+className+') throws Exception;', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 批量删除', 1);
                code = appendLine(code, ' * @param '+pkVar+'Arr '+pkVar+'数组', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, 'int delete'+ClassName+'(String[] '+pkVar+'Arr) throws Exception;', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 删除单条', 1);
                code = appendLine(code, ' * @param '+pkVar, 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, 'int delete'+ClassName+'(String '+pkVar+') throws Exception;', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 插入', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, 'int insert'+ClassName+'('+ClassName+' '+className+') throws Exception;', 1);
                code = appendLine(code, '', 1);
                code = appendLine(code, '}', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","Service服务接口类");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建服务实现
        function createServiceImpl(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.service.impl;';
                code = appendLine(code, '', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.service.I'+ClassName+'Service;', 0);
                code = appendLine(code, 'import com.yy.young.common.util.CommonUtil;', 0);
                code = appendLine(code, 'import com.yy.young.dal.service.IDataAccessService;', 0);
                code = appendLine(code, 'import com.yy.young.dal.util.Page;', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.model.'+ClassName+';', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.util.'+wordOne2Up(modelName)+'Constants;', 0);
                code = appendLine(code, 'import org.springframework.stereotype.Service;', 0);
                code = appendLine(code, 'import org.slf4j.Logger;', 0);
                code = appendLine(code, 'import org.slf4j.LoggerFactory;', 0);
                code = appendLine(code, 'import javax.annotation.Resource;', 0);
                code = appendLine(code, 'import java.util.List;', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'服务实现', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '@Service("'+className+'Service")', 0);
                code = appendLine(code, 'public class '+ClassName+'ServiceImpl implements I'+ClassName+'Service {', 0);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '@Resource(name = "dataAccessService")', 1);
                code = appendLine(code, 'IDataAccessService dataAccessService;//数据层服务', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, 'private static final Logger logger = LoggerFactory.getLogger('+ClassName+'ServiceImpl.class);', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//获取数据列表', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public List<'+ClassName+'> get'+ClassName+'List('+ClassName+' '+className+') throws Exception {', 1);//list
                code = appendLine(code, 'return dataAccessService.getList('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get'+ClassName+'List", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//获取数据列表(分页)', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public List<'+ClassName+'> get'+ClassName+'Page('+ClassName+' '+className+', Page page) throws Exception {', 1);//分页
                code = appendLine(code, 'return dataAccessService.getList('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get'+ClassName+'List", '+className+', page);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//查询单条', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public '+ClassName+' get'+ClassName+'(String '+pkVar+') throws Exception {', 1);//one
                code = appendLine(code, 'return ('+ClassName+')dataAccessService.getObject('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get'+ClassName+'By'+wordOne2Up(pkVar)+'", '+pkVar+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//修改', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int update'+ClassName+'('+ClassName+' '+className+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.update('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".update", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//批量删除', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int delete'+ClassName+'(String[] '+pkVar+'Arr) throws Exception {', 1);
                code = appendLine(code, 'int i = 0;', 2);
                code = appendLine(code, 'for(String '+pkVar+' : '+pkVar+'Arr){', 2);
                code = appendLine(code, 'i += this.delete'+ClassName+'('+pkVar+');', 3);
                code = appendLine(code, '}', 2);
                code = appendLine(code, 'return i;', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//删除单条', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int delete'+ClassName+'(String '+pkVar+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.delete('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".delete", '+pkVar+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//插入', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int insert'+ClassName+'('+ClassName+' '+className+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.insert('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".insert", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 1);
                code = appendLine(code, '}', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","Service服务实现类");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建web层
        function createController(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.web;';
                code = appendLine(code, '', 0);
                code = appendLine(code, 'import com.yy.young.common.util.CommonUtil;', 0);
                code = appendLine(code, 'import com.yy.young.common.util.Result;', 0);
                code = appendLine(code, 'import com.yy.young.common.util.StringUtils;', 0);
                code = appendLine(code, 'import com.yy.young.dal.util.Page;', 0);
                if(logFlag){
                    code = appendLine(code, 'import com.yy.young.interfaces.log.annotation.Log;', 0);
                }
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.model.'+ClassName+';', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.service.I'+ClassName+'Service;', 0);
                code = appendLine(code, 'import org.springframework.stereotype.Controller;', 0);
                code = appendLine(code, 'import org.springframework.web.bind.annotation.RequestMapping;', 0);
                code = appendLine(code, 'import org.springframework.web.bind.annotation.ResponseBody;', 0);
                code = appendLine(code, 'import javax.annotation.Resource;', 0);
                code = appendLine(code, 'import javax.servlet.http.HttpServletRequest;', 0);
                code = appendLine(code, 'import java.util.List;', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'服务', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '@Controller', 0);
                code = appendLine(code, '@RequestMapping("/'+modelName+'/'+className+'")', 0);
                code = appendLine(code, 'public class ' + ClassName + 'Controller {', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '@Resource(name="'+className+'Service")', 1);
                code = appendLine(code, 'I'+ClassName+'Service service;', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 获取数据列表', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @param request', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                if(logFlag){
                    code = appendLine(code, '@Log("查询'+remark+'列表")', 1);
                }
                code = appendLine(code, '@RequestMapping("/get'+ClassName+'List")', 1);
                code = appendLine(code, '@ResponseBody', 1);
                code = appendLine(code, 'public Object get'+ClassName+'List('+ClassName+' '+className+', HttpServletRequest request) throws Exception{', 1);
                code = appendLine(code, 'List<'+ClassName+'> list = service.get'+ClassName+'List('+className+');', 2);
                code = appendLine(code, 'return new Result(list);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 获取分页数据', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @param request', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                if(logFlag){
                    code = appendLine(code, '@Log("分页查询'+remark+'列表")', 1);
                }
                code = appendLine(code, '@RequestMapping("/get'+ClassName+'Page")', 1);
                code = appendLine(code, '@ResponseBody', 1);
                code = appendLine(code, 'public Object get'+ClassName+'Page('+ClassName+' '+className+', HttpServletRequest request) throws Exception{', 1);
                code = appendLine(code, 'Page page = CommonUtil.getPageFromRequest(request);', 2);
                code = appendLine(code, 'List<'+ClassName+'> list = service.get'+ClassName+'Page('+className+', page);', 2);
                code = appendLine(code, 'page.setData(list);', 2);
                code = appendLine(code, 'return page;', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 获取单条数据', 1);
                code = appendLine(code, ' * @param '+pkVar, 1);
                code = appendLine(code, ' * @param request', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                if(logFlag){
                    code = appendLine(code, '@Log("查询'+remark+'")', 1);
                }
                code = appendLine(code, '@RequestMapping("/get'+ClassName+'")', 1);
                code = appendLine(code, '@ResponseBody', 1);
                code = appendLine(code, 'public Object get'+ClassName+'(String '+pkVar+', HttpServletRequest request) throws Exception{', 1);
                code = appendLine(code, ''+ClassName+' '+className+' = service.get'+ClassName+'('+pkVar+');', 2);
                code = appendLine(code, 'return new Result('+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 新增', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @param request', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                if(logFlag){
                    code = appendLine(code, '@Log("新增'+remark+'")', 1);
                }
                code = appendLine(code, '@RequestMapping("/insert")', 1);
                code = appendLine(code, '@ResponseBody', 1);
                code = appendLine(code, 'public Object insert('+ClassName+' '+className+', HttpServletRequest request) throws Exception{', 1);
                code = appendLine(code, 'int num = service.insert'+ClassName+'('+className+');', 2);
                code = appendLine(code, 'return new Result();', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 修改', 1);
                code = appendLine(code, ' * @param '+className, 1);
                code = appendLine(code, ' * @param request', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                if(logFlag){
                    code = appendLine(code, '@Log("修改'+remark+'")', 1);
                }
                code = appendLine(code, '@RequestMapping("/update")', 1);
                code = appendLine(code, '@ResponseBody', 1);
                code = appendLine(code, 'public Object update('+ClassName+' '+className+', HttpServletRequest request) throws Exception{', 1);
                code = appendLine(code, 'int num = service.update'+ClassName+'('+className+');', 2);
                code = appendLine(code, 'return new Result();', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 删除', 1);
                code = appendLine(code, ' * @param ids', 1);
                code = appendLine(code, ' * @param '+pkVar, 1);
                code = appendLine(code, ' * @param request', 1);
                code = appendLine(code, ' * @return ', 1);
                code = appendLine(code, ' * @throws Exception', 1);
                code = appendLine(code, ' */', 1);
                if(logFlag){
                    code = appendLine(code, '@Log("删除'+remark+'")', 1);
                }
                code = appendLine(code, '@RequestMapping("/delete")', 1);
                code = appendLine(code, '@ResponseBody', 1);
                code = appendLine(code, 'public Object delete(String '+'ids, String '+pkVar+', HttpServletRequest request) throws Exception{', 1);
                code = appendLine(code, 'Result result = new Result();', 2);
                code = appendLine(code, 'if(StringUtils.isNotBlank(ids)) {', 2);
                code = appendLine(code, 'String[] idArr = ids.split(",");', 3);
                code = appendLine(code, 'int num = service.delete'+ClassName+'(idArr);', 3);
                code = appendLine(code, '}else if(StringUtils.isNotBlank('+pkVar+')){', 2);
                code = appendLine(code, 'int num = service.delete'+ClassName+'('+pkVar+');', 3);
                code = appendLine(code, '}else{', 2);
                code = appendLine(code, 'result.setCode(-1);', 3);
                code = appendLine(code, 'result.setInfo("删除失败:待删除编号无效!");', 3);
                code = appendLine(code, '}', 2);
                code = appendLine(code, 'return result;', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '}', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","web层");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建表单
        function createForm(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = '<script type="text/javascript">';
                code = appendLine(code, '$(function(){', 1);
                code = appendLine(code, 'var jParams = {', 2);
                code = appendLine(code, '"PKName" : "'+pkVar+'",//主键属性名', 3);
                code = appendLine(code, '"saveAfter" : "toEdit",', 3);
                code = appendLine(code, '"addUrl" : "'+modelName+'/'+className+'/insert.action",//新增', 3);
                code = appendLine(code, '"deleteUrl" : "'+modelName+'/'+className+'/delete.action",//删除', 3);
                code = appendLine(code, '"updateUrl" : "'+modelName+'/'+className+'/update.action",//修改', 3);
                code = appendLine(code, '"formDataUrl" : "'+modelName+'/'+className+'/get'+ClassName+'.action"	//查询', 3);
                code = appendLine(code, '};', 2);
                code = appendLine(code, 'joForm.initFormPage(jParams);//初始化', 2);
                code = appendLine(code, '});', 1);
                code = appendLine(code, '//初始化表单值前处理', 1);
                code = appendLine(code, 'joForm.initFormValueBefore = function(oJson){', 1);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.type == "Date"){//时间类型在表单初始化值的时候要格式化处理
                        code = appendLine(code, 'oJson.'+ v.name +' = jo.formatDate(oJson.'+ v.name +');', 2);
                    }
                }
                code = appendLine(code, '};', 1);
                code = appendLine(code, '<\/script>', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">', 0);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    var clk = '';
                    if(v.type == "Date"){
                        clk = 'onclick="laydate()"';
                    }
                    var mustCls = item.notNull == "1" ? " must" : "";
                    var mustChk = item.notNull == "1" ? " ErrEmpty" : "";
                    var wid = '';
                    if(i<2){
                        wid = ' width="15%"';
                    }
                    var name = v.name;
                    var remark = v.remark;
                    remark = remark.split(",")[0];
                    if(remark.length == 2){
                        remark = remark.substring(0,1) + "　　" + remark.substring(1);
                    }else if(remark.length == 3){
                        remark = remark.substring(0,1) + " " + remark.substring(1,2) + " " + remark.substring(2);
                    }
                    var readonly = '';
                    if(pkVar == name){
                        readonly = ' readonly-edit';
                    }
                    if(i%2 == 0){//第一列
                        if(i == (data.length-1)){//最后一个参数,合并行
                            code = appendLine(code, '<tr>', 1);
                            code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                            code = appendLine(code, '<td class="tnt" colspan="3">', 2);
                            code = appendLine(code, '<input type="text" '+clk+' name="'+ name +'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                            code = appendLine(code, '</td>', 2);
                            code = appendLine(code, '</tr>', 1);
                        }else{
                            code = appendLine(code, '<tr>', 1);
                            code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                            code = appendLine(code, '<td class="tnt">', 2);
                            code = appendLine(code, '<input type="text" '+clk+' name="'+name+'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                            code = appendLine(code, '</td>', 2);
                        }
                    }else{//第二列
                        code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                        code = appendLine(code, '<td class="tnt">', 2);
                        code = appendLine(code, '<input type="text" '+clk+' name="'+name+'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                        code = appendLine(code, '</td>', 2);
                        code = appendLine(code, '</tr>', 1);
                    }

                }
                code = appendLine(code, '</table>', 0);

                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","表单页面");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建视图
        function createView(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = '<script type="text/javascript">';
                code = appendLine(code, '$(function(){', 1);
                code = appendLine(code, 'joView.init({grid:$("#mainList"),PKName:"'+pkVar+'"});//初始化页面', 2);
                code = appendLine(code, '});', 1);
                code = appendLine(code, '//行处理', 1);
                code = appendLine(code, 'joView.handleItem = function(oItem,iIndex){', 1);
                code = appendLine(code, '', 2);
                code = appendLine(code, '};', 1);
                code = appendLine(code, '<\/script>', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '<table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="'+modelName+'/'+className+'/get'+ClassName+'Page.action" deleteUrl="'+modelName+'/'+className+'/delete.action" formUrl="page/'+modelName+'/'+className+'Form.jsp">', 0);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    var evt = '';
                    if(i == 0){
                        evt = ' event="click"';
                    }
                    if(v.type == "Date"){
                        code = appendLine(code, '<col field="[=jo.formatTime(\'{'+v.name+'}\')]" title="'+v.remark.split(",")[0]+'" width="15%" align=""'+evt+'/>', 1);
                    }else{
                        code = appendLine(code, '<col field="'+ v.name +'" title="'+v.remark.split(",")[0]+'" width="15%" align=""'+evt+'/>', 1);
                    }

                }
                code = appendLine(code, '</table>', 0);

                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","视图页面");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        /**
        * 在字符串后追加行
        * @param oldStr 原字符串
        * @param str 追加内容
        * @param tabNum 制表符个数,1个制表符=4个空格
         */
        function appendLine(oldStr, str, tabNum){
            var n = jo.getDefVal(oldStr,"") + "\n";//先换行
            if(tabNum){
                //追加制表符
                for(var i=0;i<tabNum;i++){
                    n += "    ";
                }
            }
            n += jo.getDefVal(str,"");
            return n;
        }
        //创建模型类(带excel导入导出注解)
        function createModelAboutExcel(){
            var data = grid.data;
            if(data){
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.model;';
                code = appendLine(code, '', 0);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.type == "Date"){
                        code = appendLine(code, 'import java.util.Date;', 0);
                        code = appendLine(code, '', 0);
                        break;
                    }
                }
                code = appendLine(code, 'import com.yy.young.common.core.excel.ExcelColumn;', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'实体类', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '', 0);
                code += 'public class '+wordOne2Up(className)+"{\n";
                for(var i=0;i<data.length;i++){
                    code += "\n";
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);//
                    code = appendLine(code, '@ExcelColumn(value = "'+ jo.getDefVal(v.remark, v.name)+'", order = '+(i+1)+')', 1);
                    code += "\n";
                    code += v.getBaseCode();
                }
                for(var i=0;i<data.length;i++){
                    code += "\n";
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    code += v.getGetterCode();
                    code += "\n";
                    code += v.getSetterCode();
                }
                code += "\n}";
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","模型类");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });

            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //创建服务实现(commonservice)
        function createServiceImpl2(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.service.impl;';
                code = appendLine(code, '', 0);
                //code = appendLine(code, 'import '+packageName+'.'+modelName+'.service.I'+ClassName+'Service;', 0);
                code = appendLine(code, 'import com.yy.young.common.util.CommonUtil;', 0);
                code = appendLine(code, 'import com.yy.young.dal.service.IDataAccessService;', 0);
                code = appendLine(code, 'import com.yy.young.dal.util.Page;', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.model.'+ClassName+';', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.util.'+wordOne2Up(modelName)+'Constants;', 0);
                code = appendLine(code, 'import com.yy.young.common.service.ICommonService;', 0);
                code = appendLine(code, 'import org.springframework.stereotype.Service;', 0);
                code = appendLine(code, 'import org.slf4j.Logger;', 0);
                code = appendLine(code, 'import org.slf4j.LoggerFactory;', 0);
                code = appendLine(code, 'import javax.annotation.Resource;', 0);
                code = appendLine(code, 'import java.util.List;', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'服务实现', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '@Service("'+className+'Service")', 0);
                code = appendLine(code, 'public class '+ClassName+'ServiceImpl implements ICommonService<'+ClassName+'> {', 0);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '@Resource(name = "dataAccessService")', 1);
                code = appendLine(code, 'IDataAccessService dataAccessService;//数据层服务', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, 'private static final Logger logger = LoggerFactory.getLogger('+ClassName+'ServiceImpl.class);', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//获取数据列表', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public List<'+ClassName+'> getList('+ClassName+' '+className+') throws Exception {', 1);//list
                code = appendLine(code, 'return dataAccessService.getList('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get'+ClassName+'List", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//获取数据列表(分页)', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public List<'+ClassName+'> getPage('+ClassName+' '+className+', Page page) throws Exception {', 1);//分页
                code = appendLine(code, 'return dataAccessService.getList('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get'+ClassName+'List", '+className+', page);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//查询单条', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public '+ClassName+' get('+ClassName+' '+className+') throws Exception {', 1);//one
                code = appendLine(code, 'return ('+ClassName+')dataAccessService.getObject('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get'+ClassName+'By'+wordOne2Up(pkVar)+'", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//修改', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int update('+ClassName+' '+className+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.update('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".update", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//批量删除', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int delete(String[] '+pkVar+'Arr) throws Exception {', 1);
                code = appendLine(code, 'int i = 0;', 2);
                code = appendLine(code, 'for(String '+pkVar+' : '+pkVar+'Arr){', 2);
                code = appendLine(code, 'i += this.delete('+pkVar+');', 3);
                code = appendLine(code, '}', 2);
                code = appendLine(code, 'return i;', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//删除单条', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int delete(String '+pkVar+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.delete('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".delete", '+pkVar+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//插入', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int insert('+ClassName+' '+className+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.insert('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".insert", '+className+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//批量插入', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int batchInsert(List<'+ClassName+'> list) throws Exception {', 1);
                code = appendLine(code, 'int i = 0;', 2);
                code = appendLine(code, 'for('+ClassName+' item : list){', 2);
                code = appendLine(code, 'i += this.insert(item);', 3);
                code = appendLine(code, '}', 2);
                code = appendLine(code, 'return i;', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 1);
                code = appendLine(code, '}', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","Service服务实现类");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //commonController
        function createController2(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.web;';
                code = appendLine(code, '', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.model.'+ClassName+';', 0);
                code = appendLine(code, 'import com.yy.young.common.service.ICommonService;', 0);
                code = appendLine(code, 'import com.yy.young.common.util.SpringContextHolder;', 0);
                code = appendLine(code, 'import com.yy.young.common.web.AbstractCommonController;', 0);
                code = appendLine(code, 'import org.springframework.stereotype.Controller;', 0);
                code = appendLine(code, 'import org.springframework.web.bind.annotation.RequestMapping;', 0);
                code = appendLine(code, 'import javax.servlet.http.HttpServletRequest;', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'服务', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '@Controller', 0);
                code = appendLine(code, '@RequestMapping("/'+modelName+'/'+className+'")', 0);
                code = appendLine(code, 'public class ' + ClassName + 'Controller extends AbstractCommonController<'+ClassName+'> {', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 初始化服务实例', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public void initService() {', 1);
                code = appendLine(code, 'this.service = SpringContextHolder.getBean("'+className+'Service");', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * 服务设置,当this.service为null时,会调用此方法返回一个service实例', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public ICommonService<'+ClassName+'> getServiceFromRequest(HttpServletRequest httpServletRequest) {', 1);
                code = appendLine(code, 'return null;', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 1);
                code = appendLine(code, ' * service方法参数加工,在此方法中对即将调用的服务参数做自定义处理并返回', 1);
                code = appendLine(code, ' */', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public '+ClassName+' backFinalParameter('+ClassName+' '+className+', HttpServletRequest httpServletRequest) {', 1);
                code = appendLine(code, 'return '+className+';', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '//除了常规的增删改查导入导出之外的操作,需要自行实现', 1);
                code = appendLine(code, '', 0);
                code = appendLine(code, '}', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","web层");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //创建表单
        function createForm2(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = '<script type="text/javascript">';
                code = appendLine(code, '$(function(){', 1);
                code = appendLine(code, 'var jParams = {', 2);
                code = appendLine(code, '"PKName" : "'+pkVar+'",//主键属性名', 3);
                code = appendLine(code, '"saveAfter" : "toEdit",', 3);
                code = appendLine(code, '"addUrl" : "'+modelName+'/'+className+'/insert.action",//新增', 3);
                code = appendLine(code, '"deleteUrl" : "'+modelName+'/'+className+'/delete.action",//删除', 3);
                code = appendLine(code, '"updateUrl" : "'+modelName+'/'+className+'/update.action",//修改', 3);
                code = appendLine(code, '"formDataUrl" : "'+modelName+'/'+className+'/get.action"	//查询', 3);
                code = appendLine(code, '};', 2);
                code = appendLine(code, 'joForm.initFormPage(jParams);//初始化', 2);
                code = appendLine(code, '});', 1);
                code = appendLine(code, '//初始化表单值前处理', 1);
                code = appendLine(code, 'joForm.initFormValueBefore = function(oJson){', 1);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.type == "Date"){//时间类型在表单初始化值的时候要格式化处理
                        code = appendLine(code, 'oJson.'+ v.name +' = jo.formatDate(oJson.'+ v.name +');', 2);
                    }
                }
                code = appendLine(code, '};', 1);
                code = appendLine(code, '<\/script>', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">', 0);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    var clk = '';
                    if(v.type == "Date"){
                        clk = 'onclick="laydate()"';
                    }
                    var mustCls = item.notNull == "1" ? " must" : "";
                    var mustChk = item.notNull == "1" ? " ErrEmpty" : "";
                    var wid = '';
                    if(i<2){
                        wid = ' width="15%"';
                    }
                    var name = v.name;
                    var remark = v.remark;
                    remark = remark.split(",")[0];
                    if(remark.length == 2){
                        remark = remark.substring(0,1) + "　　" + remark.substring(1);
                    }else if(remark.length == 3){
                        remark = remark.substring(0,1) + " " + remark.substring(1,2) + " " + remark.substring(2);
                    }
                    var readonly = '';
                    if(pkVar == name){
                        readonly = ' readonly-edit';
                    }
                    if(i%2 == 0){//第一列
                        if(i == (data.length-1)){//最后一个参数,合并行
                            code = appendLine(code, '<tr>', 1);
                            code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                            code = appendLine(code, '<td class="tnt" colspan="3">', 2);
                            code = appendLine(code, '<input type="text" '+clk+' name="'+ name +'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                            code = appendLine(code, '</td>', 2);
                            code = appendLine(code, '</tr>', 1);
                        }else{
                            code = appendLine(code, '<tr>', 1);
                            code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                            code = appendLine(code, '<td class="tnt">', 2);
                            code = appendLine(code, '<input type="text" '+clk+' name="'+name+'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                            code = appendLine(code, '</td>', 2);
                        }
                    }else{//第二列
                        code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                        code = appendLine(code, '<td class="tnt">', 2);
                        code = appendLine(code, '<input type="text" '+clk+' name="'+name+'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                        code = appendLine(code, '</td>', 2);
                        code = appendLine(code, '</tr>', 1);
                    }

                }
                code = appendLine(code, '</table>', 0);

                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","表单页面");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建视图
        function createView2(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = '<script type="text/javascript">';
                code = appendLine(code, '$(function(){', 1);
                code = appendLine(code, 'joView.init({grid:$("#mainList"),PKName:"'+pkVar+'"});//初始化页面', 2);
                code = appendLine(code, '});', 1);
                code = appendLine(code, '//行处理', 1);
                code = appendLine(code, 'joView.handleItem = function(oItem,iIndex){', 1);
                code = appendLine(code, '', 2);
                code = appendLine(code, '};', 1);
                code = appendLine(code, '<\/script>', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '<table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="'+modelName+'/'+className+'/getPage.action" deleteUrl="'+modelName+'/'+className+'/delete.action" formUrl="page/'+modelName+'/'+className+'Form.jsp">', 0);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    var evt = '';
                    if(i == 0){
                        evt = ' event="click"';
                    }
                    if(v.type == "Date"){
                        code = appendLine(code, '<col field="[=jo.formatTime(\'{'+v.name+'}\')]" title="'+v.remark.split(",")[0]+'" width="15%" align=""'+evt+'/>', 1);
                    }else{
                        code = appendLine(code, '<col field="'+ v.name +'" title="'+v.remark.split(",")[0]+'" width="15%" align=""'+evt+'/>', 1);
                    }

                }
                code = appendLine(code, '</table>', 0);

                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","视图页面");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        function createServiceImpl3(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = 'package '+packageName+'.'+modelName+'.service.impl;';
                code = appendLine(code, '', 0);
                //code = appendLine(code, 'import '+packageName+'.'+modelName+'.service.I'+ClassName+'Service;', 0);
                code = appendLine(code, 'import com.yy.young.common.util.CommonUtil;', 0);
                code = appendLine(code, 'import com.yy.young.dal.service.IDataAccessService;', 0);
                code = appendLine(code, 'import com.yy.young.dal.util.Page;', 0);
                code = appendLine(code, 'import '+packageName+'.'+modelName+'.util.'+wordOne2Up(modelName)+'Constants;', 0);
                code = appendLine(code, 'import com.yy.young.common.service.impl.AbstractCommonService;', 0);
                code = appendLine(code, 'import org.springframework.stereotype.Service;', 0);
                code = appendLine(code, 'import org.slf4j.Logger;', 0);
                code = appendLine(code, 'import org.slf4j.LoggerFactory;', 0);
                code = appendLine(code, 'import javax.annotation.Resource;', 0);
                code = appendLine(code, 'import java.util.List;', 0);
                code = appendLine(code, 'import java.util.Map;', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '/**', 0);
                code = appendLine(code, ' * '+remark+'服务实现', 0);
                code = appendLine(code, ' * Created by '+author+' on '+jo.formatDate(new Date())+'.', 0);
                code = appendLine(code, ' */', 0);
                code = appendLine(code, '@Service("'+className+'Service")', 0);
                code = appendLine(code, 'public class '+ClassName+'ServiceImpl extends AbstractCommonService<Map<String, Object>> {', 0);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '@Resource(name = "dataAccessService")', 1);
                code = appendLine(code, 'IDataAccessService dataAccessService;//数据层服务', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, 'private static final Logger logger = LoggerFactory.getLogger('+ClassName+'ServiceImpl.class);', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//获取数据列表(分页)', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public List<Map<String, Object>> getPage(Map<String, Object> map, Page page) throws Exception {', 1);//分页
                code = appendLine(code, 'return dataAccessService.getList('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".getList", map, page);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//查询单条', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public Map<String, Object> get(Map<String, Object> map) throws Exception {', 1);//one
                code = appendLine(code, 'return (Map<String, Object>)dataAccessService.getObject('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".get", map);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//修改', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int update(Map<String, Object> map) throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.update('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".update", map);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//删除单条', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int delete(String '+pkVar+') throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.delete('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".delete", '+pkVar+');', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 0);//空行
                code = appendLine(code, '//插入', 1);
                code = appendLine(code, '@Override', 1);
                code = appendLine(code, 'public int insert(Map<String, Object> map) throws Exception {', 1);
                code = appendLine(code, 'return dataAccessService.insert('+wordOne2Up(modelName)+'Constants.MAPPER.'+tableName.toUpperCase()+' + ".insert", map);', 2);
                code = appendLine(code, '}', 1);
                code = appendLine(code, '', 1);
                code = appendLine(code, '}', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","Service服务实现类");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //创建mapper文件
        function createMapper3(){
            var data = grid.data;
            if(data){
                initParam();
                var code = '<?xml version="1.0" encoding="UTF-8" ?>'
                        +'\n'+'<!DOCTYPE mapper'
                        +'\n'+'PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"'
                        +'\n'+'"http://mybatis.org/dtd/mybatis-3-mapper.dtd">'
                        +'\n'+'<mapper namespace="'+namespace+'">';
                code = appendLine(code, "<!--查询字段信息-->", 1);
                code = appendLine(code, '<sql id="searchCol">', 1);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(i != 0){
                        code = appendLine(code, ',O.'+item.field+' AS "'+ v.name+'"', 2);
                    }else{
                        code = appendLine(code, 'O.'+item.field+' AS "'+ v.name+'"', 2);
                    }

                }
                code = appendLine(code, "</sql>", 1);
                code = appendLine(code, "<!--关联查询相关sql-->", 1);
                code = appendLine(code, '<sql id="joinSql">', 1);
                code = appendLine(code, '</sql>', 1);
                code = appendLine(code, '<!-- 查询 -->', 1);
                code = appendLine(code, '<select id="getList" parameterType="map" resultType="map">', 1);
                code = appendLine(code, 'SELECT', 2);
                code = appendLine(code, '<include refid="searchCol"></include>', 3);
                code = appendLine(code, 'FROM '+tableName+' O', 2);
                code = appendLine(code, '<include refid="joinSql"></include>', 3);
                code = appendLine(code, '<where>', 2);
                code = appendLine(code, '<if test="'+pkVar+' != null and '+pkVar+' != \'\'">', 3);
                code = appendLine(code, 'AND O.'+pkName+' = #\{'+pkVar+'\}', 4);
                code = appendLine(code, '</if>', 3);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.name == "name"){
                        code = appendLine(code, '<if test="name != null and name != \'\'">', 3);
                        code = appendLine(code, 'AND O.NAME like \'%$\{name}%\'', 4);
                        code = appendLine(code, '</if>', 3);
                    }else if(v.name == "parentId"){
                        code = appendLine(code, '<if test="parentId != null and parentId != \'\'">', 3);
                        code = appendLine(code, 'AND O.PARENT_ID = #\{parentId}', 4);
                        code = appendLine(code, '</if>', 3);
                    }
                }
                code = appendLine(code, '</where>', 2);
                code = appendLine(code, '</select>', 1);
                code = appendLine(code, '<!--根据编号查询-->', 1);
                code = appendLine(code, '<select id="get" resultType="map">', 1);
                code = appendLine(code, 'SELECT', 2);
                code = appendLine(code, '<include refid="searchCol"></include>', 3);
                code = appendLine(code, 'FROM '+tableName+' O', 2);
                code = appendLine(code, '<include refid="joinSql"></include>', 3);
                code = appendLine(code, 'WHERE O.'+pkName+'=#\{'+pkVar+'\}', 2);
                code = appendLine(code, '</select>', 1);
                code = appendLine(code, '<!-- 插入 -->', 1);
                code = appendLine(code, '<insert id="insert" parameterType="map">', 1);
                code = appendLine(code, 'INSERT INTO '+tableName+'(', 2);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    if(i != 0){
                        code = appendLine(code, ','+item.field, 3);
                    }else{
                        code = appendLine(code, item.field, 3);
                    }
                }
                code = appendLine(code, ') VALUES(', 2);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(i != 0){
                        code = appendLine(code, ',#\{'+ v.name+'}', 3);
                    }else{
                        code = appendLine(code, '#\{'+ v.name+'}', 3);
                    }
                }
                code = appendLine(code, ')', 2);
                code = appendLine(code, '</insert>', 1);
                code = appendLine(code, '<!-- 修改 -->', 1);
                code = appendLine(code, '<update id="update" parameterType="map">', 1);
                code = appendLine(code, 'UPDATE '+tableName, 2);
                code = appendLine(code, '<set>', 2);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    if(item.field != pkName){//主键不进行修改
                        var v = new Variable(item.field, item.type, item.remark);
                        code = appendLine(code, '<if test="'+ v.name +' != null">', 3);
                        code = appendLine(code, item.field+' = #\{'+ v.name+'},', 4);
                        code = appendLine(code, '</if>', 3);
                    }
                }
                code = appendLine(code, '</set>', 2);
                code = appendLine(code, 'WHERE '+pkName+'=#\{'+pkVar+'}', 3);
                code = appendLine(code, '</update>', 1);
                code = appendLine(code, '<!-- 删除 -->', 1);
                code = appendLine(code, '<delete id="delete">', 1);
                code = appendLine(code, 'DELETE FROM '+tableName+' WHERE '+pkName+' = #\{'+pkVar+'}', 2);
                code = appendLine(code, '</delete>', 1);
                code = appendLine(code, '</mapper>', 0);
                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","Mapper");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //创建表单
        function createForm3(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = '<script type="text/javascript">';
                code = appendLine(code, '$(function(){', 1);
                code = appendLine(code, 'var jParams = {', 2);
                code = appendLine(code, '"PKName" : "'+pkVar+'",//主键属性名', 3);
                code = appendLine(code, '"saveAfter" : "toEdit",', 3);
                code = appendLine(code, '"addUrl" : "common/scc/insert.action?_service='+className+'Service",//新增', 3);
                code = appendLine(code, '"deleteUrl" : "common/scc/delete.action?_service='+className+'Service",//删除', 3);
                code = appendLine(code, '"updateUrl" : "common/scc/update.action?_service='+className+'Service",//修改', 3);
                code = appendLine(code, '"formDataUrl" : "common/scc/get.action?_service='+className+'Service"	//查询', 3);
                code = appendLine(code, '};', 2);
                code = appendLine(code, 'joForm.initFormPage(jParams);//初始化', 2);
                code = appendLine(code, '});', 1);
                code = appendLine(code, '//初始化表单值前处理', 1);
                code = appendLine(code, 'joForm.initFormValueBefore = function(oJson){', 1);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    if(v.type == "Date"){//时间类型在表单初始化值的时候要格式化处理
                        code = appendLine(code, 'oJson.'+ v.name +' = jo.formatDate(oJson.'+ v.name +');', 2);
                    }
                }
                code = appendLine(code, '};', 1);
                code = appendLine(code, '<\/script>', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">', 0);
                for(var i=0;i<data.length;i++){
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    var clk = '';
                    if(v.type == "Date"){
                        clk = 'onclick="laydate()"';
                    }
                    var mustCls = item.notNull == "1" ? " must" : "";
                    var mustChk = item.notNull == "1" ? " ErrEmpty" : "";
                    var wid = '';
                    if(i<2){
                        wid = ' width="15%"';
                    }
                    var name = v.name;
                    var remark = v.remark;
                    remark = remark.split(",")[0];
                    if(remark.length == 2){
                        remark = remark.substring(0,1) + "　　" + remark.substring(1);
                    }else if(remark.length == 3){
                        remark = remark.substring(0,1) + " " + remark.substring(1,2) + " " + remark.substring(2);
                    }
                    var readonly = '';
                    if(pkVar == name){
                        readonly = ' readonly-edit';
                    }
                    if(i%2 == 0){//第一列
                        if(i == (data.length-1)){//最后一个参数,合并行
                            code = appendLine(code, '<tr>', 1);
                            code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                            code = appendLine(code, '<td class="tnt" colspan="3">', 2);
                            code = appendLine(code, '<input type="text" '+clk+' name="'+ name +'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                            code = appendLine(code, '</td>', 2);
                            code = appendLine(code, '</tr>', 1);
                        }else{
                            code = appendLine(code, '<tr>', 1);
                            code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                            code = appendLine(code, '<td class="tnt">', 2);
                            code = appendLine(code, '<input type="text" '+clk+' name="'+name+'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                            code = appendLine(code, '</td>', 2);
                        }
                    }else{//第二列
                        code = appendLine(code, '<td'+wid+' class="active'+mustCls+'" align="">'+remark+'</td>', 2);
                        code = appendLine(code, '<td class="tnt">', 2);
                        code = appendLine(code, '<input type="text" '+clk+' name="'+name+'" class="form-control input-sm'+readonly+'"'+mustChk+' />', 3);
                        code = appendLine(code, '</td>', 2);
                        code = appendLine(code, '</tr>', 1);
                    }

                }
                code = appendLine(code, '</table>', 0);

                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","表单页面");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }

        //创建视图
        function createView3(){
            var data = grid.data;
            if(data) {
                initParam();
                var code = '<script type="text/javascript">';
                code = appendLine(code, '$(function(){', 1);
                code = appendLine(code, 'joView.init({grid:$("#mainList"),PKName:"'+pkVar+'"});//初始化页面', 2);
                code = appendLine(code, '});', 1);
                code = appendLine(code, '//行处理', 1);
                code = appendLine(code, 'joView.handleItem = function(oItem,iIndex){', 1);
                code = appendLine(code, '', 2);
                code = appendLine(code, '};', 1);
                code = appendLine(code, '<\/script>', 0);
                code = appendLine(code, '', 0);
                code = appendLine(code, '<table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="common/scc/getPage.action?_service='+className+'Service" deleteUrl="common/scc/delete.action?_service='+className+'Service" formUrl="page/'+modelName+'/'+className+'Form.jsp">', 0);
                for(var i=0;i<data.length;i++) {
                    var item = data[i];
                    var v = new Variable(item.field, item.type, item.remark);
                    var evt = '';
                    if(i == 0){
                        evt = ' event="click"';
                    }
                    if(v.type == "Date"){
                        code = appendLine(code, '<col field="[=jo.formatTime(\'{'+v.name+'}\')]" title="'+v.remark.split(",")[0]+'" width="15%" align=""'+evt+'/>', 1);
                    }else{
                        code = appendLine(code, '<col field="'+ v.name +'" title="'+v.remark.split(",")[0]+'" width="15%" align=""'+evt+'/>', 1);
                    }

                }
                code = appendLine(code, '</table>', 0);

                var idx = jo.showWin('<%=URL_CMS%>page/cms/codeEdit/javaCodeShow.jsp',"900px","500px","视图页面");
                jo.iframeLoaded(jo.getLayerIframe(idx), function(){
                    jo.getLayerIframe(idx).setContent(code);
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
        //一键生成
        function fastCreate(){
            var data = grid.data;
            if(data) {
                initParam();
                var rootDir = $("#rootDir").val();
                if(!rootDir){
                    jo.alert("请填写正确的存放目录!");
                    return;
                }
                jo.postAjax("<%=URL_CMS%>cms/generate", {"packageName":packageName,"moduleName":modelName,"className":ClassName,"tableName":tableName,"pid":pkName,"remark":remark,"author":author,"rootPath":rootDir}, function(json){
                    if(json && json.code == 0){
                        jo.showMsg("成功生成代码!");
                    }else if(json && json.code == -1){
                        jo.showMsg(json.info);
                    }
                });
            }else{
                jo.alert("请先查看数据库表字段信息!");
            }
        }
    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label">数据表&nbsp;</label>
                    <select id="table" name="table" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/db/getTableList.action" keyfield="id" valuefield="id" firstitem='{"id":"","id":""}'></select>
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="selectTable()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询字段信息</button>
                <button type="button" class="btn btn-danger btn-sm" onclick="fastCreate()"> <i class="fa fa-file-code-o" aria-hidden="true"></i>&nbsp;一键生成</button>
            </form>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar" style="padding: 0px;margin-bottom:10px;padding-left:2px;border-left: #DD4F43 solid 5px;">
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createModelClass()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建模型类
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createMapper()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建Mapper
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createService()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建Service
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createServiceImpl()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建ServiceImpl
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createController()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建Controller
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createForm()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建表单
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createView()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建视图
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar" style="padding: 0px;margin-bottom:10px;padding-left:2px;border-left: #58AFF7 solid 5px;">
                CommonService版本:
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createModelAboutExcel()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建模型类(Excel注解版)
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createMapper()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建Mapper
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createServiceImpl2()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建CommonService实现
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createController2()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建CommonController实现
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createForm2()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建表单
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createView2()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建视图
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar" style="padding: 0px;margin-bottom:10px;padding-left:2px;border-left: #FFCE43 solid 5px;">
                Map作为实体类版本:
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createMapper3()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建Mapper
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createServiceImpl3()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建AbstractCommonService实现
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createForm3()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建表单
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="createView3()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;创建视图
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 form-inline">
            <div style="display: inline-block; padding-bottom: 2px;">包　　名：<input id="packageName" type="text" class="form-control input-sm" value="com.yy.young"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;">模　　块：<input id="moduleName" type="text" class="form-control input-sm" value="xx"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;">实体类名：<input id="ClassName" type="text" class="form-control input-sm"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;">中文描述：<input id="remark" type="text" class="form-control input-sm"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;">主　　键：<input id="pkName" type="text" class="form-control input-sm" value="ID"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;">作　　者：<input id="author" type="text" class="form-control input-sm" value="rookie"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;">存放目录：<input id="rootDir" type="text" class="form-control input-sm" value="C:\youngCodeGenerate"/>&nbsp;</div>
            <div style="display: inline-block; padding-bottom: 2px;"><label><input id="log" name="log" type="checkbox" class="" value="1" checked style="vertical-align: text-bottom;"/><span style="vertical-align: middle;">&nbsp;日志服务</span></label></div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <%--grid--%>
            <div class="table-responsive">
                <br/>
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList">
                    <col field="[=getNum()]" title="序号" width="50px" align=""/>
                    <col field="field" title="字段名" width="15%" align=""/>
                    <col field="remark" title="字段注释" width="15%" align=""/>
                    <col field="type" title="字段类型" width="10%" align=""/>
                    <col field="length" title="字段长度" width="10%" align=""/>
                    <col field="notNull" title="必填" width="50px" align=""/>

                </table>
            </div>
            <%--/grid--%>
        </div>
    </div>
</div>
<br/>
<br/>
<script type="text/javascript">
    jo.formatUI();
</script>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
