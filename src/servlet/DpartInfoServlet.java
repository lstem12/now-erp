package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.DepartinfoService;
import service.impl.DepartinfoServiceImpl;


@WebServlet("/depart/*")
public class DpartInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DepartinfoService departinfoService = new DepartinfoServiceImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String targetUrl = "/views/di-list";
		if("/depart/list".equals(request.getRequestURI())) {
			request.setAttribute("diList", departinfoService.selectDepartinfoList(null));
		}
		RequestDispatcher rd = request.getRequestDispatcher(targetUrl);
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
