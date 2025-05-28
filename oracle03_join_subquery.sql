/*=======================================================
join : �������� ���̺��� ���ϴ� ���̺��� �������ִ� �������̴�.

join�� oracle��ǰ���� ���Ǵ� oracle�� join�� �ְ�
��� ��ǰ���� ���������� ���Ǵ� ǥ��(ANSI) join�� �ִ�.
�̱� ���� ǥ�� ��ȸ(American National Standards Institute,ANSI)
========================================================*/
--1. carteian product(īƼ�� ��) ���� : 
--   ���̺� ���� ������ŭ ������ִ� �����̴�.
--1) oracle�� cartesian product
  SELECT e.department_id,  e.first_name,  e.job_id,   j.job_title
  FROM employees e, jobs  j;         --2,033
  
  SELECT *
  FROM employees; --107
  
  SELECT *
  FROM jobs;  --19
  
--(2) ANSI�� cross join
 SELECT e.department_id, e.first_name, e.job_id, j.job_title
 FROM employees e cross join jobs  j; 
 
  /*
 2. equi join
    ���� ���� ���Ǵ� ���ι������ ���� ����� �Ǵ� �� ���̺��� ���������� �����ϴ� �÷��� ����
    ��ġ�Ǵ� ���� �����Ͽ� ����� �����ϴ� ����̴�.
 */
 --(1) oracle�� equi join
  SELECT e.department_id, e.first_name, e.job_id, j.job_title
  FROM employees e, jobs  j
  WHERE e.job_id=j.job_id;
 
--(2) ansi�� inner join
 SELECT e.department_id, e.first_name, e.job_id, j.job_title  
  FROM employees e inner join jobs  j  
  ON e.job_id=j.job_id;


--employees�� departments���̺��� �����ȣ(employee_id),
--�μ���ȣ(department_id), �μ���(department_name)�� �˻��Ͻÿ�.
SELECT e.employee_id, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id;
 
SELECT e.employee_id, d.department_id, d.department_name
FROM employees e  inner join    departments d
ON e.department_id=d.department_id;

--employees�� jobs���̺��� �����ȣ(employee_id),
--������ȣ(job_id), ������(job_title)�� �˻��Ͻÿ�.
SELECT e.employee_id, j.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id=j.job_id;

SELECT e.employee_id, j.job_id, j.job_title
FROM employees e INNER JOIN jobs j
ON e.job_id=j.job_id; 

 --job_id�� 'FI_MGR'�� ����� ����
 --�޿�(salary)�� �ּҰ�(min_salary), �ִ밪(max_salary)�� ����Ͻÿ�. 
 SELECT e.first_name, e.job_id, j.min_salary, j.max_salary
FROM employees e, jobs j
WHERE e.job_id = j.job_id
   AND e.job_id = 'FI_MGR';


SELECT e.first_name, e.job_id, j.min_salary, j.max_salary
FROM employees e  INNER JOIN jobs j
ON e.job_id = j.job_id
 WHERE e.job_id = 'FI_MGR';


--�μ��� 'Seattle'�� �ִ� �μ����� �ٹ��ϴ�
--��������  first_name, hire_date, department_name, city
--����ϴ� SELECT�� �ۼ��Ͻÿ�.
SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id=d.department_id
 AND  d.location_id=l.location_id
 AND  l.city='Seattle';


SELECT e.first_name  , e.hire_date, d.department_name, l.city
FROM employees e   INNER JOIN    departments d   ON  e.department_id=d.department_id
                                      INNER JOIN  locations l  ON      d.location_id=l.location_id
WHERE  l.city='Seattle';

--20�� �μ��� �̸��� �� �μ��� �ٹ��ϴ� ����� �̸�(first_name)�� ����Ͻÿ�.
SELECT d.department_id, d.department_name, e.first_name
FROM employees e, departments d
WHERE e.department_id=d.department_id
AND d.department_id=20;

SELECT d.department_id, d.department_name, e.first_name
FROM employees e INNER JOIN departments d
ON e.department_id=d.department_id
WHERE d.department_id=20;

--1400, 1500�� ��ġ�� �����̸��� �� ���� �ִ� �μ��� �̸��� ����Ͻÿ�.
SELECT l.location_id, l.city, d.department_name
FROM locations l, departments d
WHERE l.location_id=d.location_id 
  AND l.location_id IN(1400, 1500);
  
SELECT l.location_id, l.city, d.department_name
FROM locations l INNER JOIN departments d
ON l.location_id=d.location_id 
WHERE l.location_id IN(1400, 1500);  

/*===================================
3. non-equi join (������)
  (=)����񱳿����ڸ� ������ >=, <=, >, <���� �����ڸ� 
  �̿��ؼ� ������ �����ϴ� ���ι���̴�.
=======================================*/
--(1) oracle�� non-equi join
SELECT e.first_name, e.salary, j.min_salary,
               j.max_salary, j.job_title
FROM employees e, jobs j               
WHERE  e.job_id=j.job_id
  AND e.salary>=j.min_salary
       AND e.salary<=j.max_salary;

--(2) ansi�� non-equi join
SELECT e.first_name, e.salary, j.min_salary,
       j.max_salary, j.job_title
FROM employees e JOIN jobs j
ON e.job_id=j.job_id
WHERE e.salary>=j.min_salary
AND e.salary<=j.max_salary;

/*=================================================================
4. outer join
  �� ���̺��� �����Ͱ� �ְ� �ٸ� �ݴ��ʿ��� �����Ͱ� ���� ��쿡
  �����Ͱ� �ִ� ���̺��� ������ ��� �������� �����̴�.
  https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/
  ===============================================================*/
--(1) oracle outer join
  SELECT e.employee_id, e.first_name, e.employee_id, e.department_id, 
          d.department_id, d.department_name 
  FROM employees e, departments d
  WHERE e.department_id=d.department_id(+)
  ORDER BY e.employee_id;  /* LEFT OUTER JOIN*/

 SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e, departments d
 WHERE e.department_id(+)=d.department_id; /* RIGHT OUTER JOIN */
 
 
 
 --(2) ansi outer join
  SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e LEFT OUTER JOIN departments d
 ON e.department_id=d.department_id;
 
 SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e RIGHT OUTER JOIN departments d
 ON e.department_id=d.department_id;
 
 SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e FULL OUTER JOIN departments d
 ON e.department_id=d.department_id;
 
 
 
 
 /*=================================================
5. self join
 �ϳ��� ���̺��� �ΰ��� ���̺�� �����ؼ� ����ϴ� ���ι���̴�.
 �ϳ��� ���̺� ���������Ͱ� �ΰ��� �÷��� �ٸ� �������� ����ǿ� �ִ� ���
 employees, employee_id, manager_id
====================================================*/
 --(1) oracle self join
 SELECT w.employee_id AS "�����ȣ",
               w.first_name AS "����̸�",
              w.manager_id  AS "�����ڹ�ȣ",
             m.first_name AS "�������̸�"
 FROM employees w, employees m
 WHERE w.manager_id=m.employee_id
 ORDER BY w.employee_id;
 
 
 --(2) ansi self join
 SELECT w.employee_id AS "�����ȣ",
        w.first_name AS "����̸�",
        w.manager_id  AS "�����ڹ�ȣ",
        m.first_name AS "�������̸�"
 FROM employees w  JOIN employees m
 ON w.manager_id=m.employee_id
 ORDER BY w.employee_id;
 
 ----------------------------------------
--USING :�� ���̺� �� ���� ���ǿ� ���Ǵ� �÷����� ������ ��� USING�� ����Ѵ�.
--       ������ �ٸ� ��쵵 �����Ƿ� USING ��� ON ���� ����ϴ� ���� �Ϲ����̴�.
SELECT department_id, first_name, job_id, job_title  
FROM employees  
INNER JOIN jobs USING(job_id);
   
SELECT first_name, hire_date, department_name, city
FROM employees 
INNER JOIN departments USING(department_id)
INNER JOIN locations USING(location_id)
WHERE  city='Seattle';
 
 
 /*----------------------------------------------
 ����
 ----------------------------------------------   */
--1)EMPLOYEES ���̺��� �Ի��� ��(hire_date) ���� �ο����� ��ȸ�Ͻÿ� . 
--  <���: ��        ������   >
SELECT to_char(hire_date,'mm') || '��' AS "��", count(*) AS "������"
FROM employees
GROUP BY to_char(hire_date,'mm')
ORDER BY to_char(hire_date,'mm');


--2)�� �μ����� �ٹ��ϴ� �������� ��ȸ�ϴ� SQL ��ɾ �ۼ��Ͻÿ�. 
--��, �������� 5�� ������ �μ� ������ ��µǾ�� �ϸ� �μ������� ���� ������ �ִٸ� �μ��� ��<�̹�ġ�ο�>�� �̶�� ���ڰ� ��µǵ��� �Ͻÿ�. 
--�׸��� ��°���� �������� ���� �μ����� ��µǾ�� �մϴ�.
 SELECT nvl(d.department_name, '<�̹�ġ�ο�>'), count(*) 
 FROM employees e, departments d
 WHERE e.department_id=d.department_id(+)   /* LEFT OUTER JOIN */
GROUP BY d.department_name
HAVING count(*) <= 5
ORDER BY count(*) DESC;
 

--3)�� �μ� �̸� ���� 2005�� ������ �Ի��� �������� �ο����� ��ȸ�Ͻÿ�.   /*  ���� <=, ���� >=   4�� 21����(<)   4�� 21������(<=) */ 
-- <��� :    �μ���		�Ի�⵵      	�ο���  >
 SELECT d.department_name AS "�μ���",   to_char(e.hire_date, 'yyyy') AS "�Ի�⵵" ,  count(*) AS "�ο���"
 FROM employees e, departments d
 WHERE e.department_id=d.department_id(+)
 GROUP BY d.department_name, to_char(e.hire_date, 'yyyy')
 HAVING to_char(e.hire_date, 'yyyy') <= '2005'
 ORDER BY to_char(e.hire_date, 'yyyy') DESC; 
 
--4)��å(job_title)���� 'Manager'�� �����̵� ����� �̸�(first_name), ��å(job_title), �μ���(department_name)�� ��ȸ�Ͻÿ�.
  SELECT e.first_name, j.job_title, d.department_name
  FROM employees e, jobs j, departments d
  WHERE e.job_id=j.job_id
   AND e.department_id=d.department_id
   AND j.job_title LIKE '%Manager%';
  
--5)'Executive' �μ��� �ӿ� �ִ� �������� ������ �̸��� ��ȸ�Ͻÿ�. 
--��, �����ڰ� ���� ������ �ִٸ� �� ���� ������ ��°���� ���Խ��Ѿ� �մϴ�.
 --<��� : �μ���ȣ ������  �����ڸ�  > 
 SELECT e.department_id AS "�μ���ȣ", e.first_name AS "������",  m.first_name AS "�����ڸ�"
 FROM employees e, employees m,  departments d 
 WHERE e.department_id=d.department_id
   AND e.manager_id = m.employee_id(+)
 AND d.department_name='Executive';
 
 /*-----------------------------------------------------------------------------------------
��������(subquery)
 �ϳ��� SQL���ȿ� ���ԵǾ� �ִ� �� �ٸ� SQL���� ���Ѵ�.
 ���������� �˷����� ���� ������ �̿��� �˻��� ���� ����Ѵ�.
 ���������� ���������� ���������� �����ϴ� �������� �����̴�.
 ���������� ���������� �÷��� ��� ����� �� ������ ���������� ���������� �÷��� ����� �� ����. 
 ���� ����� �������� �÷��� ǥ���ؾ� �Ѵٸ� ���ι������ 
    ��ȯ�ϰų� �Լ�, ��Į�� ��������(scarar subquery)���� ����ؾ� �Ѵ�. 
 ������ ���հ��� ��(Product)�� �����̴�. 
 
�ܺ� ���� (��������)
 :�Ϲ� ������ �ǹ��մϴ�.
��Į�� ��������
 :SELECT ���� ������ ���Ǵ� ����, �Լ�ó�� ���ڵ�� ��Ȯ�� �ϳ��� ������ ��ȯ�ϴ� ���������Դϴ�.
�ζ��� ��
 :FROM ���� ���Ǵ� ������, ���ϴ� �����͸� ��ȸ�Ͽ� ������ ������ ����� ������ �����ϰų� ������ ������ �ٽ� ��ȸ�� �� ����մϴ�.



���������� ����� �� ���� ���׿� ����
  ���������� ��ȣ�� ���μ� ����Ѵ�. 
  ���������� ���� ��(Single Row) �Ǵ� ���� ��(Multiple Row) �� �����ڿ� �Բ� ��� �����ϴ�. 
  ���� �� �� �����ڴ� ���������� ����� �ݵ�� 1�� �����̾�� �ϰ� ���� �� �� �����ڴ� ���������� ��� �Ǽ��� ��� ����. 
  �������������� ORDER BY�� ������� ���Ѵ�. 
  ORDER BY���� SELECT������ ���� �� ���� �� �� �ֱ� ������ ORDER BY���� ���������� ������ ���忡 ��ġ�ؾ� �Ѵ�.
  

���� ���� ��밡���� ��ġ
SELECT, FROM, WHERE, HAVING,ORDER BY 
INSERT���� VALUES,
UPDATE���� SET, 
CREATE��

���������� ������ �����ϴ� ����̳� ��ȯ�Ǵ� �������� ���¿� ���� �з��� �� �ִ�.
1 �����ϴ� ��Ŀ� ���� �������� �з�
  Un-Correlated(�񿬰�) : ���������� �������� �÷��� ������ ���� �ʴ� ������ ���������̴�.
          ���������� ��(���������� ����� ���)�� �����ϱ� ���� ��������  �ַ� ����Ѵ�.
  Correlated(����) : ���������� �������� Į���� ������ �ִ� ������ ���������̴�.
          �Ϲ������� ���������� ���� ����Ǿ� ������ �����͸� ������������ ������ �´��� Ȯ��
	  �ϰ��� �� �� �ַ� ���ȴ�.  (EXISTS���������� �׻� ���� ���������� ���ȴ�. ������ �����ϴ� 1�Ǹ� ã����
	  �߰� �˻��� ���� �ʴ´�.)
2 ��ȯ�Ǵ� �������� ���¿� ���� �������� ����
  Single Row(������ ��������) : ���������� �������� �׻� 1�� ������ ���������� �ǹ��Ѵ�. 
          ������ ���������� ���� �� �� �����ڿ� �Բ� ���ȴ�.
	  ���� �� �� �����ڴ� =, <, <=, >, >=, <>�� �ִ�.
  Multi Row(������ ��������) : ���������� ���� ����� ���� ���� ���������� �ǹ��Ѵ�. 
          ���� �� ���������� ���� �� �� �����ڿ� �Բ� ���ȴ�. 
	  ���� �� �� �����ڿ��� in, all, any, some, exists�� �ִ�.
	      in : ���������� ������('='�����ڷ� ���� ���)�� ���������� ��� �߿���
               �ϳ��� ��ġ�ϸ� ���̴�.
           any,some : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ� �̻��� ��ġ�ϸ�
                ���̴�.
           all : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ���̴�.
           exists : ���� ������ �� ������ ���� ������ ��� �߿��� �����ϴ� ���� �ϳ���
               �����ϸ� ���̴�.
  Multi Column(����Į�� ��������) : ���������� ���� ����� ���� �÷��� ��ȯ�Ѵ�.
          ���������� �������� ���� �÷��� ���ÿ� ���� �� �ִ�. 
	  ���������� ������������ ���ϰ��� �ϴ� �÷� ������ �÷��� ��ġ�� �����ؾ� �Ѵ�.
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	  
--------------------------------------------------------------------------------- */ 
 -- 90��  �μ��� �ٹ��ϴ� Lex�� �μ����� ����Ͻÿ�.
 SELECT  department_name
 FROM departments
 WHERE department_id=90;
 
 -- Lex�� �ٹ��ϴ� �μ����� ����Ͻÿ�.
 SELECT department_id
 FROM employees
 WHERE first_name='Lex';
 
 SELECT  department_name
 FROM departments
 WHERE department_id=90;
 
 SELECT  d.department_name
 FROM employees e, departments d
 WHERE e.department_id=d.department_id
    AND e.first_name='Lex';
    
SELECT department_name
FROM departments
WHERE  department_id= (
                                         SELECT department_id
                                         FROM employees
                                         WHERE first_name='Lex'
                                         );

/*
  [ �������]
  1. �������� ����  
        SELECT department_id
          FROM employees
         WHERE first_name='Lex' 
   2.  ����������  from ��
        FROM departments
  3.  ���������� where��
        WHERE  department_id=90
  4. ���������� select��
      SELECT department_name
*/
    
    
 --'Lex'�� ������ ����(job_id)�� ���� ����� �̸�(first_name), 
 -- ������(job_title), �Ի���(hire_date)�� ����Ͻÿ�.    
 SELECT e.first_name, j.job_title, e.hire_date
 FROM employees e, jobs j
 WHERE e.job_id=j.job_id
     AND  e.job_id = (
                                    SELECT job_id
                                    FROM employees
                                    WHERE first_name = 'Lex'
                                   );
 
 -- 'IT'�� �ٹ��ϴ� ����̸�(first_name), �μ���ȣ�� ����Ͻÿ�. 
 SELECT  first_name, department_id
 FROM employees
 WHERE department_id = (
                                                SELECT department_id
                                                FROM departments
                                                WHERE department_name='IT'
                                                );l
 
--'Bruce'���� �޿��� ���� ���� ����̸�(first_name), �μ���, �޿��� ����Ͻÿ�. 
 SELECT e.first_name, d.department_name, e.salary
 FROM employees e, departments d
 WHERE e.department_id=d.department_id
    AND e.salary > ( 
                                  SELECT salary
                                  FROM employees
                                  WHERE first_name = 'Bruce'
                                  )
ORDER BY e.salary ASC;

--Steven�� ���� �μ����� �ٹ��ϴ� ����� �̸�, �޿�, �Ի����� ����Ͻÿ�.(in)
SELECT department_id
FROM employees
 WHERE first_name='Steven';  /*  2row  �̹Ƿ�  IN �����ڸ� ����ؼ� ���������� �ۼ��ؾ� �Ѵ�.*/
 
 SELECT first_name, salary, hire_date, department_id
 FROM employees
 WHERE department_id IN (
                                                SELECT department_id
                                                FROM employees
                                                WHERE first_name='Steven'
                                                );
 
  --�μ����� ���� �޿��� ���� �޴� ����̸�, �μ���ȣ, �޿��� ����Ͻÿ�.(in)
  SELECT department_id,  max(salary)
  FROM employees
  GROUP BY department_id;
    
 SELECT first_name, department_id, salary
 FROM employees
 WHERE (department_id, salary)  IN (
                                                                SELECT department_id,  max(salary)
                                                                FROM employees
                                                                GROUP BY department_id
                                                                );
 
 --�μ��� IT�� �����̵� ����� ���� �����(first_name), 
--�μ���ȣ(department_id), �μ���(department_name)�� ����Ͻÿ�.(in)
SELECT department_name
FROM departments
WHERE department_name LIKE '%IT%';

SELECT  e.first_name,  d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id
  AND d.department_name  IN (
                                                        SELECT department_name
                                                        FROM departments
                                                        WHERE department_name LIKE '%IT%'
                                                        );

--30�Ҽӵ� ����� �߿��� �޿��� ���� ����  ���� ������� �� ���� �޿��� �޴�
--����̸�, �޿�, �Ի����� ����Ͻÿ�. (ALL)
--(������������ max()�Լ��� ������� �ʴ´�);
SELECT salary
FROM employees
WHERE department_id=30;

SELECT  first_name, salary, hire_date
FROM employees
WHERE salary  >ALL (
                                        SELECT salary
                                        FROM employees
                                        WHERE department_id=30
                                       );
 
 --30�Ҽӵ� ������� ���� �޿�����  ���� �޿��� �޴� 
--����̸�, �޿�, �Ի����� ����Ͻÿ�. (ANY)
--(������������ min()�Լ��� ������� �ʴ´�);
SELECT  first_name, salary, hire_date, department_id
FROM employees
WHERE salary  >ANY (
                                        SELECT salary
                                        FROM employees
                                        WHERE department_id=30
                                       )
       AND  department_id != 30;                             


  --Toronto ���ÿ� �ٹ��ϴ� ������� �޴� �ּұ޿����� ���� �޴�  �����
--first_name, city, salary�� ����Ͻÿ�(ANY)
--Toronto�� �����Ѵ�. 
SELECT e.first_name, l.city, e.salary
FROM employees e, departments d, locations l
WHERE e.department_id=d.department_id
     AND   d.location_id=l.location_id
     AND e.salary  >ANY  (
                                            SELECT e.salary
                                            FROM employees e, departments d, locations l
                                            WHERE e.department_id=d.department_id
                                            AND   d.location_id=l.location_id
                                            AND l.city='Toronto'
                                           )
     AND l.city <> 'Toronto';

/*-----------------------------------------------------
 ������� ��������
 : ������������ ���������� �÷��� �����Ѵ�.(���������� ���������Ѵ�.)
   ���������� �������� ������ �࿡ ���ؼ� ���������� �ѹ��� �����Ѵ�.
 <�Ʒ� ���� ó������>
 1st : �ٱ��� ������ ù° row�� ���Ͽ� 
 2nd : ���� �������� �ڽ��� �����ִ� �μ��� MAX salary��
       ���Ͽ� true �̸� �ٱ��� �÷����� ��ȯ�ϰ� , 
       false �̸� ���� ������. 
 3rd : �ٱ��� ������ �� ��° row�� ���Ͽ� ���������� �����ϸ�, 
       �̷��� �ٱ��� ������ ������ row���� �����Ѵ�. 
	   
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	   
----------------------------------------------------*/
--����� �ִ� �μ��� ����Ͻÿ�.
SELECT department_id, department_name
FROM departments;

-- �������� �������� : ������������ ���������� �÷��� �������� ����
SELECT department_id, department_name
FROM departments
WHERE department_id IN (
                                                 SELECT department_id
                                                 FROM employees
                                                 WHERE department_id IS NOT NULL
                                                 GROUP BY department_id
                                             );

-- ������� �������� : ������������ ���������� �÷��� ������
-- EXISTS �������� �۵����
     ��EXISTS�� �������� ����� 1���̶� �����ϴ����� üũ�մϴ�.
     ����� ��ȯ��(���⼱ SELECT 1)�� �߿����� �ʽ��ϴ�.
     �� ���ɻ� ������ ���� �� ������ �����ϴ� ù ��° ���� ã�� ��� ����
  SELECT department_id, department_name
  FROM departments d
   WHERE  EXISTS (
                                    SELECT  1
                                    FROM employees
                                    WHERE department_id   = d.department_id                                      
                                      )
   ORDER BY department_id;     
 
 /*
 1. FROM departments d
    |
   ��
2. �� �μ� d�� ���� ���� �������� ����:
     EXISTS (
        SELECT 1
        FROM employees e
        WHERE e.department_id = d.department_id
     )
   �� �μ��� ���� ������ ������ TRUE
    |
   ��
3. WHERE ���� �����ϴ� �μ��� ����
    |
   ��
4. SELECT department_id, department_name ���
    |
   ��
5.  ORDER BY department_id;   ���
 */

--����� ���� �μ��� ����Ͻÿ�.
 SELECT department_id, department_name
  FROM departments d
   WHERE  NOT EXISTS (
                                    SELECT  1
                                    FROM employees
                                    WHERE department_id   = d.department_id                                      
                                      )
   ORDER BY department_id;    
   
   -- �μ��� �ִ� ����� ������ ����Ͻÿ�.
   SELECT  employee_id,  first_name,  department_id
   FROM employees e
   WHERE EXISTS (
                                  SELECT 1
                                  FROM departments
                                  WHERE department_id = e.department_id
                                 );

   -- �μ��� �������� ���� ����� ������ ����Ͻÿ�.
SELECT  employee_id,  first_name,  department_id
   FROM employees e
   WHERE  NOT EXISTS (
                                  SELECT 1
                                  FROM departments
                                  WHERE department_id = e.department_id
                                 );

--�����ڰ� �ִ� ����� ������ ����Ͻÿ�.
SELECT  employee_id,  first_name,  department_id
FROM employees w
WHERE EXISTS (
                              SELECT  1
                              FROM employees m
                              WHERE  m.employee_id=w.manager_id                              
                              );


  --�����ڰ�  ����  ����� ������ ����Ͻÿ�. 
  SELECT  employee_id,  first_name,  department_id
FROM employees w
WHERE NOT EXISTS (
                              SELECT  1
                              FROM employees m
                              WHERE  m.employee_id=w.manager_id                              
                              );
 
 
/*=========================================================
Top-N ��������
   ������ ���� �����Ҷ� ���ȴ�.
   <, <=�����ڸ� ����Ҽ� �ִ�. �� �񱳵Ǵ� ���� 1�϶��� =�� �����ϴ�.
   order by���� ����� �� �ִ�.
=========================================================*/    
--�޿��� ���� ���� ���� 3���� �˻��Ͻÿ�.

SELECT rownum, emp.first_name, emp.salary
FROM (
                SELECT first_name, salary       /*  inline view(�ζ��κ�)  */
                FROM employees
                ORDER BY salary DESC
               )emp
WHERE rownum <=3;       /* rownum�� select�� ��¼����̴�. */



SELECT rownum, emp.*
FROM (
                SELECT first_name, salary      
                FROM employees
                ORDER BY salary DESC
               )emp
WHERE rownum <=3;

--�޿��� ���� ���� ���� 4������ 8������ �˻��Ͻÿ�.
SELECT trow.*
FROM ( 
                SELECT rownum AS rm, emp.*
                FROM (
                                SELECT first_name, salary      
                                FROM employees
                                ORDER BY salary DESC
                               )emp
            )trow
WHERE   trow.rm >= 4 AND trow.rm <= 8;

--�� �� �Ի��� ���� ��ȸ�ϵ� �Ի��ڼ��� ���� ���� ���� 3���� ��µǵ��� �Ͻÿ�.
--  <���:   ��     �Ի��ڼ� >               
 
SELECT  emp.*
FROM (
                SELECT   to_char(hire_date, 'mm') , count(*)
                FROM employees
                GROUP BY to_char(hire_date, 'mm')
                ORDER BY count(*) DESC
                )emp
WHERE rownum <=3;
                
--�޿��� ���� 5~10������ �����(first_name), �Ի���(hire_date),
--�޿�(salary)�� ����Ͻÿ�.(Top-N)
SELECT trow.*
FROM(SELECT rownum AS rm, emp.*
     FROM(SELECT first_name,hire_date, salary
         FROM employees
         ORDER BY salary DESC
         )emp
      )trow
WHERE trow.rm >=5 AND trow.rm <=10;                
/*-----------------------------------------------------------
       ����
 -------------------------------------------------------------*/
--1) department_id�� 60�� �μ��� ���ø��� �˾Ƴ��� SELECT������ ����Ͻÿ�
SELECT city
FROM locations
WHERE location_id = ( SELECT location_id
                      FROM departments
                      WHERE department_id=60);

    
--2)����� 107�� ����� �μ�������,167���� �޿����� ���� ������� ���,�̸�(first_name),�޿��� ����Ͻÿ�.
SELECT employee_id, first_name, salary
FROM employees
WHERE department_id = (SELECT  department_id
                       FROM employees
                       WHERE employee_id = 107)
 AND salary > (SELECT salary
              FROM employees
              WHERE employee_id = 167);
--WHERE department_id=60
-- AND salary > 6200;
                  
--3) �޿���պ��� �޿��� ���Թ޴� ������� Ŀ�̼��� �޴� ������� ���,�̸�(first_name),�޿�,Ŀ�̼� �ۼ�Ʈ�� ����Ͻÿ�.
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE salary < (SELECT avg(salary)
                FROM employees)
  AND  commission_pct IS NOT NULL;                

--4)�� �μ��� �ּұ޿��� 20�� �μ��� �ּұ޿����� ���� �μ��� ��ȣ�� �� �μ��� �ּұ޿��� ����Ͻÿ�.
SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
HAVING min(salary) > (SELECT min(salary)
                      FROM employees
                      GROUP BY department_id
                      HAVING department_id = 20)
--HAVING min(salary) >ANY ( SELECT salary
--                          FROM employees
--                          WHERE department_id = 20)
ORDER BY  department_id;
 
  
--5) �����ȣ�� 177�� ����� ��� ������ ���� ����� ����̸�(first_name)�� ������(job_id)�Ͻÿ�.   
SELECT first_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 177);
 
--6) �ּ� �޿��� �޴� ����� �̸�(first_name), ��� ����(job_id) �� �޿�(salary)�� ǥ���Ͻÿ�(�׷��Լ� ���).
SELECT first_name, job_id, salary
FROM employees
WHERE salary = (SELECT min(salary)
                FROM employees);
				
--7)������ ��� �޿��� ���� ����  ����(job_id)�� ã�� ����(job_id)�� ��� �޿��� ǥ���Ͻÿ�.
SELECT job_id, avg(salary)
FROM employees
GROUP BY job_id
HAVING avg(salary) = (SELECT min(avg(salary))
                      FROM employees
                      GROUP BY job_id);

					  
--8) �� �μ��� �ּ� �޿��� �޴� ����� �̸�(first_name), �޿�(salary), �μ���ȣ(department_id)�� ǥ���Ͻÿ�.
SELECT first_name, salary, department_id
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, min(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY department_id;


SELECT first_name, salary, department_id
FROM employees e1
WHERE  salary = (SELECT  min(salary)
                 FROM employees e2
                 WHERE e1.department_id=e2.department_id)
ORDER BY department_id;

--9)��� ������ ���α׷���(IT_PROG)�� ��� ������� �޿��� �����鼭 
--������ ���α׷���(IT_PROG)�� �ƴ�  ������� �����ȣ(employee_id), �̸�(first_name), 
--��� ����(job_id), �޿�(salary))�� ����Ͻÿ�.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE salary <ALL (SELECT salary
                   FROM employees
                   WHERE job_id = 'IT_PROG')
 AND job_id <> 'IT_PROG';                  

--10)���������� ���� ��� ����� �̸��� ǥ���Ͻÿ�.
SELECT employee_id, first_name
FROM employees
WHERE employee_id NOT IN (SELECT e.employee_id
                          FROM employees e, employees m
                          WHERE e.employee_id=m.manager_id)
ORDER BY employee_id;


SELECT employee_id, first_name
FROM employees e
WHERE NOT EXISTS (SELECT employee_id
                  FROM employees m
                  WHERE m.manager_id = e.employee_id)
ORDER BY employee_id;
 
  
               