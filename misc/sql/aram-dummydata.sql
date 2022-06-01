-- 더미데이터

COMMIT;
-- 회원 관련 데이터

INSERT INTO tbl_user VALUES ('aaa123', '11111111', '김다마', 'blackgoat', '01012345678', 'abc@naver.com', '13547', '경기 성남시 분당구 고기로 256-10', '가나아파트 101호', 'social login code', 'n', sysdate, 'n');
INSERT INTO tbl_user VALUES ('xzv021', '01012222', '안나바', 'mycake', '01030421111', 'openjar@naver.com', '23134', '인천 옹진군 덕적면 굴업로 126', '미래아파트 201호', 'social login code', 'n', sysdate, 'n');
INSERT INTO tbl_user VALUES ('hyper2345', '33333333', '주기연', '낚시gosu', '01022341123', 'sevendayz@naver.com', '05695', '서울 송파구 가락로12길 4 (파크팰리스)', '일산빌라 111', 'social login code', 'n', sysdate, 'n');
INSERT INTO tbl_user VALUES ('goodman45', '00000000', '강소찬', 'kelly', '01019192020', 'devKang12@naver.com', '07721', '서울 강서구 화곡로32길 2-7 (풍전빌라)', '풍전빌라 121', 'social login code', 'n', sysdate, 'n');
INSERT INTO tbl_user VALUES ('charles7', 'xoxo1212', '황지상', '꿀밤왕', '01044444444', 'charles7@naver.com', '23134', '부산 강서구 낙동북로212번길 5-3', '바다펜션 101호', 'social login code', 'n', sysdate, 'n');
INSERT INTO tbl_user VALUES ('bubble22', 'password0', '문은주', 'overman', '01021210101', 'hello@naver.com', '05237', '서울 강동구 고덕로23길 6-1 (신보아트빌)', '상세주소', 'social login code', 'n', sysdate, 'n');
COMMIT;

-- 상품 관련 데이터 (일단 쓰지마세요)
INSERT INTO tbl_items values(seq_item_id.nextval, '몬스테라(중소)', 18900, '키우기 쉬우며 인테리어적인 효과도 좋은 식물이에요. 포름알데히드 제거 능력이 뛰어나 새집증후군에 좋은 공기정화식물입니다.', sysdate, 20, 'P200', 10);
INSERT INTO tbl_items values(seq_item_id.nextval, '드라코', 36000, '공기정화식물로 인기가 많은 시원한 느낌의 드라코입니다. 산소와 음이온을 많이 내뿜어 공기정화 효과가 뛰어난 식물입니다.', sysdate, 14, 'P200', 20);
INSERT INTO tbl_items values(seq_item_id.nextval, '산세베리아', 14000, '다른 식물보다 음이온을 30배 이상 발생시키고 밤에도 광함성 작용을 해 밤시간 활용도가 높아 침대에 두면 좋습니다.', sysdate, 40, 'P100', 12);
INSERT INTO tbl_items values(seq_item_id.nextval, '틸란드시아 클럼프', 10500, '여러 이오난사들이 모여있는 클럼프.', sysdate, 14, 'P100', 13);
INSERT INTO tbl_items values(seq_item_id.nextval, '틸란드시아 디시디아', 6500, '풍성한 느낌의 인테리어를 하고 싶다면 디시디아', sysdate, 11, 'P100', 14);
INSERT INTO tbl_items values(seq_item_id.nextval, '안시리움', 16000, '큰 이파리와 아름다움이 오래 지속되는 식물. 실내 공기정화에 좋습니다.', sysdate, 9, 'P100', 15);
INSERT INTO tbl_items values(seq_item_id.nextval, '아레카야자', 2700, '실내의 습기조절 공기정화에 너무 좋아요. 감성적인 생김으로 마음의 위로를 받아보세요.', sysdate, 23, 'P100', 16);
INSERT INTO tbl_items values(seq_item_id.nextval, '뱅갈고무나무', 10900, '고무나무중에서도 성장이 빠른편인 뱅갈고무나무에요. 음이온 발생량이 최상등급이고', sysdate, 22, 'P200', 17);
INSERT INTO tbl_items values(seq_item_id.nextval, '스킨답서스', 3000, '싱그러운 스킨의 잎을 보고 있으면 눈이 시원해지는 느낌이에요.', sysdate, 12, 'P100', 18);
INSERT INTO tbl_items values(seq_item_id.nextval, '문샤인', 7000, '은은한 에메랄드 색이 매력적인 반려 식물 문샤인이에요. 이름과 같이 빛나는 달빛을 닮아 오묘한 색으로 집안 인테리어에 좋아요.', sysdate, 13, 'P100', 17);

-- 카테고리 데이터

INSERT INTO tbl_category VALUES('P100', '인테리어식물')
INSERT INTO tbl_category VALUES('P200', '공기정화식물')
INSERT INTO tbl_category VALUES('P300', '공기정화식물')