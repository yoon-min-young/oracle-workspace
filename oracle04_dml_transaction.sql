/*==========================================================
����Ŭ���� �����Ǵ� ��ɾ�
1 DML(Data Manipulation Language ������ ���۾�) : 
  �����ʹ� �߰�, ����, ����, �˻�, �������ִ� ��ɾ���̴�.
  (insert, update, delete, select, merge)
2 DDL(Data Definition Language ������ ���Ǿ� ) : 
  ���̺��� ������ ����, �������ִ� ��ɾ���̴�.
  (create, drop, alter, truncate)
3 DCL(Data Control Language ������ �����) : 
  ������� ������ �ο�,�������ִ� ��ɾ���̴�.(grant ,revoke)
4 TCL(Transaction Control Language Ʈ����� ó����) : 
  Ʈ����� ����,����� ó�����ִ� ��ɾ���̴�
  (commit, rollback, savepoint)
==========================================================*/
DROP TABLE emp01;

-- ���̺� ������ ����
CREATE TABLE emp01
AS
SELECT first_name, salary
FROM employees
WHERE  1=0;

SELECT * FROM emp01;
DESC emp01;

/*--���̺� ���ڵ带 ����
INSERT INTO ���̺��(column1, column2)
VALUES('��1', ��2);
*/

INSERT INTO emp01(first_name, salary)
VALUES('candy' , 5000);
SELECT * FROM emp01;

--���̺� ��� �÷��� �����͸� �����Ҷ��� �÷����� ������ �� �ִ�. 
INSERT INTO emp01
VALUES('Steven', 4000);
SELECT * FROM emp01;

--����� NULL ���Թ��
INSERT INTO emp01(first_name, salary)
VALUES('Lex', null);
SELECT * FROM emp01;

--������ NULL ���Թ��
INSERT INTO emp01(first_name)
VALUES('Paran');
SELECT * FROM emp01;


/*=======================================
���̺��� ������ �����ϴ� ��ɾ��̴�.
UPDATE ���̺�� 
SET �÷�1=��1, �÷�2=��2 
WHERE �÷�=��;
=========================================*/
--emp01���̺� first_name�÷��� ���� 'candy'�� ��
--salary�÷��� ���� 8000���� ������Ʈ�϶�.
UPDATE emp01
SET salary=8000
WHERE first_name='candy';   /* salary���� 5000���� 8000���� ���� */

SELECT * FROM emp01;

/*=============================================
���̺��� ������ �����ϴ� ��ɾ��̴�.
DELETE
DELETE   FROM table_name WHERE column_name = value;
===============================================*/
DELETE FROM emp01
WHERE first_name='candy';

SELECT * FROM emp01;

/*======================================
Ʈ�����(Transaction)
1 Ʈ����� ����
  -�ѹ��� ����Ǿ�� �� �����ͺ��̽��� �Ϸ��� Read��
   Write ������ �����ϴ� ����
  -�ϳ��� ���� ����� �����ϱ� ���� �۾��� �����μ�
  �����ͺ��̽��� �ϰ��� ���¸� �� �ٸ� �ϰ��� ���·�
  ��ȯ��Ŵ
  
  Ʈ����ǽ���-> ����->����->���� -> Ʈ���������
  �ϳ��� �۾��� �����ؼ� ���������� ����ɶ������� ������ ���Ѵ�.
  (������ �۾�����)
  
  ����(ATM)->��� ī�����-> ��谡 ī�带 ����->
  ����ݾ� �Է�-> ��й�ȣ �Է�-> ��迡�� ��ݾ� ó��
  -> ��ݱݾ� ����-> ī������
  
  <Ʈ����� ����>
  -�����ͺ��̽��� ó�� �������� ��
  -�ϳ� �Ǵ� ���� ���� DML���� ������� commit �Ǵ� rollback
   ���� ����� ����
  
   <Ʈ����� ����>
  - commit �Ǵ� rollback���� ����ɶ�
  - DDL �Ǵ� DCL���� ����� ��
  - ���������� �����ͺ��̽��� �����Ҷ�
  - ������������ �����ͺ��̽��� �����Ҷ�
  
2 Ʈ����� ������ Ȯ���� ���� ACID
  1) ACID���� 
     -�����ͺ��̽����� ������ �۾������� Ʈ�������
       �����ϰ� ����Ǵ� ���� �����ϴ� Ư������
  2) ACID�� �ʿ伺
     -���� ����� ȯ�� ���� :���ϵ�����-�����۾�ȯ�濡����
          ������ ó�� ��Ȯ�� ����
     -������ Ʈ����� ������ ���� �����ͺ��̽� ���Ἲ ����
  3) Ʈ���輺 �������   
    Atomicity(���ڼ�):
     -Ʈ������� �� �� �̻��� ������ �������� �� ����
      �۾�����(single unit of work)�μ� ���ذ�
      �Ұ����� �ּ��� ����
     -���� ��ü�� ���������� ó���ǰų� �Ǵ� �� ������
      ������ ��� ��ü�� ��ҵǾ� ���Ἲ�� ����
      (All or Nothing)
    Consistency(�ϰ���):
    -Ʈ������� ������ ���������� �Ϸ��ϸ� ������ ��� ����
     �ϰ��� �ִ� �����ͺ��̽� ���¸� ������
    - ���̺��� ����Ÿ�� ���ŵǰ� �׿� ���� �ε����� ���ŵ��� �ʴ� ���� �������� �־ �ʵȴ�.
    Isolation(����,������):
    -Ʈ������� ���� �߿� �����ϴ� ������ �߰� �����
     �ٸ� Ʈ������� ������ �� ����
   -Ŀ�Ե� Ʈ������� ��ְ� �߻��ص� ����Ÿ�� �����ǿ��� �Ѵٴ� Ư��.
   Durability(���Ӽ�,���Ӽ�,������):
    -������ �Ϸ�� Ʈ������� ����� ���������� �����ͺ��̽���
     �����
========================================================================================*/
/*�ڵ�Ŀ�� ���� Ȯ��(SQL Developer)
����>ȯ�漳��>�����ͺ��̽�>��ü���> �ຯ��� ��������, �ڵ�Ŀ�� ���� üũ ���� */

SELECT * FROM emp01;
commit;

INSERT INTO emp01
VALUES('Beta', 7000);

SELECT * FROM emp01;
commit;

INSERT INTO emp01
VALUES('John', 2000);

SELECT * FROM emp01;

SAVEPOINT sp;      /* �߰��� */

DELETE FROM emp01
WHERE first_name='Beta';

SELECT * FROM emp01;

ROLLBACK TO sp; 

SELECT * FROM emp01;

commit;

CREATE TABLE emp02(
  emp_id  number primary key,       /* NOT NULL + UNIQUE */
  first_name varchar2(50),
  salary number
);

SELECT table_name FROM user_tables;

--A����
INSERT INTO emp02
VALUES(1, 'park', 9000);

SELECT * FROM emp02;

--B����
INSERT INTO emp02
VALUES(1, 'park', 9000);

--A����
commit;

--B����
-- A������ COMMIT�� �Ǹ� B������ �ش� �࿡ ���� LOCK���°� ������ �Ǹ鼭 �����޼��� ���
--ORA-00001: unique constraint (HR.SYS_C006997) violated


--B����
INSERT INTO emp02
VALUES(2, 'dong', 8000);

SELECT * FROM emp02;

--A����
SELECT * FROM emp02;

INSERT INTO emp02
VALUES(2, 'dong', 8000);


--B����
ROLLBACK;   /* ��� */


--A����
 --1 �� ��(��) ���ԵǾ����ϴ�.(INSERT����)
 commit;
 
 --B����
 SELECT * FROM emp02;     /* 2 dong 8000 �� �˻��� */
 
 --A����
 UPDATE  emp02
 SET first_name='min'
 WHERE emp_id=2;
 
 SELECT * FROM emp02; 
 
--B����
  SELECT * FROM emp02; 
  
  DELETE FROM emp02
  WHERE emp_id=2;   /*  Lock �ɷ����� */
  
   --A����
 commit;
 
 --B����
 1 row deleted.  
 SELECT * FROM emp02;  /*  2 min 800  ���� */
 
  --A����
  SELECT * FROM emp02;  /*  2 min 800  ���� �ȵ�*/
  
   --B����
    commit;
    
 --A����
 SELECT * FROM emp02;  /*  2 min 800  ���� */
 
 