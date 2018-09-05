<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link href="<%=URL_STATIC%>static/plugin/webuploader-0.1.5/webuploader.css" rel="stylesheet">
<script src="<%=URL_STATIC%>static/plugin/webuploader-0.1.5/webuploader.js"></script>
<script type="text/javascript">
    /**
    * 上传文件
    * @param sUrl 文件上传地址
    * @param callback 文件上传回调,参数1是boolean类型,代表是否上传成功,参数2是file对象,参数3是后台返回结果
    * @param oParams 详细配置项
     */
    function uploadFile(sUrl, callback, oParams){
        var _uploadHtml = '<div id="uploadWin" style="width:100%;">' +
                //'<div><div class="alert alert-warning font-size-14"><strong>提醒！</strong>请使用平台提供的模板进行导入，否则会导致错误发生!</div></div>' +
                '<div id="choiceFileBtn" style="float: left;display: none;">选择文件</div>' +
                '<button id="uploadBtn" class="btn btn-primary" style="width: 78px;height: 37px; margin-bottom: 5px;margin-left: 12px;display: none;">开始上传</button>' +
                '<table id="uploadList" class="table table-hover table-condensed"></table>' +
                '</div>';
        var options = {
            title : "上传文件",
            area : ['500px','300px'],
            btn : ["选择文件", "开始上传", "关闭"],
            btn1 : function(){
                $('#choiceFileBtn').find("label").click();
                return true;
            },
            btn2 : function(){
                $('#uploadBtn').click();
                return false;//不关闭窗口
            }
        };
        jo.showDialog(_uploadHtml, "uploadWin", true, options);//弹窗
        uploaderInit(sUrl, callback, oParams);//初始化
    }
    //uploaderInit插件初始化
    function uploaderInit(sUrl, callback, oParams){
        if(sUrl){
            sUrl = replaceUrlConstants(sUrl);
        }else{
            var idx = jo.alert("上传地址无效!", '', function(){
                jo.close("uploadWin");//关闭上传窗口
                jo.close(idx);
            });
            return;
        }
        var uploader;//uploader对象
        var $list = $('#uploadList');//上传列表
        var $btn = $('#uploadBtn');//开始上传按钮
        var state = 'pending';//上传状态
        //WebUploader对象参数
        var createParam = {
            // swf文件路径
            swf: '<%=URL_STATIC%>static/plugin/webuploader-0.1.5/Uploader.swf',
            // 文件接收服务端。
            server: sUrl,
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#choiceFileBtn',
            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false
        };
        //当传入更多配置项时,设置对应属性
        if(oParams){
            //文件类型限制
            if(oParams.accept){
                createParam.accept = oParams.accept;
            }else if(typeof (UPLOAD_FILE_TYPES) == 'string'){//兼容旧版本的类型限制接口
                createParam.accept = {
                    extensions : UPLOAD_FILE_TYPES
                };
            }else if(oParams.UPLOAD_FILE_TYPES){//兼容旧版本的类型限制接口
                createParam.accept = {
                    extensions : oParams.UPLOAD_FILE_TYPES
                };
            }
            //缩略图选项
            if(oParams.thumb){
                createParam.thumb = oParams.thumb;
            }
            //文件总数限制
            if(oParams.fileNumLimit){
                createParam.fileNumLimit = oParams.fileNumLimit;
            }
            //文件总大小限制
            if(oParams.fileSizeLimit){
                createParam.fileSizeLimit = oParams.fileSizeLimit;
            }
            //单个文件大小限制
            if(oParams.fileSingleSizeLimit){
                createParam.fileSingleSizeLimit = oParams.fileSingleSizeLimit;
            }
        }
        uploader = WebUploader.create(createParam);
        // 当有文件被添加进队列的时候
        uploader.on( 'fileQueued', function( file ) {
            var _tr = '<tr id="'+file.id+'" style="height:30px;">' +
                    '<td class="fileName" style="border: none;" width="30%">'+file.name+'</td>' +
                    '<td class="fileProgress" style="border: none;" width="50%"></td>' +
                    '<td class="fileState" style="border: none;" width="20%">等待上传...</td>' +
                    '</tr>';
            $list.append(_tr);
        });
        // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            var $li = $( '#'+file.id);//行
            var progressTd = $li.find(".fileProgress");//进度条td
            var $percent = $li.find('.progress .progress-bar');//进度条
            // 避免重复创建
            if ( !$percent.length ) {
                $percent = $('<div class="progress progress-striped active" style="margin: 0px;">' +
                        '<div class="progress-bar" role="progressbar" style="width: 0%;height: 25px;">' +
                        '</div>' +
                        '</div>').appendTo( progressTd ).find('.progress-bar');
            }
            $li.find('td.fileState').text('上传中');
            $percent.css( 'width', percentage * 100 + '%' );
        });
        //上传成功
        uploader.on( 'uploadSuccess', function( file, response) {
            $( '#'+file.id ).find('td.fileState').text('上传成功');
            if(typeof (callback) == "function"){
                callback(true, file, response);//回调
            }
        });
        //上传失败
        uploader.on( 'uploadError', function( file ) {
            $( '#'+file.id ).find('td.fileState').text('上传出错');
            if(typeof (callback) == "function"){
                callback(false, file);//回调
            }
        });
        //上传结束,不论成功失败,调用顺序在成功/失败回调后面
        uploader.on( 'uploadComplete', function( file ) {
            $( '#'+file.id ).find('.progress').fadeOut();//进度条淡出
        });
        //错误事件
        uploader.on( 'error', function( type ) {
            if (type == "Q_TYPE_DENIED") {//文件类型不匹配
                jo.showMsg("请上传正确格式的文件（"+createParam.accept.extensions+"）");
            }else if(type == "Q_EXCEED_NUM_LIMIT"){//文件数量超出限制
                jo.showMsg("文件数量超出限制!");
            }else if(type == "Q_EXCEED_SIZE_LIMIT"){//文件总大小超出限制
                jo.showMsg("文件总大小超出限制!");
            }else{
                console.warn("[文件上传error事件] 未知的错误类型:" + type);
            }
        });
        //绑定上传事件
        $btn.on('click', function(){
            uploader.upload();
        });
    }
</script>