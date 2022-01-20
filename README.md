# spring-board
스프링으로 만든 게시판입니다.

spring-security사용하여 로그인, 로그아웃, 회원가입 구현

BCryptPasswordEncoder 사용하여 암호화
https://github.com/hyunha95/spring-board/blob/47879ed45e18c160987b88f7fe363ba8f4fd3d4a/src/main/java/com/spring/board/member/controller/MemberController.java#L39

게시판 CRUD 기능

게시판 조회

게시글 상세보기 -> 게시글 조회수에 1일짜리 영속쿠키 사용
https://github.com/hyunha95/spring-board/blob/47879ed45e18c160987b88f7fe363ba8f4fd3d4a/src/main/java/com/spring/board/board/controller/BoardController.java#L39


