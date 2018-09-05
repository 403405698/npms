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
    <title>文件管理</title>
    <script type="text/javascript">
        //查询条件
        var folder = "";//文件夹
        var ftype = "";//文件类型
        //获取查询条件
        function getConditionStr(){
            var str = "";
            if(jo.isValid(folder)){
                str = "folderId=" + folder;
            }
            if(jo.isValid(ftype)){
                if(jo.isValid(str)){
                    str += "&type=" + ftype;
                }else{
                    str = "type=" + ftype;
                }
            }
            return str;
        }
        $(function () {
            createEditableFolderTree("folderTree", function(event,treeId,treeNode){
                if(treeNode.id){
                    folder = treeNode.id;
                    joView.putParam("condition", getConditionStr());
                    joView.select();
                }else{
                    folder = "";
                    joView.putParam("condition", getConditionStr());
                }
            });
            //初始化文件类型
            initFileType();
            joView.init({grid:$("#mainList"),checkStyle : "none"});//初始化页面
        });
        //文件类型数组
        var fileTypeArr = null;
        //处理行
        joView.handleItem = function(oItem,iIndex){
            oItem.oper = '<a onclick="downloadFile(\''+oItem.id+'\')" style="cursor:pointer;"><i class="fa fa-download font-size-14" aria-hidden="true"></i></a>' +
                    '&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="dropFile(\''+oItem.id+'\')" style="cursor:pointer;"><i class="fa fa-trash font-size-14" aria-hidden="true"></i></a>';
            if(oItem.type == "FOLDER"){
                oItem.icon = '<i class="fa fa-folder-o" aria-hidden="true"></i>';
            }else if(oItem.type == "IMG"){
                oItem.icon = '<i class="fa fa-file-image-o" aria-hidden="true"></i>';
            }else if(oItem.type == "VIDEO"){
                oItem.icon = '<i class="fa fa-file-movie-o" aria-hidden="true"></i>';
            }else if(oItem.type == "VOICE"){
                oItem.icon = '<i class="fa fa-file-audio-o" aria-hidden="true"></i>';
            }else if(oItem.type == "TXT"){
                oItem.icon = '<i class="fa fa-file-text-o" aria-hidden="true"></i>';
            }else if(oItem.type == "DOC"){
                oItem.icon = '<i class="fa fa-file-word-o" aria-hidden="true"></i>';
            }else if(oItem.type == "EXCEL"){
                oItem.icon = '<i class="fa fa-file-excel-o" aria-hidden="true"></i>';
            }else if(oItem.type == "PPT"){
                oItem.icon = '<i class="fa fa-file-powerpoint-o" aria-hidden="true"></i>';
            }else if(oItem.type == "ZIP"){
                oItem.icon = '<i class="fa fa-file-zip-o" aria-hidden="true"></i>';
            }else{
                oItem.icon = '<i class="fa fa-file-o" aria-hidden="true"></i>';
            }
        };
        //显示xx类型的文件
        function displayType(obj, type){
            ftype = type;
            $(".file-type-active").removeClass("file-type-active");
            $(obj).addClass("file-type-active");
            joView.putParam("condition", getConditionStr());
            joView.select();
        }
        //初始化文件类型
        function initFileType(){
            jo.postAjax("{URL_FS}fs/fileInfo/getFileTypeList.action",{},function(json){
                if(json && json.code == 0){
                    fileTypeArr = json.code;
                    var _html = '<a class="file-type file-type-active" onclick="displayType(this,\'\')">所有</a>';
                    for(var i=0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<a class="file-type" onclick="displayType(this,\''+item.key+'\')">'+item.value+'</a>';
                    }
                    $(".file-type-bar").html(_html);
                }
            })
        }
        //上传
        function update(){
            jo.uploadFile("{URL_FS}fs/file/upload.action?folderId="+folder, function(success, file, json){
                if(success && json){
                    jo.showMsg("上传成功!", {icon:1});
                    joView.reloadCurrentPage();
                    jo.closeUploadDialog();//关闭上传窗口
                }
            });
        }
    </script>
    <style>
        .file-type{padding-right:7px;text-decoration: none;color: gray;line-height: 20px;cursor: pointer;}
        .file-type-active{text-decoration: underline;color: #62A8EA;}
        .file-tag{display: inline-block;width: auto;
            height: 25px; line-height: 25px; padding: 0px 12px;margin-right: 2px;margin-top: 4px;background-color: #F3F3F4;
            border: #E7EAEC solid 1px; cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="single-row">
        <div class="col-xs-3 col-lg-2">
            <br/>
            <h6 class="font-bold">
                显示
            </h6>
            <div class="file-type-bar">
                <%-- <a class="file-type file-type-active" onclick="displayType(this,'')">所有</a>
                            <a class="file-type" onclick="displayType(this,'IMG')">图片</a>
                            <a class="file-type" onclick="displayType(this,'VIDEO')">视频</a>
                            <a class="file-type" onclick="displayType(this,'VOICE')">音频</a>
                            <a class="file-type" onclick="displayType(this,'TXT')">文本</a>
                            <br/>
                            <a class="file-type" onclick="displayType(this,'DOC')">文档</a>
                            <a class="file-type" onclick="displayType(this,'EXCEL')">EXCEL表格</a>
                            <a class="file-type" onclick="displayType(this,'PPT')">PPT</a>
                            <a class="file-type" onclick="displayType(this,'OTHER')">其他</a>--%>
            </div>
            <hr/>
            <button class="btn btn-primary btn-block" onclick="update()">上传文件</button>
            <hr/>
            <h6 class="font-bold">
                文件夹
            </h6>
            <div id="folderTree" class="ztree">

            </div>
            <hr/>
            <h6 class="font-bold">
                标签
            </h6>
            <div>
                <a class="file-tag">附件</a>
                <a class="file-tag">原创</a>
                <a class="file-tag">学习</a>
                <a class="file-tag">转载</a>
                <a class="file-tag">标签A</a>
            </div>
        </div>
        <div class="col-xs-9 col-lg-10">
            <br/>
            <div class="table-responsive">
                <table class="table table-hover " id="mainList" dataUrl="fs/fileInfo/getFileInfoPage.action?isFile=1"
                       deleteUrl="fs/fileInfo/deleteFileInfo.action" formUrl="page/fs/fileInfoForm.jsp">
                    <col field="icon" title="" width="26px" align=""/>
                    <col field="name" title="名称" width="50%" align="left"/>
                    <col field="[=jo.formatTime('{updateTime}')]" title="变更时间" width="20%" align=""/>
                    <col field="type" title="类型" width="15%" align=""/>
                    <col field="size" title="大小(KB)" width="15%" align=""/>
                    <col field="oper" title="操作" width="15%" align=""/>
                </table>
            </div>
            <%--分页条--%>
            <div class="page-bar" gridId="mainList">

            </div>
            <%--/分页条--%>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
