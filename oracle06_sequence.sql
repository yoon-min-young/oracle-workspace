/*-------------------------------------------------------------
 ������(sequence)
   ���̺� ���� ������ ���ڸ� �ڵ����� �����ϴ� �ڵ���ȣ �߻��̹Ƿ� ��������
   �⺻ Ű�� ����ϸ� ������� �δ��� ���� �� �ִ�.

     create sequence ��������
     start with  n - ������ ���۹�ȣ
     increment by n  -������ ����ġ
     nocache  -cache�� �޸𸮻��� ���������� �����ϰ� �ϴµ� �⺻���� 20�̴�.
              -nocache�� �޸𸮻��� �������� �������� �ʴ´�.
     nocycle  - cycle�� ������ ���������� �ִ밪���� ������ �Ϸ��ϸ� start with
                �ɼǿ� ������ ���۰����� �ٽ� �������� �����Ѵ�.
              - nocycle��  ������ �Ϸ�Ǹ� ������ �����Ѵ�.

    maxvalue n;- �������� ������ �ִ� �ִ밪�� �����Ѵ�.
              maxvalue�� �⺻���� ascending�϶� 1027��, descending �϶� -1�̴�.
-------------------------------------------------------------------------- */
SELECT * FROM tab;   

CREATE TABLE  emp03(
   num number,
   name varchar2(20)
 );
 
 SELECT * FROM user_tables
 WHERE table_name='EMP03';
 
 SELECT * FROM user_sequences;
 
  CREATE SEQUENCE emp03_num_seq
 START WITH 1
 INCREMENT BY 1
 NOCACHE
 NOCYCLE;
 
 SELECT * FROM user_sequences
 WHERE sequence_name = 'EMP03_NUM_SEQ';

--nextval : ���� ������(�����Ҷ����� 1�� �����Ѵ�)
 SELECT emp03_num_seq.nextval FROM dual;
 
 --currval: ���� ������ - nextval�� ������ ���� ��밡��
 SELECT emp03_num_seq.currval FROM dual;
 
 
 INSERT INTO emp03(num, name)
 VALUES( emp03_num_seq.nextval, 'ȫ�浿');
 
  SELECT * FROM emp03;
  
   SELECT emp03_num_seq.currval FROM dual;

 INSERT INTO emp03(num, name)
 VALUES( emp03_num_seq.nextval, '���');
 
SELECT * FROM emp03;
   
DELETE FROM emp03
WHERE num=2;
   
SELECT * FROM emp03; 
   
INSERT INTO emp03(num, name)
 VALUES( emp03_num_seq.nextval, '������');   
 
 SELECT * FROM emp03; 
 
 /*=================================================*/
 
    CREATE TABLE mem(
   num number,
   name varchar2(50),
   age number,
   loc varchar2(30));
   
   SELECT * FROM mem;
   
CREATE SEQUENCE mem_num_seq 
 START WITH 1
 INCREMENT BY 1
 NOCACHE
 NOCYCLE;
 
 SELECT * FROM user_sequences;
 
 INSERT INTO mem
VALUES(mem_num_seq.nextval, '���', 30, '����');

SELECT * FROM mem;
COMMIT;


