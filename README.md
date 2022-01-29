# spring-board
스프링으로 만든 게시판입니다.

spring-security사용하여 로그인, 로그아웃 구현
https://github.com/hyunha95/spring-board/blob/f041f14a9b71a5b45995b5d81d24e9a536f98904/src/main/webapp/WEB-INF/spring/security-context.xml#L30   
아아디 저장(Cookie) -> 성공적으로 인증처리 후 아이디 저장 기능 구현을 위해서 authentication-success-handler-ref사용   
back: https://github.com/hyunha95/spring-board/blob/4da0e29bfb7e8e3308e20aaedd1803153a300119/src/main/java/com/spring/board/member/controller/CustomSuccessHandler.java#L17
front: https://github.com/hyunha95/spring-board/blob/4da0e29bfb7e8e3308e20aaedd1803153a300119/src/main/webapp/WEB-INF/views/member/memberLogin.jsp#L10   
   
      
      
회원가입 시 BCryptPasswordEncoder 사용하여 암호화
https://github.com/hyunha95/spring-board/blob/47879ed45e18c160987b88f7fe363ba8f4fd3d4a/src/main/java/com/spring/board/member/controller/MemberController.java#L39

게시판 CRUD 기능

게시글 상세보기 -> 게시글 조회수에 1일짜리 영속쿠키 사용
https://github.com/hyunha95/spring-board/blob/47879ed45e18c160987b88f7fe363ba8f4fd3d4a/src/main/java/com/spring/board/board/controller/BoardController.java#L39

xss공격대비 jstl<c:out>태그 사용

MultipartFile 인터페이스 사용하여 첨부파일을 서버컴퓨터에 저장
https://github.com/hyunha95/spring-board/blob/86b0f8c838b7097fd327f0f7c77ba5adefd2b9ce/src/main/java/com/spring/board/board/controller/BoardController.java#L91

첨부파일 다운로드 구현 -> ResourceLoader 인터페이스의 getResource 메소드에 file: 접두어와 함께 첨부파일이 저장된 절대경로 전달하여 Resource객체 생성 후 view단으로 리턴 
https://github.com/hyunha95/spring-board/blob/b257e28276f0003030f45ecbab74daf19e8c24dc/src/main/java/com/spring/board/board/controller/BoardController.java#L166   
   
   
게시물 수정, 삭제   
게시물을 작성자와 관리자에게만 수정, 삭제 버튼을 노출   
게시물 수정 -> 게시물 제목, 내용 수정, 기존 첨부파일 삭제, 새로운 첨부파일 추가 기능 구현   
https://github.com/hyunha95/spring-board/blob/699cfeaa8bbf25eaad70869623f10261bb4256d6/src/main/java/com/spring/board/board/controller/BoardController.java#L196   
게시물 삭제 -> 기존 업로드 파일 삭제, board테이블의 행 삭제. board.no를 참조하고 있는 attachment 테이블의 행은 on delete cascade로 자동 삭제   
https://github.com/hyunha95/spring-board/blob/1bb21349a7b02683e6678a77c9131a70b7037b99/src/main/java/com/spring/board/board/controller/BoardController.java#L267





