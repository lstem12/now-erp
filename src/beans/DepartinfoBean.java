package beans;

import java.util.ArrayList;
import java.util.List;

import vo.DepartinfoVO;

public class DepartinfoBean {
	private DepartinfoVO di;
	public List<DepartinfoVO> getList(){
		List<DepartinfoVO> diList = new ArrayList<>();
		DepartinfoVO di = new DepartinfoVO();
		di.setDiCnt(30);
		di.setDiCode("03");
		di.setDiEtc("야근");
		di.setDiName("개발팀");
		di.setDiNum(1);
		diList.add(di);
		return diList;
	}
	public int setDepartInfo(DepartinfoVO di) {
		this.di = di;
		return 1;
	}
	public DepartinfoVO getDepartinfoVO() {
		return this.di;
	}
}
