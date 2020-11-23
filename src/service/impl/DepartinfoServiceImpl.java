package service.impl;

import java.util.List;

import dao.DepartinfoDAO;
import dao.impl.DepartinfoDAOImpl;
import service.DepartinfoService;
import vo.DepartinfoVO;

public class DepartinfoServiceImpl implements DepartinfoService {
	DepartinfoDAO departinfoDAO = new DepartinfoDAOImpl();
	@Override
	public List<DepartinfoVO> selectDepartinfoList(DepartinfoVO DepartinfoVO) {
		return departinfoDAO.selectDepartinfoList(DepartinfoVO);
	}
	public static void main(String[] args) {
		DepartinfoService departinfoService = new DepartinfoServiceImpl();
		System.out.println(departinfoService.selectDepartinfoList(null));
	}
}
