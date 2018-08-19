package com.boco.common.comparator;

import java.util.Comparator;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.boco.modules.fdoc.vo.PersonInformationVo;

public class UserComparator  implements Comparator{{

}



@Override
public int compare(Object o1, Object o2) {
	PersonInformationVo vo1=(PersonInformationVo)o1;
	PersonInformationVo vo2=(PersonInformationVo)o2;
	if(StringUtils.isNotEmpty(vo1.getMasterFlag())){
		return -1;
	}
	return 0;
}
}