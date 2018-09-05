/**
 * jo插件统一监听处理
 * 托管函数:
 * 1.joTabLinkProcess(sLink,sTab) 处理页签的地址
 */
$(function(){
	console.log("jo插件统一监听初始化...");
	/**
	 * 页签事件
	 */
	$(".joTab li").live("click",function(){
		$(".joTab li").removeClass("cur");
		$(this).addClass("cur");
		var sheet = $(this).attr("tab");//对应标签页的id
		$(".joTabSheet").css("display","none");//其他的隐藏
		$("#"+sheet).css("display","block");//选中的显示
		
		var link = $(this).attr("link");
		if(typeof(joTabLinkProcess) == "function"){//地址重写
			link = joTabLinkProcess(link,sheet);
		}
		if(jo.isValid(link)){
			if($(this).attr("loaded")){//已加载过该标签
				console.info("iframe["+sheet+"]已加载...")
			}else{
				link = replaceUrlConstants(link);
				$("iframe[id='"+sheet+"']").attr("src",link);
				$(this).attr("loaded","true");
				console.info("iframe["+sheet+"]执行加载...")
			}
		}
	});
	try{
		$(".joTab .cur").click();
	}catch(err){}
	
	/**
	 * 
	 */
	
});