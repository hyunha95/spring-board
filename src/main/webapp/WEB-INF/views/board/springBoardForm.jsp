<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
div#board-container{width:800px; margin:0 auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>

<div id="board-container" class="mt-5">
	<form 
		name="springBoardFrm" 
		action="${pageContext.request.contextPath}/board/springBoardEnroll.do" 
		method="POST"
		enctype="multipart/form-data">
		<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
		<input type="text" class="form-control" name="id" value="" readonly required>
		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="mb-3">
		  <input class="form-control" type="file" id="formFile">
		</div>
		<div class="mb-3">
		  <input class="form-control" type="file" id="formFile">
		</div>
		
	    <textarea class="form-control" rows="10" name="content" placeholder="내용" required></textarea>
		<br />
		<input type="submit" class="btn btn-outline-success" value="저장" >
	</form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
