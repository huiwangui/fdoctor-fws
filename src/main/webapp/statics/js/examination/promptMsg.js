/**
 * 新增体检、修改体检中的输入项弹窗说明
 */

layui.use('layer', function(){
		var layer = layui.layer;
		//各种提示;
		$("#help1").on('click',function(){
			layer.tips('脉率正常值参考范围60 ~ 100次。', '#help1', {
				tips: [2, '#2b98ff'],
				time: 3000
			});
			return false;
		});
		
		$("#help2").on('click',function(){
			layer.tips('呼吸频率正常值参考范围16 ~ 20次。', '#help2', {
				tips: [2, '#2b98ff'],
				time: 3000
			});
			return false;
		});
		
		$("#help3").on('click',function(){
			layer.tips('血压正常值参考范围140/90mmHg ~ 90/60mmHg,收缩压或舒张压一边不在正常值范围内既为血压异常。', '#help3', {
				tips: [2, '#2b98ff'],
				time: 3000
			});
			return false;
		});
		$("#help4").on('click',function(){
		layer.tips('体质指数=体重（kg）/身高的平方（m2；体质指数正常值参考范围18.5 ~ 23.99kg/m2。', '#help4', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		
		$("#help5").on('click',function(){
		layer.tips('告诉被检查者“我将要说三件物品的名称（如铅笔、卡车、书），请您立刻重复”。过1分钟后请其再次重复。如被检查者无法立即重复或1分钟后无法完整回忆三件物品名称为粗筛阳性，需进一步行“简易智力状态检查量表”检查。', '#help5', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help6").on('click',function(){
		layer.tips('询问被检查者“你经常感到伤心或抑郁吗”或“你的情绪怎么样”。如回答“是”或“我想不是十分好”，为粗筛阳性，需进一步行“老年抑郁量表”检查。', '#help6', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help7").on('click',function(){
		layer.tips('指主动锻炼，即有意识地为强体健身而进行的活动。不包括因工作或其他需要而必须进行的活动，如为上班骑自行车、做强体力工作等。锻炼方式填写最常采用的具体锻炼方式。', '#help7', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help8").on('click',function(){
		layer.tips('“从不吸烟者”不必填写“日吸烟量”、“开始吸烟年龄”、“戒烟年龄”等。', '#help8', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help9").on('click',function(){
		layer.tips('“从不饮酒者”不必填写其他有关饮酒情况项目。“日饮酒量”应折合相当于白酒“××两”。白酒1两折合葡萄酒4两、黄酒半斤、啤酒1瓶、果酒4两。', '#help9', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		
		$("#help10").on('click',function(){
		layer.tips('指因患者职业原因造成的化学品、毒物或射线接触情况。如有，需填写具体化学品、毒物、射线名或填不详。', '#help10', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help11").on('click',function(){
		layer.tips('填写采用对数视力表测量后的具体数值，对佩戴眼镜者，可戴其平时所用眼镜测量矫正视力。', '#help11', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help12").on('click',function(){
		layer.tips('在被检查者耳旁轻声耳语“你叫什么姓名”（注意检查时检查者的脸应在被检查者视线之外），判断被检查者听力状况。', '#help12', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help13").on('click',function(){
		layer.tips('请被检查者完成以下动作：“两手触枕后部”、“捡起这支笔”、“从椅子上站起，行走几步，转身，坐下。”判断被检查者运动功能', '#help13', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help14").on('click',function(){
		layer.tips('糖尿病患者必须进行此项检查。', '#help14', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help15").on('click',function(){
		layer.tips('主要询问乳房是否随月经有周期性疼痛，检查外观有无异常，有无异常泌乳及包块。', '#help15', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help16").on('click',function(){
		layer.tips('记录发育情况及婚产式（未婚、已婚未产或经产式），如有异常情况请具体描述。', '#help16', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help17").on('click',function(){
		layer.tips('记录是否通畅，黏膜情况、分泌物量、色、性状以及有无异味等。', '#help17', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help18").on('click',function(){
		layer.tips('记录大小、质地、有无糜烂、撕裂、息肉、腺囊肿；有无接触性出血、举痛等。', '#help18', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help19").on('click',function(){
		layer.tips('记录位置、大小、质地、活动度；有无压痛等。', '#help19', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			  return false;
		});
		$("#help20").on('click',function(){
		layer.tips('记录有无块物、增厚或压痛；若扪及块物，记录其位置、大小、质地；表面光滑与否、活动度、有无压痛以及与子宫及盆壁关系。左右两侧分别记录。', '#help20', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help21").on('click',function(){
		layer.tips('血红蛋白正常值参考范围110 ~ 160g/l。', '#help21', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help22").on('click',function(){
		layer.tips('白细胞正常值参考范围4.0 ~ 10 X 109/L。', '#help22', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help23").on('click',function(){
		layer.tips('血小板正常值参考范围100 ~ 300 X 109/L。', '#help23', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help24").on('click',function(){
		layer.tips('尿常规中的“尿蛋白、尿糖、尿酮体、尿潜血”可以填写定性检查结果，阴性填“－”，阳性根据检查结果填写“＋”、“＋＋”、“＋＋＋”或“＋＋＋＋”，也可以填写定量检查结果，定量结果需写明计量单位。', '#help24', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help25").on('click',function(){
		layer.tips('老年人健康体检、高血压患者、2型糖尿病患者和重性精神疾病患者年度健康检查时应免费检查的项目；空腹血糖正常值参考范围3.89 ~ 6.11mmol/L。', '#help25', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help26").on('click',function(){
		layer.tips('糖化血红蛋白为糖尿病患者应检查的项目，建议有条件的地区为糖尿病患者提供该项检查。', '#help26', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help27").on('click',function(){
		layer.tips('血清谷丙转氨酶正常值参考范围0 ~ 40U/L。', '#help27', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help28").on('click',function(){
		layer.tips('血清谷草转氨酶正常值参考范围0 ~ 40U/L。', '#help28', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help29").on('click',function(){
		layer.tips('总胆红素正常值参考范围5.1 ~ 28μmol/L。', '#help29', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help30").on('click',function(){
		layer.tips('血钾浓度、血钠浓度为高血压患者年度健康检查时应检查的项目，建议有条件的地区为高血压患者提供该项检查。', '#help30', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help31").on('click',function(){
		layer.tips('血清肌酐正常值参考范围70 ~ 106μmol/L。', '#help31', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help32").on('click',function(){
		layer.tips('血尿素氮正常值参考范围2.86 ~ 8.2 mmol/L。', '#help32', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help33").on('click',function(){
		layer.tips('总胆固醇正常值参考范围0 ~ 5.2 mmol/L。', '#help33', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		$("#help34").on('click',function(){
		layer.tips('甘油三酯正常值参考范围0 ~ 2.3 mmol/L。', '#help34', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
		
		$("#help35").on('click',function(){
		layer.tips('表中列出的检查项目以外的辅助检查结果填写在“其他”一栏。', '#help35', {
		  tips: [2, '#2b98ff'],
			  time: 3000
			  });
			return false;
		});
	});     