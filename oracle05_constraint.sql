/*===============================
테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

자료형(datatype)
varchar2 - 가변길이 문자를 저장
char - 고정길이 문자를 저장
number(m)-정수저장
number(m,n)- 실수저장
date - 날짜 저장
===============================*/
CREATE TABLE student(
  name varchar2(20), --바이트(영문,특수문자- 1byte / 한글-3byte)
  age number(3),   --자릿수
  avg number(5, 2), --5는 전체자릿수, 2은 소수점 자릿수
  hire date  
);

-- 정상삽입
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동',   30,     97.85,     sysdate);

SELECT * FROM student;

--ORA-12899: value too large for column "HR"."STUDENT"."NAME" (actual: 26, maximum: 20)
----'박차고 나온 세상에' : 크기 초과(20바이트까지만 가능)
INSERT INTO  student(name, age, avg, hire)
VALUES('박차고 나온 세상에', 30,    97.85,  sysdate);

--ORA-01438: value larger than specified precision allowed for this column
--4000: 크기초과(3자리까자만 가능- 0 ~ 999)
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동',   4000,     97.85,     sysdate);

--ORA-01438: value larger than specified precision allowed for this column
--2921.8589 : 크기초과(5자리까지만 가능)-소수점은 포함하지 않는다. 
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동',   30,     2921.8589,     sysdate);

-- 소수자릿수는 초과하면 짤려서 저장된다.
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동',   30,     921.8589,     sysdate);

SELECT * FROM  student;

-- ORA-01438: value larger than specified precision allowed for this column
-- 소수점2자리로 무조건 계산을 한다. 즉 정수자리는 3자리까만 허용한다.
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동',   30,     2921.8,     sysdate);

SELECT * FROM  student;


/*====================================
ALTER 
 객체(테이블)의 구조를 변경해주는 명령어이다.
======================================*/
--생성 : CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE INDEX
--수정 : ALTER TABLE, ALTER VIEW, ALTER INDEX, ALTER USER

--테이블에 컬럼을 추가한다.
ALTER TABLE student
ADD loc varchar2(50);

-- describe                                                    descending
-- DESC table_name : 테이블 구조 확인,   DESC column_name : 내림차순
DESC student;

SELECT * FROM student;

-- ORA-01441: cannot decrease column length because some value is too big
-- 데이터가 저장되여 있는 상태에서는  저장된 데이터크기보다 작으면 안된다.
ALTER TABLE student
MODIFY name varchar2(5);

-- 크기를 늘리는 것은 상관없다.
ALTER TABLE student
MODIFY name varchar2(30);

--테이블에 컬럼명을 수정한다.
ALTER TABLE student
RENAME COLUMN avg TO jumsu;

DESC student;

--테이블명을 변경한다.
ALTER TABLE student 
RENAME TO members;

--ORA-04043: student 객체가 존재하지 않습니다.
DESC student;

--확인됨
DESC members;

/*================================================
TRUNCATE : 테이블에 저장된 데이터를 모두 제거한다.(auto COMMIT이 됨)
DROP : 테이블 자체를 제거한다.
DELETE : 테이블에 저장된 데이터를 모두 삭제한다.(auto COMMIT이 안됨)
==================================================*/
commit;

SELECT * FROM members;

DELETE    FROM members;

SELECT * FROM members;

ROLLBACK;

SELECT * FROM members;

COMMIT;

TRUNCATE TABLE members;

SELECT * FROM members;

ROLLBACK;

SELECT * FROM members;

COMMIT;

DROP TABLE members;

-- ORA-00942: table or view does not exist
SELECT * FROM members;

/*================================================================
무결성 제약조건
   무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면
   제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
   무결성 제약조건 5종류 : not null, unique, primary key, foreign key, check
    not null : null를 허용하지 않는다.
    unique : 중복된 값을 허용하지 않는다. 항상 유일한값이다.
    primary key : not null + unique
    foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
    check : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 허용한다.

   무결성제약조건 2가지 레벨 : 컬럼레벨, 테이블레벨

    컬럼레벨 설정
    CREATE TABLE emp06(
     id varchar2(10) constraint  emp06_id_pk primary key,
     name varchar2(20) constraint emp06_name_nk not null,
     age number(3) constraint emp06_age_uk check(age between 20 and 50),
     gen char(2) constraint emp06_gen_uk check(gen in('m','w')));
   
    테이블 레벨 설정-not null은 테이블 레벨에서 설정할 수 없다.
     CREATE TABLE emp07(
     id varchar2(10),
     name varchar2(20) constraint emp07_name_nk not null,
     age number(3),
     gen char(2),
     constraint emp07_id_pk primary key(id),
     constraint emp07_age_uk check(age between 20 and 50),
     constraint emp07_gen_uk check(gen in('m','w')));
     
    --ORA-02290: 체크 제약조건(HR.EMP06_AGE_UK)이 위배되었습니다
    INSERT INTO emp06(id, name, age, gen)
    VALUES('100','PARK',15,'m');
    
    --ORA-01400: NULL을 ("HR"."EMP06"."ID") 안에 삽입할 수 없습니다
    INSERT INTO emp06(id, name, age, gen)
    VALUES(null,'PARK',15,'m');
=================================================================*/
SELECT * FROM  user_tables;

CREATE TABLE emp04(
  id varchar2(20) constraint emp04_id_pk primary key,
  name varchar2(50),
  age number,
  gen char(1)
);

INSERT INTO emp04(id, name, age, gen)
VALUES(1,'홍길동', 30, 'm');

SELECT * FROM emp04;

--ORA-00001: unique constraint (HR.EMP04_ID_PK) violated
INSERT INTO emp04(id, name, age, gen)
VALUES(1, '고수', 25, 'm');

--ORA-01400: cannot insert NULL into ("HR"."EMP04"."ID")
INSERT INTO emp04(id, name, age, gen)
VALUES(null, '고수', 25, 'm');

/*=======================================================================
제약조건 추가
  ALTER TABLE table_name
       ADD constraint constraint_name constraint_type(column_name)
=========================================================================*/

ALTER TABLE emp04
 ADD CONSTRAINT emp04_age_ck  check(age between 20 and 50);

--ORA-02290: check constraint (HR.EMP04_AGE_CK) violated
INSERT INTO emp04(id, name, age, gen)
 VALUES(2,'여진구', 55, 'm');
 
INSERT INTO emp04(id, name, age, gen)
 VALUES(2,'여진구', 30, 'm');

SELECT * FROM emp04;

 ALTER TABLE emp04
   ADD CONSTRAINT emp04_gen_ck check( gen in('m','w'));
   
--ORA-02290: check constraint (HR.EMP04_GEN_CK) violated
INSERT INTO emp04(id, name, age, gen)
 VALUES(3,'송중기', 35, 'k');
 
INSERT INTO emp04(id, name, age, gen)
 VALUES(3,'송중기', 35, 'm');
 
 SELECT * FROM emp04;
 
 ALTER TABLE emp04
   ADD CONSTRAINT emp04_name_uk unique(name);
 
 --ORA-00001: unique constraint (HR.EMP04_NAME_UK) violated
INSERT INTO emp04(id, name, age, gen)
 VALUES(4,'송중기', 35, 'm'); 
 
INSERT INTO emp04(id, name, age, gen)
 VALUES(4,'박찬', 35, 'm'); 
 
  SELECT * FROM emp04;
--ORA-00904: : invalid identifier
--00904. 00000 -  "%s: invalid identifier"
  ALTER TABLE emp04
   ADD CONSTRAINT emp04_name_nn not null(sal); 

-- NOT NULL추가는 MODIFY으로 설정한다.     
   ALTER TABLE emp04
  MODIFY name NOT NULL;
  
 --ORA-01400: cannot insert NULL into ("HR"."EMP04"."NAME") 
  INSERT INTO emp04(id, name, age, gen)
 VALUES(5,null, 35, 'm');  
 
 INSERT INTO emp04(id, name, age, gen)
VALUES(5, '김연아', 35, 'w'); 

SELECT * FROM emp04;

/*=================================================
제약조건 삭제
 ALTER TABLE table_name
  DROP constraint constraint_name
======================================================*/
  ALTER TABLE emp04
   DROP CONSTRAINT emp04_age_ck;
   
   
INSERT INTO emp04(id, name, age, gen)
VALUES(6, '박둘이', 10, 'w'); 

/*=============================================================
제약조건 수정
  ALTER TABLe table_name
     MODIFY column_name CONSTRAINT constraint_name constraint_type
============================================================*/

ALTER TABLE emp04
 MODIFY age CONSTRAINT emp04_age_ck check(age>0);

INSERT INTO emp04(id, name, age, gen)
VALUES(7, '박솔미', 6, 'w');

SELECT * FROM emp04;

DESC emp04;

/*=========================================================================
데이터 딕셔너리(Data Dictionary)
  데이터베이스를 운영하기 위한 정보들을 모두 특정한 곳에 모아두고 관리하는데 
  이것을 데이터 딕셔너리라고 한다.
  데이터 딕셔너리는  메모리구조와 파일에 대한 구조정보, 
  각 오브젝트들이 사용되는 공간들의 정보, 제약조건 정보,
  사용자에 대한 정보, 권한이나 프로파일, 롤에대한 정보, 
  감사에 대한정보들을 관리한다.
  constraint_type : primary key=> P     foregin key=>R
                   check, not null=>C
                   unique=>U
===========================================================================*/

SELECT * FROM user_constraints;

SELECT * FROM user_constraints
WHERE constraint_name LIKE '%EMP04%';

/*====================================================================*/

CREATE TABLE dept01(
   deptno number(2) CONSTRAINT dept01_deptno_pk primary key,
   dname varchar2(20)
 );

INSERT INTO dept01
VALUES(10,'accounting');   

INSERT INTO dept01
VALUES(20,'sales');

INSERT INTO dept01
VALUES(30,'research'); 
   
SELECT * FROM dept01;  

CREATE TABLE loc01(
  locno number(2),
  locname varchar2(20),
   CONSTRAINT loc01_locno_pk primary key(locno));
 
   INSERT INTO loc01
   VALUES(11,'seoul');
   
   INSERT INTO loc01
   VALUES(22,'jeju');
   
   INSERT INTO loc01
   VALUES(33,'busan');  
 
 SELECT * FROM loc01;

 CREATE TABLE emp07(
   empno number(2) constraint emp07_deptno_pk primary key,
   deptno number(2) 
         constraint emp07_deptno_fk references dept01(deptno),
   locno number(2) ,
        constraint emp07_locno_fk foreign key(locno) references loc01(locno)
); 

 SELECT * FROM emp07;
 
 --정상 삽입
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(1, 10, 11);
 
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(2, 20, 22);

 INSERT INTO emp07(empno, deptno, locno)
 VALUES(3, null, null);
 
  SELECT * FROM emp07;
  
  --ORA-02291: integrity constraint (HR.EMP07_DEPTNO_FK) violated - parent key not found
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(4, 40, 11);
 
 --ORA-02291: integrity constraint (HR.EMP07_LOCNO_FK) violated - parent key not found
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(4, 30, 44);
  
SELECT * FROM emp07;
 
 --emp07테이블의 deptno컬럼에서 30을 참조하지 않기 때문에 이상없이 삭제가 가능하다.
DELETE FROM dept01
 WHERE deptno=30;
 
 SELECT * FROM dept01;
 
 -- ORA-02292: integrity constraint (HR.EMP07_DEPTNO_FK) violated - child record found
DELETE FROM dept01
 WHERE deptno=20;
 
 /*=========================================================================
다른 테이블에서 현재 테이블을 참조해서 사용하고 있을때는
    제약조건을 제거한후 현재 테이블의 데이터를 삭제한다.
==========================================================================*/
 
 ALTER TABLE emp07
 DROP CONSTRAINT emp07_deptno_fk;
 
 DELETE FROM dept01
 WHERE deptno=20;
 
 SELECT * FROM dept01;
 SELECT * FROM emp07;
 
 /*=========================================================
부모키가 삭제가 되면 참조되는 키도 삭제가 되도록 cascade을 설정한다.
==========================================================*/
 --삽입
INSERT INTO dept01
VALUES(20,'sales');
 
 SELECT * FROM dept01;
 SELECT * FROM emp07;
 
 -- CASCADE 설정
ALTER TABLE emp07
 ADD constraint emp07_deptno_rk foreign key(deptno) references dept01(deptno) ON DELETE CASCADE;
 
DELETE FROM dept01
WHERE deptno=10;
 
 SELECT * FROM dept01;
 SELECT * FROM emp07;
 
 /*==========================================
ON UPDATE CASCADE은 오라클에서 제공안됨
해결방법 : trigger
==========================================*/
 
 CREATE OR REPLACE TRIGGER dept_tri
 AFTER UPDATE ON dept01 FOR EACH ROW
 BEGIN
  UPDATE emp07
  SET deptno=50
  WHERE deptno=20;
 END;
/

UPDATE dept01
SET deptno=50
WHERE deptno=20;

SELECT * FROM dept01;
SELECT * FROM emp07;
 