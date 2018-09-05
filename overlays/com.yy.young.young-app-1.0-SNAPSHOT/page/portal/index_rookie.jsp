<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%--常量--%>
	<%@ include file="/common/constHead.jsp"%>
	<link href="<%=URL_STATIC%>static/css/reset.css" rel="stylesheet">
	<%--jQuery--%>
	<%@ include file="/common/jqueryHead.jsp"%>
	<%--jo--%>
	<%@ include file="/common/joHead.jsp"%>
	<%--bootstrap和字体--%>
	<%@ include file="/common/bootstrapHead.jsp"%>
	<%--layer--%>
	<%@ include file="/common/layerHead.jsp"%>
	<%--公共--%>
	<%@ include file="/common/commonHead.jsp"%>
	<script type="text/javascript">
		//首页导航图标自定义开关,从缓存获取
		var INDEX_NAV_ICON_DIY = '';
		INDEX_NAV_ICON_DIY = (typeof(INDEX_NAV_ICON_DIY) == "string") ? INDEX_NAV_ICON_DIY : "";
	</script>
	<link rel="stylesheet" type="text/css" href="<%=URL_STATIC%>static/plugin/index_rookie/index_rookie.css">
	<script src="<%=URL_STATIC%>static/plugin/index_rookie/index_rookie.js" type="text/javascript"></script>
	<title>YOUNG</title>
	<style>

	</style>
	<script type="text/javascript">
		//注销登录
		function logout(){
			jo.confirm("您确定要注销登录吗?", {title:"退出"}, function(){
				window.location.href = URL_UMS + "logout.action";
			});
		}
		$(function(){

		});
		/**
		 * 点击头像跳转个人信息页
		 */
		function personInfo(id){
			/* if(id){
				$("iframe[name='main']").attr("src","page/jsp/person.jsp?ID="+id);
			} */
			navClick("page/jsp/myInfo.jsp?ID="+id);
		}
	</script>
</head>
<body>
	<table class="index-loyout" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td style="width:100%;height:22px;">
				<div id="aaa" class="today-time" style="float:left;padding-left:20px;text-align:left;line-height:22px;">
					2016年08月12日 星期五
				</div>
				<script type="text/javascript">
					var oDay = {"0":"星期天","1":"星期一","2":"星期二","3":"星期三","4":"星期四","5":"星期五","6":"星期六"};
					//当前时间
					var time = jo.formatDate(new Date()).replace("-","年").replace("-","月")+"日 "+oDay[new Date().getDay()];
					$("div.today-time").html();
				</script>
				<div style="width:auto;height:100%;text-align:right;line-height:22px;float:right;padding-right:20px;">
					<a href="nginx/index.html" target="blank"><i class="icon-question-sign"> </i>帮助手册</a>
					<%--&nbsp;|&nbsp;
					<a href="page/plugins/hplus/index.html" target="blank"><i class="icon-h-sign"> </i>H+风格</a>
					&nbsp;|&nbsp;
					<a href="page/jsp/index_hplus.jsp" target="blank"><i class="icon-h-sign"> </i>首页3.0</a>
					&nbsp;|&nbsp;
					<a href="page/jsp/index-ding.html"><i class="icon-home" style="font-size:12px;"> </i>DingStyle首页</a>--%>
					&nbsp;|&nbsp;
					<a href="page/portal/index_hplus.jsp"><i class="icon-home" style="font-size:12px;"> </i>H+版首页</a>
					&nbsp;|&nbsp;
					<a href="page/portal/index.jsp"><i class="icon-home" style="font-size:12px;"> </i>简洁版首页</a>
					&nbsp;|&nbsp;
					<a href="javascript:logout()"><i class="icon-off"> </i>退出</a><!-- JY_Confirm_Url('login/loginout.action','确定要退出登录?') -->
				</div>
				<div style="clear:both;"></div>
			</td>
		</tr>
		<tr>
			<td class="index-top-bar">
				<div class="index-top-bar-div">
					<div class="top-left">
						<div class="web-logo" style="width: 80px; height: 100%;">
							<!-- <img src="page/images/bg_title1.png" alt="" title="rookie平台"/> -->
							<i class="fa fa-twitter"></i><!-- 文字logo -->
							<%--<img src="<%=URL_STATIC%>static/images/logo2.png" style="width: 50px;height: 50px;margin: 0px;padding: 0px;"/>--%>
						</div>
						<div class="web-name">
							Young快速开发平台
						</div>
					</div>
					<!-- <font size="6" color="white"><b>xx运转系统</b></font> -->
					<div class="top-right">
						<ul>
							<li>
								<div class="user-head" onclick="openPage('{URL_UMS}page/ums/personInfo.jsp','个人信息')">
									<img src="<%=URL_FS%>fs/file/image.action?id=${loginUser.header}" alt="" title="点击编辑个人信息"/>
								</div>
								<div class="top-more">
									<i class="fa fa-angle-down"></i>
								</div>
							</li>
							<li>
								<div class="user-info">
									${loginUser.name }<br>${loginUser.roleName }
								</div>
							</li>
						</ul>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="index-body">
			
				<table class="index-loyout-sub" cellpadding="0" cellspacing="0" border="0">
					<tr style="height:100%;">
						<td class="index-left-bar" id="index-left-bar">
							<div class="index-left-bar-div">
								<div class="navigate-bar" id="navigate-bar">
									<div class="navigate-left" id="navigate-right">
										<ul class="nav-left-ul">
											<!-- <li><i class="icon-user"></i><span>系统配置</span></li>
											<li class="nav-left-checked">
												<i class="icon-star"></i><span>系统配置</span>
											</li>
											<li><i class="icon-film"></i><span>系统配置</span></li>
											<li><i class="icon-cog"></i><span>系统配置</span></li>
											<li><i class="icon-trash"></i><span>系统配置</span></li>
											<li><i class="icon-home"></i><span>系统配置</span></li>
											<li><i class="icon-music"></i><span>系统配置</span></li> -->
										</ul>
									</div>
									<div class="navigate-right">
										<div class="nav-title">
											<i class="icon-star"></i> 资源中心
										</div>
										<div class="nav-content">
											<ul class="nav-right-ul">
												<!-- <li class="hasChild">
													<div class="nav-icon">
														<i class="icon-caret-right"></i>
													</div>
													<div class="nav-font">模块管理</div>
													
												</li>
												<li class="nav-sub">
													<ul class="nav-sub-ul">
														<li class="hasChild">
															<div class="nav-icon">
																<i class="icon-expand-alt"></i>
															</div>
															<div class="nav-font">值班模块</div>
														</li>
														<li class="nav-sub">
															<ul class="nav-sub-ul">
																<li>
																	<div class="nav-icon">
																		<i class="icon-bookmark-empty"></i>
																	</div>
																	<div class="nav-font">值班日志</div>
																</li>
																<li>
																	<div class="nav-icon">
																		<i class="icon-bookmark-empty"></i>
																	</div>
																	<div class="nav-font">值班信息报送</div>
																</li>
															</ul>
														</li>
														<li>
															<div class="nav-icon">
																<i class="icon-bookmark-empty"></i>
															</div>
															<div class="nav-font">信息公开</div>
														</li>
														<li>
															<div class="nav-icon">
																<i class="icon-bookmark-empty"></i>
															</div>
															<div class="nav-font">发文模块</div>
														</li>
													</ul>
												</li>
												<li>
													<div class="nav-icon">
														<i class="icon-angle-right"></i>
													</div>
													<div class="nav-font">业务管理</div>
												</li>
												<li>
													<div class="nav-icon">
														<i class="icon-angle-right"></i>
													</div>
													<div class="nav-font">数据表管理</div>
												</li>
												<li>
													<div class="nav-icon">
														<i class="icon-caret-right"></i>
													</div>
													<div class="nav-font">业务视图管理</div>
												</li> -->
												
											</ul>
										</div>
										
										<div class="nav-bottom">
											<!-- <ul>
												<li class="nav-bottom-checked">
													<i class="icon-caret-right"></i> 同一用户
												</li>
												<li>
													<i class="icon-caret-right"></i> 系统权限
												</li>
											</ul> -->
										</div>
										
									</div>
								</div>
							</div>
							
							
							
						</td>
						
						<!-- 拖拽条 -->
						<td>
							<div class="nav-move-bar" id="nav-move-bar">
							</div>
						</td>

						<td class="index-main-bar" style="position: relative;">
							<div class="index-main-bar-div">
								<iframe name="main" frameborder="0" class="main-iframe" src="page/portal/home.jsp"></iframe>
							</div>
							<%--<style>
								.aaa{
									width:100px;height: auto;position: absolute;z-index: 9;
									top: 5px;right: 5px;word-break: break-all;/*border: #cccccc solid 1px;*/
									background-color: white;box-shadow: #cccccc 1px 1px 5px;
								}
								.bbb{
									width: 70px;height: 70px;border-radius: 35px;background-color: #58AFF7;margin: 8px auto;
									line-height: 70px;color: white;text-align: center;cursor: pointer;
								}
							</style>
							<div class="aaa">
								<div class="bbb">个人信息</div>
								<div class="bbb">系统设置</div>
								<div class="bbb">修改密码</div>
							</div>--%>
						</td>
					</tr>
				</table>
				
			</td>
		</tr>
	</table>
</body>
</html>