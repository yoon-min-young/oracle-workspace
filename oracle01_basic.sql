-- Ctrl + Enter :����

SELECT * FROM tab;  

-- ���� > ȯ�漳�� > �ڵ������� > �۲� > ũ������
SELECT * FROM locations;
select * from locations;

/*
 �÷���, ���̺� ��Ī(alias)�� ������ �� �ִ�.
��Ī(alias)�� ������ �������� " "(����ǥ)�� �����Ѵ�.
*/

SELECT salary, salary*10 AS bonus
FROM employees;


SELECT salary, salary*10 AS ���ʽ�
FROM employees;


SELECT salary, salary*10 AS "b o n u  s"
FROM employees;


SELECT last_name || '���� �޿��� ' || salary || '�Դϴ�.' AS name
FROM employees;

-- DISTINCT�� �ߺ����Ÿ� �� �� ����� �ִ� ��ɾ��̴�.
SELECT DISTINCT first_name
FROM employees;

SELECT DISTINCT first_name, last_name
FROM employees;
/*
first_name last_name
sundar     Abel
sundar     Abel
sundar     Ande
*/

-- SELECT �Է¼���
/*
SELECT column_name1, column_name2
FROM table_name
WHERE column_name='value'
GROUP By column_name
HAVING column_name='value'
ORDER BY column_name ASC(DESC);
*/

-- SELECT �ؼ����� 
/*
FROM table_name
WHERE column_name='value'
GROUP By column_name
HAVING column_name='value'
SELECT column_name1, column_name2
ORDER BY column_name ASC(DESC);
*/

--employees���̺��� salary�� 3000�̸��϶���
--first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE salary < 3000;

--employees���̺��� first_name�÷��� ���� 'David' �϶���
--first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name = 'David';

--employees���̺��� first_name�÷��� ���� 'David' �ƴҶ���
--first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name != 'David';

SELECT first_name, salary
FROM employees
WHERE first_name <> 'David';

--&&(and), ||(or)
--employees���̺��� salary�� 3000, 9000, 17000�϶�
--first_name, hire_date, salary�� ����϶�.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary IN(3000, 9000, 17000);


