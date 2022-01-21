# spring-board
스프링으로 만든 게시판입니다.

spring-security사용하여 로그인, 로그아웃 구현
https://github.com/hyunha95/spring-board/blob/f041f14a9b71a5b45995b5d81d24e9a536f98904/src/main/webapp/WEB-INF/spring/security-context.xml#L30

회원가입 시 BCryptPasswordEncoder 사용하여 암호화
https://github.com/hyunha95/spring-board/blob/47879ed45e18c160987b88f7fe363ba8f4fd3d4a/src/main/java/com/spring/board/member/controller/MemberController.java#L39

게시판 CRUD 기능

게시글 상세보기 -> 게시글 조회수에 1일짜리 영속쿠키 사용
https://github.com/hyunha95/spring-board/blob/47879ed45e18c160987b88f7fe363ba8f4fd3d4a/src/main/java/com/spring/board/board/controller/BoardController.java#L39

MultipartFile 인터페이스 사용하여 첨부파일을 서버컴퓨터에 저장
https://github.com/hyunha95/spring-board/blob/86b0f8c838b7097fd327f0f7c77ba5adefd2b9ce/src/main/java/com/spring/board/board/controller/BoardController.java#L91

