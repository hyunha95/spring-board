<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script>
$(() => {
	$(enrollModal)
		.modal('show')
		.on("hide.bs.modal", (e) => {
			location.href = '${pageContext.request.contextPath}';
		});
});
</script>

</head>
<body>
	<!-- Modal 시작 -->
	<div class="modal fade" id="enrollModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">회원가입</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <form:form 
	      	id="enrollFrm"
	      	action="${pageContext.request.contextPath}/member/enroll.do"
	      	method="post"
	      	class="m-5">
	      	<div class="row g-3 align-items-center">
		        <!-- 아이디 -->
		          <div class="col-2">
				    <label for="id" class="col-form-label">아아디</label>
				  </div>
				  <div class="col-6">
				    <input type="text" id="id" name="id" class="form-control" value="shua">
				  </div>
				  <div class="col-4">
				    <span id="idHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
				<!-- 이름 -->
				<div class="col-2">
				    <label for="name" class="col-form-label">이름</label>
				  </div>
				  <div class="col-6">
				    <input type="text" id="name" name="name" class="form-control" value="노슈어">
				  </div>
				  <div class="col-4">
				    <span id="nameHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
			    <!-- 비밀번호 -->
				<div class="col-2">
				    <label for="password" class="col-form-label">비밀번호</label>
				  </div>
				  <div class="col-6">
				    <input type="password" id="password" name="password" class="form-control" value="1234">
				  </div>
				  <div class="col-4">
				    <span id="passwordHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
				 <!-- 비밀번호 확인 -->
				 <div class="col-2">
				    <label for="passwordCheck" class="col-form-label">비밀번호 확인</label>
				  </div>
				  <div class="col-6">
				    <input type="password" id="passwordCheck" class="form-control" value="1234">
				  </div>
				  <div class="col-4">
				    <span id="passwordCheckHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
				  <!-- 이메일 -->
				   <div class="col-2">
				    <label for="email" class="col-form-label">이메일</label>
				  </div>
				  <div class="col-6">
				    <input type="email" id="email" name="email" class="form-control" value="shua@naver.com">
				  </div>
				  <div class="col-4">
				    <span id="emailHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
				  <!-- 번호 -->
				  <div class="col-2">
				    <label for="phone" class="col-form-label">전화번호</label>
				  </div>
				  <div class="col-6">
				    <input type="text" id="phone" name="phone" class="form-control" value="01099998888">
				  </div>
				  <div class="col-4">
				    <span id="phoneHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
				  <!-- 주소 -->
				  <div class="col-2">
				    <label for="address" class="col-form-label">주소</label>
				  </div>
				  <div class="col-6">
				    <input type="text" id="address" name="address" class="form-control" value="서울시 개집">
				  </div>
				  <div class="col-4">
				    <span id="addressHelpInline" class="form-text">
				      Must be 8-20 characters long.
				    </span>
				  </div>
				  <!-- 성별 -->
				  <span id="gender">
				  <label for="gender">성별</label>
					  <div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="M" checked>
						  <label class="form-check-label" for="inlineRadio1">남</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="F">
						  <label class="form-check-label" for="inlineRadio2">여</label>
					  </div>
				  </span>
				  <!-- 생일 -->
				  <span>
				  <label for="birthda">생일</label>
			      <input type="date" name="birthday" id="birthday" />
				  </span>
				<!-- submit 버튼 -->
			    <button type="submit" class="btn btn-primary mt-3">회원가입</button>
	      	</div>
	      </form:form>
	    </div>
	  </div>
	</div>
	<!-- Modal 끝 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>