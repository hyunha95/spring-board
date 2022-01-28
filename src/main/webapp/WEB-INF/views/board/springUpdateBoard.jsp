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
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button { overflow: hidden; }
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<div id="board-container" class="mx-auto text-center mt-2">
	<form 
		method="POST"
		action="${pageContext.request.contextPath}/board/springUpdateBoard.do"
		enctype="multipart/form-data">
		<input type="hidden" name="no" value="${board.no}" />
		<input type="text" class="form-control" 
			   placeholder="제목" name="title" id="title" 
			   value="${board.title}" required>
		<input type="text" class="form-control" 
			   name="memberId" 
			   value="${board.memberId}" readonly required>
		
		<!-- 기존 첨부파일 -->
		<div class="btn-group" role="group" aria-level="Basic checkbox toggle button group">
			<c:forEach items="${board.attachments}" var="attach" varStatus="vs">
				<input type="checkbox" class="btn-check" name="delFile" value="${attach.no}" id="btnCheck${vs.count}" autocomplete="off"/>
				<label class="btn btn-outline-primary" for="btnCheck${vs.count}">${attach.originalFilename}</label>
			</c:forEach>
		</div>
		
		<!-- 첨부파일 추가 -->
		<div class="input-group mt-3">
		  <input type="file" name="upFile" class="form-control" id="inputGroupFile02">
		  <label class="input-group-text" for="inputGroupFile02">Upload</label>
		</div>
		
		<%-- xss공격대비 --%>
	    <textarea class="form-control mt-3" name="content" 
	    		  placeholder="내용" required><c:out value="${board.content}" escapeXml="true"/></textarea>
	    <input type="number" class="form-control" name="readCount"
			   value="${board.readCount}" readonly>
		<input type="datetime-local" class="form-control" name="regDate" 
			   value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd'T'hh:mm"/>'>
		<input type="submit" class="btn btn-primary" value="수정" />
	</form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>