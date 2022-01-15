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














