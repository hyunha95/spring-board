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
values('admin', '1234', '노현하', 'M', to_date('85-04-23', 'rr-mm-dd'), 'admin@naver.com', '01099998888', '서울시 구로구',default, default);
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
insert into authority values('admin', 'ROLE_USER');
insert into authority values('admin', 'ROLE_ADMIN');
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
    id = 'admin';

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
