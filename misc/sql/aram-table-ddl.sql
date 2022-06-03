
-- 테이블 생성
-- 회원 테이블
CREATE TABLE tbl_user (
	user_id			varchar2(60)	PRIMARY KEY,
	user_pw			varchar2(256)	NOT NULL,
	username		varchar2(20)	NOT NULL,
	nickname		varchar2(20)	UNIQUE NOT NULL,
	phone			varchar2(11)	NOT NULL,
	email			varchar2(100)	UNIQUE NOT NULL,
	post_no			varchar2(5)		NOT NULL,
	addr			varchar2(100)	NOT NULL,
	addr_detail		varchar2(255)	DEFAULT NULL,
	social_login	varchar2(200)	DEFAULT NULL,
	email_verify	varchar2(3)		DEFAULT 'n',
	join_date		DATE			NOT NULL,
	isAdmin			varchar2(3)		DEFAULT 'n'
);

SELECT * FROM tbl_user;
DROP TABLE tbl_user;

-- 회원 블랙리스트

CREATE TABLE tbl_blacklist (
	user_id			varchar2(50)	NOT NULL,
	black_date		DATE			NOT NULL,
	black_detail	varchar2(500)	NOT NULL
);

SELECT * FROM tbl_blacklist;
DROP TABLE tbl_blacklist;

-- 상품 테이블

CREATE TABLE tbl_items (
	item_no			NUMBER			PRIMARY KEY,
	item_name		varchar2(100)	NOT NULL,
	price			NUMBER 			NOT NULL,
	item_comment	varchar2(200)	NOT NULL,
	item_regdate	DATE			NOT NULL,
	item_stock		NUMBER 			DEFAULT 0,
	category_id		varchar2(10)	NOT NULL,
	img_no			NUMBER			NOT NULL
);

SELECT * FROM tbl_items;
DROP TABLE tbl_items;

-- item_no 시퀀스
CREATE SEQUENCE seq_item_no
	INCREMENT BY 1
	START WITH 100
	MINVALUE 1
	NOMAXVALUE
	NOCYCLE
	NOCACHE;

-- 이미지 테이블

CREATE TABLE tbl_item_img (
	img_no			NUMBER			PRIMARY KEY,
	item_no			NUMBER			NOT NULL,
	img_type		varchar2(50)	,
	ori_name		varchar2(1000)	NOT NULL,
	sys_name		varchar2(1000)	NOT NULL
);

SELECT * FROM tbl_item_img;
DROP TABLE tbl_item_img;

-- img_no 시퀀스
CREATE SEQUENCE seq_img_no
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	NOMAXVALUE
	NOCYCLE
	NOCACHE;

-- 상품 + 이미지 join 쿼리문

select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no;

-- 카테고리 테이블

CREATE TABLE tbl_category (
	category_id		varchar2(10)	NOT NULL,
	category_name	varchar2(100)	NOT NULL
);

SELECT * FROM tbl_category;
DROP TABLE tbl_category;

-- 회원리뷰 테이블

CREATE TABLE tbl_review (
	review_no		NUMBER			PRIMARY KEY,
	title			varchar2(100)	NOT NULL,
	content			varchar2(1000)	NOT NULL,
	write_date		DATE			NOT NULL,
	score			NUMBER			NOT NULL,
	user_id			varchar2(60)	NOT NULL,
	item_no			NUMBER			NOT NULL,
	img_no			NUMBER			NOT NULL
);

SELECT * FROM tbl_review;
DROP TABLE tbl_review;

-- review_no 시퀀스
CREATE SEQUENCE seq_review_no
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	NOMAXVALUE
	NOCYCLE
	NOCACHE;

-- QA 문의글 테이블

CREATE TABLE tbl_qna (
	qna_no			NUMBER			PRIMARY KEY,
	user_id			varchar2(60)	NOT NULL,
	title			varchar2(100)	NOT NULL,
	content			varchar2(1000)	NOT NULL,
	write_date		DATE			NOT NULL,
	answer_yn		varchar2(3)		DEFAULT 'n',
	answer			varchar2(1000)	DEFAULT NULL,
	answer_date		DATE
);

SELECT * FROM tbl_qna;
DROP TABLE tbl_qna;

-- qna_no 시퀀스
CREATE SEQUENCE seq_qna
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	NOMAXVALUE
	NOCYCLE
	NOCACHE;

-- 공지사항 테이블

CREATE TABLE tbl_notice (
	notice_no		NUMBER			PRIMARY KEY,
	user_id			varchar2(60)	NOT NULL,
	title			varchar2(100)	NOT NULL,
	author			varchar2(20)	NOT NULL,
	write_date		DATE			NOT NULL,
	content			varchar2(1000)	NOT NULL,
	board_views		NUMBER			DEFAULT 0
);

SELECT * FROM tbl_notice;
DROP TABLE tbl_notice;

-- notice_no 시퀀스

CREATE SEQUENCE seq_notice
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	NOMAXVALUE
	NOCYCLE
	NOCACHE;

-- 주문 테이블

CREATE TABLE tbl_order (
	order_no		NUMBER			PRIMARY KEY,
	user_id			varchar2(60)	NOT NULL,
	order_name		varchar2(20)	NOT NULL,
	order_date		DATE			NOT NULL,
	quantity		NUMBER			DEFAULT 1,
	order_amount	NUMBER			NOT NULL,
	delivery_addr	varchar2(100)	NOT NULL,
	delivery_name	varchar2(20)	NOT NULL,
	order_msg		varchar2(255)	DEFAULT NULL,
	delivery_msg	VARCHAR(255)	DEFAULT NULL
);

SELECT * FROM tbl_order;
DROP TABLE tbl_order;

-- order_no 시퀀스

CREATE SEQUENCE seq_order
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	NOMAXVALUE
	NOCYCLE
	NOCACHE;

-- 장바구니 테이블

CREATE TABLE tbl_cart (
	user_id			varchar2(60)	NOT NULL,
	item_no			NUMBER			NOT NULL,
	quantity		NUMBER  		DEFAULT 1
);

SELECT * FROM tbl_cart;
DROP TABLE tbl_cart;

-- 제품코드-주문번호 연관 테이블

CREATE TABLE order_product (
	order_no		NUMBER			PRIMARY KEY,
	item_no			varchar2(50)	NOT NULL
);

-- 테이블 조회

SELECT * FROM tbl_user;
DROP TABLE tbl_user;

SELECT * FROM tbl_items;
DROP TABLE tbl_items;

SELECT * FROM tbl_blacklist;
DROP TABLE tbl_blacklist;

SELECT * FROM tbl_category;
DROP TABLE tbl_category;

SELECT * FROM tbl_review;
DROP TABLE tbl_review;

SELECT * FROM tbl_qna;
DROP TABLE tbl_qna;

SELECT * FROM tbl_notice;
DROP TABLE tbl_notice;

SELECT * FROM tbl_order;
DROP TABLE tbl_order;

SELECT * FROM tbl_cart;
DROP TABLE tbl_cart;

select * from (select * from tbl_items order by item_stock) where rownum <=8