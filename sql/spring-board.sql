--=========================================
-- 관리자 계정으로 board 계정 생성
--=========================================
alter session set"_oracle_script" = true;

create user board
identified by board
default tablespace users;

alter user board quota unlimited on users;

grant connect, resource to board;

--=========================================
-- board 계정
--=========================================
-- 회원테이블 생성
create table member(
    id varchar2(15),
    password varchar2(300) not null,
    name varchar2(256) not null,
    gender char(1),
    birthday date,
    email varchar2(256) not null,
    phone char(11) not null,
    address varchar2(512),
    enroll_date date default sysdate,
    enabled number default 1, -- 회원활성화여부 1:활성화됨, 0:비활성화(spring-security)
    constraint pk_member_id primary key(id),
    constraint ck_member_gender check(gender in ('M', 'F')),
    constraint ck_member_enabled check(enabled in (1, 0))
);

insert into 
    member 
values('hyunha', '1234', '노현하', 'M', to_date('95-04-23', 'rr-mm-dd'), 'yaa4500@naver.com', '01011112222', '서울시 구로구',default, default);
insert into 
    member 
values('shua', '1234', '노현하', 'M', to_date('85-04-23', 'rr-mm-dd'), 'shua@naver.com', '01099998888', '서울시 구로구',default, default);
select * from member;


--=========================================
-- spring security
--=========================================

-- 권한테이블 생성
-- ROLE_USER 회원 공통권한
-- ROLE_ADMIN 관리자 권한
create table authority (
    member_id varchar2(15),
    authority varchar2(20),
    constraint pk_authority primary key(member_id, authority),
    constraint fk_authority_member_id foreign key(member_id) references member(id) on delete cascade
);
select * from member;
select * from authority;
delete from member where id='shua';
commit;

--authority테이블에 오래키 제약조건 on delete cascade 추가
---------------------------------------
select
	ucc.column_name,
	uc.*
from
	user_constraints uc join user_cons_columns ucc
		on uc.constraint_name = ucc.constraint_name 
where
	uc.table_name = 'AUTHORITY';
alter table authority DROP constraint fk_authority_member_id;
alter table authority add constraint fk_authority_member_id foreign key(member_id) references member(id) on delete cascade;
---------------------------------------

-- 모든 사용자에게 공통권한 ROLE_USER 부여
select * from authority;
insert into authority values('ADMIN', 'ROLE_USER');
insert into authority values('ADMIN', 'ROLE_ADMIN');
insert into authority values('hyunha', 'ROLE_USER');
insert into authority values('shua', 'ROLE_USER');

-- 회원가입 시 member/authority에 각각 insert해야한다. (transaction처리필수)

-- 회원정보 조회(권한포함)
-- 권한 1개면 1행, 권한 2개 2행되는 join query
select
    *
from
    member m join authority a
        on m.id = a.member_id
where
    id = 'shua';

--==========================================
-- board테이블 생성
--==========================================
create table board(
    no number,
    title varchar2(200),
    content varchar2(4000),
    member_id varchar2(15),
    reg_date date default sysdate,
    read_count number default 0,
    constraint pk_board_no primary key(no),
    constraint fk_board_member_id foreign key(member_id) references member(id) on delete set null
);
create sequence seq_board_no;

-- board테이블에 값 추가
insert into board values(seq_board_no.nextval, 'zzz', 'zzz', 'shua', default, default);
select * from board;

-- attachment 테이블
create table attachment (
    no number,
    board_no number not null,
    original_filename varchar2(256) not null,
    renamed_filename varchar2(256) not null,
    upload_date date default sysdate,
    download_count number default 0,
    status char(1) default 'Y',
    constraint pk_attachment_no primary key(no),
    constraint fk_attachment_board_no foreign key(board_no) references board(no) on delete cascade,
    constraint ck_attachment_status check(status in ('Y', 'N'))
);
create sequence seq_attachment_no;

Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 1','shua','반갑습니다',to_date('18/02/10','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 2','shua','안녕하세요',to_date('18/02/12','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 3','shua','반갑습니다',to_date('18/02/13','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 4','shua','안녕하세요',to_date('18/02/14','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 5','shua','반갑습니다',to_date('18/02/15','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 6','shua','안녕하세요',to_date('18/02/16','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 7','shua','반갑습니다',to_date('18/02/17','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 8','shua','안녕하세요',to_date('18/02/18','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 9','shua','반갑습니다',to_date('18/02/19','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 10','shua','안녕하세',to_date('18/02/20','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 11','shua','반갑습니다',to_date('18/03/11','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 12','shua','안녕하세',to_date('18/03/12','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 13','shua','반갑습니다',to_date('18/03/13','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 14','shua','안녕하세',to_date('18/03/14','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 15','shua','반갑습니다',to_date('18/03/15','RR/MM/DD'),0);


Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 16','shua','안녕하세',to_date('18/03/16','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 17','shua','반갑습니다',to_date('18/03/17','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 18','shua','안녕하세',to_date('18/03/18','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 19','shua','반갑습니다',to_date('18/03/19','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 20','shua','안녕하세',to_date('18/03/20','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 21','shua','반갑습니다',to_date('18/04/01','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 22','shua','안녕하세',to_date('18/04/02','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 23','shua','반갑습니다',to_date('18/04/03','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 24','shua','안녕하세',to_date('18/04/04','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 25','shua','반갑습니다',to_date('18/04/05','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 26','shua','안녕하세',to_date('18/04/06','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 27','shua','반갑습니다',to_date('18/04/07','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 28','shua','안녕하세',to_date('18/04/08','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 29','shua','반갑습니다',to_date('18/04/09','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 30','shua','안녕하세',to_date('18/04/10','RR/MM/DD'),0);

Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 31','shua','반갑습니다',to_date('18/04/16','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 32','shua','안녕하세',to_date('18/04/17','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 33','shua','반갑습니다',to_date('18/04/18','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 34','shua','안녕하세',to_date('18/04/19','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 35','shua','반갑습니다',to_date('18/04/20','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 36','shua','안녕하세',to_date('18/05/01','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 37','shua','반갑습니다',to_date('18/05/02','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 38','shua','안녕하세',to_date('18/05/03','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 39','shua','반갑습니다',to_date('18/05/04','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 40','shua','안녕하세',to_date('18/05/05','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 41','shua','반갑습니다',to_date('18/05/06','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 42','shua','안녕하세',to_date('18/05/07','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 43','shua','반갑습니다',to_date('18/05/08','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 44','shua','안녕하세',to_date('18/05/09','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 45','shua','반갑습니다',to_date('18/05/10','RR/MM/DD'),0);

Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 46','shua','안녕하세',to_date('18/05/16','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 47','shua','반갑습니다',to_date('18/05/17','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 48','shua','안녕하세',to_date('18/05/18','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 49','shua','반갑습니다',to_date('18/05/19','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 50','shua','안녕하세',to_date('18/05/20','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 51','shua','반갑습니다',to_date('18/05/01','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 52','shua','안녕하세',to_date('18/06/02','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 53','shua','반갑습니다',to_date('18/06/03','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 54','shua','안녕하세',to_date('18/06/04','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 55','shua','반갑습니다',to_date('18/06/05','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 56','shua','안녕하세',to_date('18/06/06','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 57','shua','반갑습니다',to_date('18/06/07','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 58','shua','안녕하세',to_date('18/06/08','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 59','shua','반갑습니다',to_date('18/06/09','RR/MM/DD'),0);
Insert into BOARD (NO,TITLE,MEMBER_ID,CONTENT,REG_DATE,READ_COUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 60','shua','안녕하세',to_date('18/06/10','RR/MM/DD'),0);


select * from board order by no desc;
select * from attachment;

select
    b.*,
    a.*
from
    board b join attachment a
        on b.no = a.board_no
where
    b.no = 141;








