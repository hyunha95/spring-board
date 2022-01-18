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
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Landing Page - Start Bootstrap Theme</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
   
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-light bg-light static-top pb-2 pt-2">
            <div class="container">
                <a class="navbar-brand" href="#!">Start Bootstrap</a>
                <!-- 로그인 하지 않았을 때 -->
                <sec:authorize access="isAnonymous()">
	                <span>
		                <a class="btn btn-primary" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
		                <a class="btn btn-primary" href="${pageContext.request.contextPath}/member/enroll.do">회원가입</a>
	                </span>	                
                </sec:authorize>
                <!-- 로그인 했을 때 -->
                <sec:authorize access="isAuthenticated()">
                	<span>
                		<a href="#">
                			<sec:authentication property="principal.username"/>
                		</a>님
	               		<%-- 로그아웃도 csrf 폼 검사를 하기 때문에 무조건 post로 보내야 한다. --%>
	               		<form:form
	               			action="${pageContext.request.contextPath}/member/memberLogout.do"
	               			method="post">
	                		<button type="submit" class="btn btn-primary">로그아웃</button>
	               		</form:form>  
               		</span>              	
                </sec:authorize>
            </div>
        </nav>
        <hr class="m-0">
        <!-- Icons Grid-->
        <section class="bg-light text-center pt-3">
            <div class="container">
                <div class="row">
                	<!-- 스프링 공부 게시판 -->
                    <div 
                    	class="col-lg-4" 
                    	style="cursor:pointer;"
                    	onclick="location.href='${pageContext.request.contextPath}/board/springBoardList.do'">
                        <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                            <div class="features-icons-icon d-flex"><i class="bi-window m-auto text-primary"></i></div>
                            <h3>Spring</h3>
                            <p class="lead mb-0">Study Spring with us</p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                            <div class="features-icons-icon d-flex"><i class="bi-layers m-auto text-primary"></i></div>
                            <h3>Bootstrap 5 Ready</h3>
                            <p class="lead mb-0">Featuring the latest build of the new Bootstrap 5 framework!</p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="features-icons-item mx-auto mb-0 mb-lg-3">
                            <div class="features-icons-icon d-flex"><i class="bi-terminal m-auto text-primary"></i></div>
                            <h3>Easy to Use</h3>
                            <p class="lead mb-0">Ready to use with your own content, or customize the source files!</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>