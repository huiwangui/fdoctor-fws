<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../../views/include/taglib.jsp"%>
<!DOCTYPE>
<html style="height: 100%">
<head>
<link rel="stylesheet" href="/FWS/statics/css/wei.css" />
<script src="/FWS/statics/js/jquery-2.1.4.min.js"></script>
<script src="https://g.alicdn.com/aliww/ww/json/json.js" charset="utf-8"></script>
<script src="https://cdn.bootcss.com/vue/2.3.4/vue.min.js"></script>
<!-- <script src="https://g.alicdn.com/aliww/??h5.imsdk/4.0.1/scripts/yw/wsdk.js,h5.openim.kit/0.5.0/scripts/kit.js" charset="utf-8"></script> -->
<script src="/FWS/statics/js/im.js" charset="utf-8"></script>
</head>
<body>
	<input type="hidden" id="img_head_url" value="<%=imgHeadUrl%>">
	<div class="main" id="app">
		<div class="panel">
			<div class="header">
				<div class="avatar">
					<img src="<%=imgHeadUrl%>${sessionScope.doc_session.img}" alt=""/>
				</div>
				<div class="nickname">
					${sessionScope.doctorInfo.docName}
				</div>
			</div>
			<div class="tab">
				<div class="tab_item">
					<a href="/">
						<i class="chat_pic"></i>
					</a>
				</div>
				<div class="tab_item">
					<a href="/">
						<i class="friends_pic"></i>
					</a>
				</div>
			</div>
			<div class="friendTalk" >
				<ul id="conts_ul" class="friendTalk_lists">
					
				</ul>
			</div>
			
			
			<div class="firendName" hidden="">
				<div class="search tc">
					<input type="text" name="" id="" value="" placeholder="搜索" v-model="name"/>
				</div>
				<ul class="fiendName_lists">
					<li class="item" v-for="item in person" v-bind:id="item.uid" @click="chooseFriend(item.uid, item.personName, item.img)">
						<div class="avatar">
							<img v-if="item.img == null"  alt="" src="/FWS/statics/image/chat/de_header.png">
							<img v-else v-bind:src="imgHeadUrl + item.img" alt="" onerror="/FWS/statics/image/chat/de_header.png"/>
						</div>
						<div class="info">
							{{item.personName}} 
						</div>
					</li>
					
				</ul>
			</div>
		</div>
		
	</div>
	
	<div id="chat_window" class="contentView">
			
		</div>
	
		
	<script>
		
		//定义remove方法，去掉uidList中的某个uid
		Array.prototype.indexOf = function(val) {  
			for (var i = 0; i < this.length; i++) {  
			    if (this[i] == val) return i;  
			}  
		return -1;  
		};  
		Array.prototype.remove = function(val) {  
			var index = this.indexOf(val);  
			if (index > -1) {  
			    this.splice(index, 1);  
			}  
		};
		//拓展原生js，数组加入insert函数，在索引为index的地方插入
		Array.prototype.insert = function (index, item) {
			this.splice(index, 0, item);
		};
		
		//设置全局ajax同步，避免初始化最近联系人出现异步问题
		$.ajaxSetup({
			async: false
		});
		
		var contsMsgsMap = {};	//声明map，用于装最近联系人的id、剩余消息条数
		var contsNameMap = {};	//声明map，用于装最近联系人的id、姓名
		var lastMsgMap = {};	//声明map，用于装最近联系人的id、最后一条消息缩略
		var contsImgMap = {};	//声明map，用于装最近联系人的id、头像地址
		var uidList = [];		//声明list，用于装联系人的id顺序
		var currentUid = null;	//声明当前聊天对象UID
		
		var sdk = null;
		var prefix = 'ix2b58b5';
		
		WKIT.init({
			container: document.getElementById('chat_window'),
			uid : '${sessionScope.doc_session.userName}',
			appkey : 23447109,
			credential : '${sessionScope.doc_session.password}',
			touid : '${sessionScope.doc_session.userName}',
			avatar : $('#img_head_url').val() + '${sessionScope.doc_session.img}',
			onLoginSuccess : function(data) {
				sdk = WKIT.Conn.sdk;
				
				//获取最近联系人
				sdk.Base.getRecentContact({
					count : 30,
					success : function(data) {
						var cnts = data.data.cnts
						console.log(cnts);
						if(cnts.length > 0){
							
							for(var i = 0; i < cnts.length; i++){
								uidList.push(cnts[i].uid);
								contsMsgsMap[cnts[i].uid] = 0;
								contsImgMap[cnts[i].uid] = cnts[i].avator;
								
								if(typeof(cnts[i].msg[0]) != "undefined" && typeof(cnts[i].msg[0][1]) != "undefined"){
									lastMsgMap[cnts[i].uid] = subStrMsg(cnts[i].msg[0][1]);
								}
								//发送请求，获取姓名
								$.get("/FWS/im/getContsInfo",{uid : cnts[i].uid.replace(prefix, '')}, function(result){
									if(result.data != null && typeof(result.data) != "undefined"){
										contsNameMap[prefix + result.data.uid] = result.data.personName;
									}
								});
							}
							
							//将窗口展开至第一个联系人的聊天界面，并把消息置为已读
							changeWindow(cnts[0].uid);
							//设置缓存中当前聊天对象
							currentUid = cnts[0].uid;
							
							//获取未读条数
							sdk.Base.getUnreadMsgCount({
							    count: 30,
							    success: function(data){
							    	var unreadData = data.data;
							        console.log('get unread msg count success' ,data.data);
							        for(var i = 0; i < unreadData.length; i++){
							        	contsMsgsMap[unreadData[i].contact] = unreadData[i].msgCount;
									}
							        
							    	//把map中的联系人添加到页面上
							        addToHtml();
							    	
							    	
							    }
							});
						}
					},
					error : function(error) {
						console.log('get recent contact success', error);
					}
				});
				
				sdk.Event.on('MSG_RECEIVED', function(data) {
					var msgs = data.data.msgs;
					console.log(msgs);
					
					for(var i = 0; i < msgs.length; i++){
						//在uidList中删除该uid
						uidList.remove(msgs[i].from);
						//重新将目标ID放入第一的位置
 						uidList.insert(0, msgs[i].from);
						
						//修改map中最后一条消息
						lastMsgMap[msgs[i].from] = subStrMsg(msgs[i].msg);
						
						//判断map中有无该人，没有的话新建一个
						if(contsNameMap[msgs[i].from] == null || typeof(contsNameMap[msgs[i].from]) == "undefined"){
							//发送请求获取姓名
							$.get("/FWS/im/getContsInfo",{uid : msgs[i].from.replace(prefix, '')}, function(result){
								if(result.data != null && typeof(result.data) != "undefined"){
									contsNameMap[prefix + result.data.uid] = result.data.personName;
									contsMsgsMap[prefix + result.data.uid] = 0;
									contsImgMap[prefix + result.data.uid] = $('#img_head_url').val() + result.data.img;
								}
								
								//修改map中的消息数量
								var msgCount = contsMsgsMap[prefix + result.data.uid] + 1;
								delete contsMsgsMap[prefix + result.data.uid];
								
								contsMsgsMap[prefix + result.data.uid] = msgCount;
								addToHtml();
							});
						}else{
							//修改map中的消息数量
							if(currentUid == msgs[i].from){
								//如果消息发送方为当前聊天对象，则不用在未读消息上+1，直接设置为已读
								sdk.Chat.setReadState({
									touid : msgs[i].from,
									hasPrefix : true, // 选填
									timestamp : Math.floor((+new Date()) / 1000),
									success : function(data) {
										console.log('set read state success', data);
									},
									error : function(error) {
										console.log('set read state fail', error);
									}
								});
							}else{
								var msgCount = contsMsgsMap[msgs[i].from] + 1;
								
								delete contsMsgsMap[msgs[i].from];
								
								contsMsgsMap[msgs[i].from] = msgCount;
							}
							addToHtml();
						}
					}
				}, {text: 'wsdk'});

			}
		});
		
		
		//变换聊天窗口，并把该对象所有消息置为已读
		function changeWindow(touid){
			//把当前聊天对象uid缓存改变
			currentUid = touid;
			
			//增加选中class
			$('#conts_ul li').removeClass('active');
			$('#' + touid).addClass('active');
			
			var toAvatar = contsImgMap[touid];
			
			if(toAvatar == null || toAvatar == ''){
				toAvatar = $('#img_head_url').val() + "/upload/img/de_header.png";
			}
			
			WKIT.switchTouid({
				touid : touid,
				toAvatar : toAvatar,
				hasPrefix : true, // 选填
				sendMsgToCustomService : false,
				avatar : $('#img_head_url').val() + '${sessionScope.doc_session.img}'
			});

			//设置消息为已读
			sdk.Chat.setReadState({
				touid : touid,
				hasPrefix : true, // 选填
				timestamp : Math.floor((+new Date()) / 1000),
				success : function(data) {
					console.log('set read state success', data);
				},
				error : function(error) {
					console.log('set read state fail', error);
				}
			});
			
			contsMsgsMap[touid] = 0;
			
			$('#' + touid).find("a").remove();
		}
		
		
		//把map中的联系人添加到页面上
		function addToHtml(){
			
	    	var liHtml = '';
	    	for(var i = 0; i < uidList.length; i++){
	    		var uid = uidList[i];
				//liHtml += '<li onclick=changeWindow("' + uid + '") id="' + uid + '">' + contsNameMap[uid] + ':' + contsMsgsMap[uid] + '</li>';
				if(contsNameMap[uid] != null && contsNameMap[uid] != "undefined"){
					liHtml += '<li onclick=changeWindow("' + uid + '") id="' + uid + '" class="item';
					//当窗口为当前聊天对象时，加上active样式
					if(uid == currentUid){
						liHtml += ' active">';
					}else{
						liHtml += '">';
					}
					//当头像为空时，使用默认头像
					if(contsImgMap[uid] != null && contsImgMap[uid] != ""){
						liHtml += '<div class="avatar"><img src="' + contsImgMap[uid] + '" alt="" onerror="/FWS/statics/image/chat/de_header.png"></div><div class="info"><h4>' + contsNameMap[uid];
					}else{
						liHtml += '<div class="avatar"><img src="/FWS/statics/image/chat/de_header.png" alt=""></div><div class="info"><h4>' + contsNameMap[uid];
					}
					
					if(contsMsgsMap[uid] > 0){
						liHtml += '<a href="javascript:void(0)">' + contsMsgsMap[uid] + '</a></h4><p class="ecli">' + lastMsgMap[uid] + '</p></div>';
					}else{
						liHtml += '</h4><p class="ecli">' + lastMsgMap[uid] + '</p></div>';
					}
					liHtml += '<div class=""></div></li>';
				}
			}
			$('#conts_ul').html(liHtml);
		}
		
		var friendsList = $.parseJSON('${userList}');
		//初始化vue
		new Vue({
			el:'#app',
			data:{
				name : '',
				imgHeadUrl: $('#img_head_url').val(),
				friends:friendsList
			},
			methods:{
				chooseFriend:function(uid, personName, img){
					
					//判断map中是否有这个人
					if(contsNameMap[prefix + uid] == null || typeof(contsNameMap[prefix + uid]) == "undefined"){
						//重新将目标ID放入第一的位置
						uidList.insert(0, prefix + uid);
						lastMsgMap[prefix + uid] = '';
						if(img == null || img == ''){
							img = '/FWS/statics/image/chat/de_header.png';
						}else{
							img = $('#img_head_url').val() + img;
						}
						contsImgMap[prefix + uid] = img;
					}
					contsNameMap[prefix + uid] = personName;
					contsMsgsMap[prefix + uid] = 0;
					//切换当前聊天窗口为这个人
					currentUid = prefix + uid;
					addToHtml();
					
					changeWindow(currentUid);
					
					$('.firendName').hide()
					$('.friendTalk').show();
					$('.friends_pic').css('background','url(/FWS/statics/image/chat/friend.png) left center no-repeat')
					$('.chat_pic').css('background','url(/FWS/statics/image/chat/chat1.png) left center no-repeat')
				}
			},
			computed:{
				 person: function () {
                    var that = this;
                    return that.friends.filter(function (per) {
                        return per.personName.toLowerCase().indexOf(that.name.toLowerCase()) !== -1;
                    })
                }
			}
		})
		
		$('.tab .tab_item a').on('click',function(){
			var index=$(this).parent().index();
			if(index==0){
				$('.firendName').hide()
				$('.friendTalk').show();
				$('.friends_pic').css('background','url(/FWS/statics/image/chat/friend.png) left center no-repeat')
				$('.chat_pic').css('background','url(/FWS/statics/image/chat/chat1.png) left center no-repeat')
			}else{

				$('.friendTalk').hide();
				$('.firendName').show()
				
				$('.friends_pic').css('background','url(/FWS/statics/image/chat/friend1.png) left center no-repeat')
				$('.chat_pic').css('background','url(/FWS/statics/image/chat/chat.png) left center no-repeat')
				
			}
			return false;
		})
		
		
		//截取缩略消息，取10位   如果数量大于10，则添加.省略号
		function subStrMsg(msg){
			var returnMsg = msg.substring(0, 10);
			if(msg.length > 10){
				returnMsg += '...';
			}
			return returnMsg;
		}

	</script>
</body>
</html>