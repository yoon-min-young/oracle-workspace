/*===============================
���̺� ���� ����
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

�ڷ���(datatype)
varchar2 - �������� ���ڸ� ����
char - �������� ���ڸ� ����
number(m)-��������
number(m,n)- �Ǽ�����
date - ��¥ ����
===============================*/
CREATE TABLE student(
  name varchar2(20), --����Ʈ(����,Ư������- 1byte / �ѱ�-3byte)
  age number(3),   --�ڸ���
  avg number(5, 2), --5�� ��ü�ڸ���, 2�� �Ҽ��� �ڸ���
  hire date  
);

-- �������
INSERT INTO student(name, age, avg, hire)
VALUES('ȫ�浿',   30,     97.85,     sysdate);

SELECT * FROM student;

--ORA-12899: value too large for column "HR"."STUDENT"."NAME" (actual: 26, maximum: 20)
----'������ ���� ����' : ũ�� �ʰ�(20����Ʈ������ ����)
INSERT INTO  student(name, age, avg, hire)
VALUES('������ ���� ����', 30,    97.85,  sysdate);

--ORA-01438: value larger than specified precision allowed for this column
--4000: ũ���ʰ�(3�ڸ����ڸ� ����- 0 ~ 999)
INSERT INTO student(name, age, avg, hire)
VALUES('ȫ�浿',   4000,     97.85,     sysdate);

--ORA-01438: value larger than specified precision allowed for this column
--2921.8589 : ũ���ʰ�(5�ڸ������� ����)-�Ҽ����� �������� �ʴ´�. 
INSERT INTO student(name, age, avg, hire)
VALUES('ȫ�浿',   30,     2921.8589,     sysdate);

-- �Ҽ��ڸ����� �ʰ��ϸ� ©���� ����ȴ�.
INSERT INTO student(name, age, avg, hire)
VALUES('ȫ�浿',   30,     921.8589,     sysdate);

SELECT * FROM  student;

-- ORA-01438: value larger than specified precision allowed for this column
-- �Ҽ���2�ڸ��� ������ ����� �Ѵ�. �� �����ڸ��� 3�ڸ�� ����Ѵ�.
INSERT INTO student(name, age, avg, hire)
VALUES('ȫ�浿',   30,     2921.8,     sysdate);

SELECT * FROM  student;