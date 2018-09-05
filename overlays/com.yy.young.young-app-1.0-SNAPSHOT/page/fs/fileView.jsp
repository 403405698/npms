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
    <link href="<%=URL_STATIC%>static/css/fs/fileView.css" rel="stylesheet">
    <title>浏览文件</title>
    <script type="text/javascript">
        //页面对象,用于记录页面包含元素信息
        var fileView = {
            disks : []
            ,grid : null
            ,diskGroup : []
        };
        $(function () {
            initRoot();
            fileView.grid = new Grid($("#fsList"));
        });
        //初始化根目录
        function initRoot(){
            initDisk();//初始化磁盘信息
            initRootFolder();//初始化根文件信息
        }
        //初始化磁盘
        function initDisk(){
            //查询磁盘目录
            jo.postAjax("{URL_FS}fs/fileInfo/getOneLevelFolder.action", {}, function(json){
                if(json && json.code == "0"){
                    var folders = json.data;
                    //清空原有的磁盘信息
                    fileView.disks = new Array();
                    for(var i=0;i<folders.length;i++){
                        fileView.disks.push(new Disk(folders[i]));
                    }
                    var dg = new DiskGroup("目录", fileView.disks);
                    dg.initHtml();
                    fileView.diskGroup.push(dg);
                    //初始化html
                    /*for(var i=0;i<fileView.disks.length;i++){
                        fileView.disks[i].initHtml();
                    }*/
                }
            });
        }
        //初始化根目录文件夹信息
        function initRootFolder(){
            //查询磁盘目录
            jo.postAjax("{URL_FS}fs/fileInfo/getRootFolderInfo.action", {}, function(json){
                if(json && json.code == "0"){
                    var folder = json.data[0];
                    folder.name = '根目录文件';
                    var dg = new DiskGroup("其他", [new Disk(folder)]);
                    dg.initHtml();
                    fileView.diskGroup.push(dg);
                }
            }, true);
        }
        /**
        * 文件磁盘类,默认根目录下的文件夹为"磁盘"
        * @param idOrObj 磁盘编号或者后台传过来的FileInfo对象
        * @param name 磁盘名称
        * @constructor
         */
        function Disk(idOrObj, name){
            if(typeof (idOrObj) == "string"){
                this.id = idOrObj;//编号
                this.name = name;//名称
                this.fileNum = 0;//文件数
                this.useSpace = 0;//文件夹大小-已使用空间,KB
            }else{
                this.id = idOrObj.id;
                this.name = idOrObj.name;//名称
                this.fileNum = jo.getDefVal(idOrObj.childFileNum, 0);//文件数
                this.useSpace = jo.getDefVal(idOrObj.size, 0);//文件夹大小-已使用空间,KB
                this.fileInfo = idOrObj;//关联文件系统后台FileInfo实体
            }
            this.totalSpace = 500 * 1024;//总空间,KB,默认500MB

            //获取html
            this.getHtml = function(){
                var bg = this.id == "ROOT" ? 'folder-li-pic-bg3' : 'folder-li-pic-bg2';
                var _html = '<div class="folder-li-pic '+bg+'"></div>';
                _html += '<div class="folder-li-info">';
                _html += '<div>'+this.name+'('+this.fileNum+')</div>';
                var wid = jo.getDefVal(Math.ceil(this.useSpace / this.totalSpace * 100) + "%", "1%");
                _html += '<div class="folder-progress"><div class="folder-progress-scale" style="width:'+wid+';"></div></div>';
                _html += '<p>占用 '+ (this.useSpace > 1024 ? ((this.useSpace / 1024).toFixed(2) + " MB") : (this.useSpace+" KB") )+',共 '+this.fileNum+' 个文件</p>';
                _html += '</div>';
                return '<li class="folder-li" id="'+this.id+'" onclick="diskClick(\''+this.id+'\',\''+this.name+'\')">' + _html + '</li>';
            };
            //初始化页面磁盘元素
            this.initHtml = function(){
                var bg = this.id == "ROOT" ? 'folder-li-pic-bg3' : 'folder-li-pic-bg2';
                var _html = '<div class="folder-li-pic '+bg+'"></div>';
                _html += '<div class="folder-li-info">';
                _html += '<div>'+this.name+'('+this.fileNum+')</div>';
                var wid = jo.getDefVal(Math.ceil(this.useSpace / this.totalSpace * 100) + "%", "1%");
                _html += '<div class="folder-progress"><div class="folder-progress-scale" style="width:'+wid+';"></div></div>';
                _html += '<p>占用 '+ (this.useSpace > 1024 ? ((this.useSpace / 1024).toFixed(2) + " MB") : (this.useSpace+" KB") )+',共 '+this.fileNum+' 个文件</p>';
                _html += '</div>';
                if(document.getElementById(this.id)){
                    //如果已存在此磁盘,则更新
                    $("#"+this.id).html(_html);
                }else{//不存在则直接插入
                    var whole = '<li class="folder-li" id="'+this.id+'" onclick="diskClick(\''+this.id+'\',\''+this.name+'\')">' + _html + '</li>';
                    $("#disks").append(whole);
                }
            };
        }
        //磁盘组
        function DiskGroup(name, diskArr){
            this.name = name;
            this.subDisk = diskArr;
            this.getTitle = function(){
                var _title = '<div class="fs-title">' +
                        '<div class="fs-title-text">' +
                        '<i class="fa fa-lg fa-caret-right" aria-hidden="true"></i>&nbsp;<sapn style="color:#2a3e93;">'+this.name+'('+this.subDisk.length+')</sapn> ' +
                        '</div>' +
                        '<div class="fs-title-line"></div>' +
                        '</div>';
                return _title;
            };
            this.initHtml = function(){
                var _html = '<div class="disk-group" id="'+this.name+'">';
                _html += this.getTitle();
                _html += '<ul class="folder-ul" id="disks">';
                if(this.subDisk && this.subDisk.length > 0){
                    for(var i=0; i<this.subDisk.length;i++){
                        var disk = this.subDisk[i];
                        _html += disk.getHtml();
                    }
                }
                _html += '</ul>' +
                        '<div class="clear"></div>' +
                        '</div>';
                $("#contentBox").append(_html);
            };
            this.remove = function(){
                $("#"+this.name).remove();
            };
        }
        //磁盘点击事件
        function diskClick(id, name){
            //清空显示区域
            if(fileView.diskGroup && fileView.diskGroup.length > 0){
                for(var i=0;i<fileView.diskGroup.length;i++){
                    fileView.diskGroup[i].remove();
                }
            }

            //查询磁盘下文件信息
            jo.postAjax("{URL_FS}fs/fileInfo/getFileInfoPage.action", {folderId:id}, function(json){
                if(json && json.code == "0"){
                    fileView.grid.loadData(json.data);
                }
            });
            appendPath(id, name);
        }
        //文件夹点击
        function folderClick(id, name){
            jo.postAjax("{URL_FS}fs/fileInfo/getFileInfoPage.action", {folderId:id}, function(json){
                if(json && json.code == "0"){
                    fileView.grid.loadData(json.data);
                }
            });
            appendPath(id, name);
        }
        //追加地址栏信息
        function appendPath(id, name){
            $(".fs-nav").append('<a class="fs-path" onclick="pathClick(this, \''+id+'\')">'+name+'</a>');
        }
        //地址栏点击
        function pathClick(obj, id){
            var afterEle = $(obj).nextAll();
            if(afterEle && afterEle.length > 0){
                //将被点击对象后面的路径全部移除
                for(var i=0;i<afterEle.length;i++){
                    $(afterEle[i]).remove();
                }
            }
            //加载被点击地址下的文件信息
            jo.postAjax("{URL_FS}fs/fileInfo/getFileInfoPage.action", {folderId:id}, function(json){
                if(json && json.code == "0"){
                    fileView.grid.loadData(json.data);
                }
            });
        }
        //文件列表点击事件
        function fileInfoClick(oItem, oList, index){
            if(oItem.isFile == "0"){//文件夹点击
                folderClick(oItem.id, oItem.name);
            }else{//文件点击

            }
        }
        function getIcon(type){
            var icon = "";
            if(type == "FOLDER"){
                //icon = '<i class="fa fa-folder-o" aria-hidden="true"></i>';
                icon = '<span class="fs-icon fs-icon-folder"></span>';
            }else if(type == "IMG"){
                icon = '<i class="fa fa-file-image-o" aria-hidden="true" style="font-size: 14px;"></i>';
            }else if(type == "VIDEO"){
                icon = '<i class="fa fa-file-movie-o" aria-hidden="true" style="font-size: 14px;"></i>';
            }else if(type == "VOICE"){
                icon = '<i class="fa fa-file-audio-o" aria-hidden="true" style="font-size: 14px;"></i>';
            }else if(type == "TXT"){
                //icon = '<i class="fa fa-file-text-o" aria-hidden="true"></i>';
                icon = '<span class="fs-icon fs-icon-txt"></span>';
            }else if(type == "DOC"){
                icon = '<i class="fa fa-file-word-o" aria-hidden="true" style="font-size: 14px;"></i>';
            }else if(type == "EXCEL"){
                //icon = '<i class="fa fa-file-excel-o" aria-hidden="true"></i>';
                icon = '<span class="fs-icon fs-icon-excel"></span>';
            }else if(type == "PPT"){
                icon = '<i class="fa fa-file-powerpoint-o" aria-hidden="true" style="font-size: 14px;"></i>';
            }else if(type == "ZIP"){
                //icon = '<i class="fa fa-file-zip-o" aria-hidden="true"></i>';
                icon = '<span class="fs-icon fs-icon-zip"></span>';
            }else{
                //icon = '<i class="fa fa-file-o" aria-hidden="true"></i>';
                icon = '<span class="fs-icon fs-icon-other"></span>';
            }
            return icon;
        }
        function getOper(id){
            return '<a onclick="downloadFile(\''+id+'\')" style="cursor:pointer;"><i class="fa fa-download font-size-14" aria-hidden="true"></i></a>';
        }
    </script>
</head>
<body>
<div class="container-fluid" style="padding-top: 10px;">
    <div class="row">
        <div class="col-xs-12">
            <div class="fs-nav">
                <a class="fs-path" onclick="location.reload();">根目录</a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12" id="contentBox">
            <table class="table table-hover " id="fsList" dataUrl=""
                   deleteUrl="" formUrl="" trClick="fileInfoClick">
                <col field="[=getIcon('{type}')]" title="" width="30px" align="left" headAlign="left"/>
                <col field="name" title="名称" width="50%" align="left" headAlign="left"/>
                <col field="[=jo.formatTime('{updateTime}')]" title="修改日期" width="20%" align="left" headAlign="left"/>
                <col field="type" title="类型" width="15%" align="left" headAlign="left"/>
                <col field="size" title="大小(KB)" width="10%" align="right" headAlign="right"/>
                <col field="[=getOper('{id}')]" title="" width="50px" align=""/>
            </table>
            <%--磁盘组单元--%>
            <%--<div class="disk-group" id="">
                <div class="fs-title">
                    <div class="fs-title-text">
                        <i class="fa fa-lg fa-caret-right" aria-hidden="true"></i>&nbsp;<sapn style="color:#2a3e93;">目录(5)</sapn>
                    </div>
                    <div class="fs-title-line"></div>
                </div>
                <ul class="folder-ul" id="disks">
                    <li class="folder-li">
                        <div class="folder-li-pic folder-li-pic-bg1"></div>
                        <div class="folder-li-info">
                            <div>头像(29)</div>
                            <div class="folder-progress"><div class="folder-progress-scale"></div></div>
                            <p>
                                34 MB 空间,共 253 个文件
                            </p>
                        </div>
                    </li>
                </ul>
                <div class="clear"></div>
            </div>--%>
            <%--根目录文件--%>
            <%--<div class="disk-group" id="根目录">
                <div class="fs-title">
                    <div class="fs-title-text">
                        <i class="fa fa-lg fa-caret-right" aria-hidden="true"></i>&nbsp;<sapn style="color:#2a3e93;">其他(1)</sapn>
                    </div>
                    <div class="fs-title-line"></div>
                </div>
                <ul class="folder-ul" id="rootFolder">
                    <li class="folder-li" id="ROOT">
                        <div class="folder-li-pic folder-li-pic-bg3"></div>
                        <div class="folder-li-info">
                            <div>根目录文件(0)</div>
                            <div class="folder-progress"><div class="folder-progress-scale"></div></div>
                            <p>
                                0 MB 空间,共 0 个文件
                            </p>
                        </div>
                    </li>
                </ul>
                <div class="clear"></div>
            </div>--%>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
