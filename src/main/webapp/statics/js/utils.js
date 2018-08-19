/**
 * 获取当前日期，默认为yyyy-mm-dd，参数为true是为yyyy-mm-dd hh24:mi:ss
 */
function getNowFormatDate(complex) {
	var date = new Date();
	var seperator1 = "-";
	var seperator2 = ":";
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	if (month >= 1 && month <= 9) {
		month = "0" + month;
	}
	if (strDate >= 0 && strDate <= 9) {
		strDate = "0" + strDate;
	}
	var currentdate = year + seperator1 + month + seperator1 + strDate;
	if(complex){
		currentdate += " "+ date.getHours() + seperator2 + date.getMinutes() + seperator2
		+ date.getSeconds();
	}
	
	return currentdate;
}

/**
 * 控制输入框只能输入数字
 */
$.fn.number = function() {
	$(this).css("ime-mode", "disabled");
	this.bind("keypress", function(e) {
		var code = (e.keyCode ? e.keyCode : e.which); // 兼容火狐 IE
		if (!$.support.msie && (e.keyCode == 0x8)) { // 火狐下不能使用退格键
			return;
		}
		if (this.value.indexOf(".") == -1) {
			return (code >= 48 && code <= 57) || (code == 46);
		} else {
			return code >= 48 && code <= 57
		}
	});
	this.bind("paste", function() {
		return false;
	});
	this.bind("keyup", function() {
		if (this.value.slice(0, 1) == ".") {
			this.value = "";
		}
	});
	this.bind("blur", function() {
		if (this.value.slice(-1) == ".") {
			this.value = this.value.slice(0, this.value.length - 1);
		}
	});
};