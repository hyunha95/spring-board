<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
tr[data-no] {cursor: pointer;}
</style>
<section id="board-container" class="container mt-3">

	<input 
		type="button" value="글쓰기" 
		id="btn-add" class="btn btn-outline-primary btn-sm"
		onclick="location.href='${pageContext.request.contextPath}/board/springBoardEnroll.do'"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>첨부파일</th> <!-- 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px-->
				<th>조회수</th>
			</tr>		
		</thead>
		<tbody>
			<c:forEach items="${list}" var="board">
				<tr>
					<td>${board.no}</td>
					<td>${board.title}</td>
					<td>${board.memberId}</td>
					<td>${board.regDate}</td>
					<td></td>
					<td>${board.readCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		
</section> 
${pagebar}

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>