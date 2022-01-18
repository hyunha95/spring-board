package com.spring.board.common.util;

public class HelloSpringUtils {

	public static String getPagebar(int cPage, int numPerPage, int totalContent, String url) {
		StringBuilder pagebar = new StringBuilder();
		url = url + "?cPage=";
		
		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;
		
		/*
		<nav aria-label="Page navigation example">                                                              
		  <ul class="pagination justify-content-center">
		    <li class="page-item disabled">
		      <a class="page-link">Previous</a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#">Next</a>
		    </li>
		  </ul>
		</nav>
		 */
		pagebar.append("<nav aria-label=\"Page navigation example\">\r\n"
				+ "		  <ul class=\"pagination justify-content-center\">");
		
		// 이전
		if(pageNo == 1) {
			// 이전 영역 비활성화
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\">Previous</a>\r\n"
					+ "		    </li>");
		}
		else {
			// 이전 영역 활성화
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"" + url + (pageNo - 1) + "\">Previous</a>\r\n"
					+ "		    </li>");
		}
		
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				// 현재페이지
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\">" + cPage + "</a></li>");
			}
			else {
				// 현재 페이지가 아닌 경우
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"" + url + pageNo+ "\">" + pageNo + "</a></li>");
			}
			pageNo++;
		}
		
		// 다음
		if(pageNo > totalPage) {
			// 다음 페이지 비활성화
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\">Next</a>\r\n"
					+ "		    </li>");
		}
		else {
			// 다음 페이지 활성화
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"" + url + pageNo + "\">Next</a>\r\n"
					+ "		    </li>");
		}
		
		pagebar.append("		  </ul>\r\n"
				+ "		</nav>");
		
		return pagebar.toString();
	}
}

















