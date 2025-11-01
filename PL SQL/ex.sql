SET SERVEROUTPUT ON
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello world!');
END;
/
 -- Variaveis:
DECLARE
emp_hire_date DATE;
emp_dept NUMBER(4) NOT NULL := 10;
city VARCHAR2(20) := 'Araraquara';
num_const CONSTANT NUMBER := 500;
emp_job VARCHAR2(10) DEFAULT 'IT_PROG';

-- Mensagem anônima:
DECLARE
msg VARCHAR2(100) := 'Hello World 2!';
BEGIN
DBMS_OUTPUT.put_line(msg);
END;
/

-- Pede para o usuario informar algo
DECLARE
MSG VARCHAR2(100);
BEGIN
MSG := '&INPUT';
DBMS_OUTPUT.PUT_LINE('HELLO '||
MSG);
END;
/

-- Junto com SQL
SET SERVEROUTPUT ON
DECLARE
sobrenome VARCHAR2(20);
BEGIN
SELECT last_name INTO sobrenome
FROM EMPLOYEES
WHERE employee_id = 100;
DBMS_OUTPUT.PUT_LINE('O sobrenome do empregado
é ' || sobrenome);
END;


-- Exercicio 1: Escreva um bloco de programa PL/SQL que
-- descreva na tela o menor e o maior salário dos
-- empregados do departamento com id = 60

DECLARE
min_sal employees.salary%TYPE;
max_sal min_sal%TYPE;
deptno employees.department_id%TYPE := 60;
BEGIN
SELECT MIN(salary), MAX(salary)
INTO min_sal, max_sal
FROM employees
WHERE department_id = deptno;
DBMS_OUTPUT.PUT_LINE ('O menor salário do
departamento ' || deptno || ' é ' ||
min_sal || ' e o maior salário é ' || max_sal);
END;

-- Exercicio 2: Escreva um bloco de programa PL/SQL para
-- atualizar o salário dos empregados do
-- departamento com id = 50 para o mesmo
-- valor do salário médio dos empregados do departamento com id = 60

DECLARE
avg_sal employees.salary%TYPE;
BEGIN
SELECT AVG(salary)
INTO avg_sal
FROM employees
WHERE department_id = 60;
UPDATE employees
SET SALARY = avg_sal
WHERE department_id = 50;
END;
/


-- Exemplo 1: IF/ELSEIF

DECLARE
h_date employees.hire_date%TYPE;
emp_id employees.employee_id%TYPE := '&INPUT';
emp_years NUMBER;
BEGIN
SELECT hire_date INTO h_date FROM employees
WHERE employee_id = emp_id;
emp_years := MONTHS_BETWEEN(SYSDATE, h_date)/12;
IF emp_years > 10
THEN
DBMS_OUTPUT.PUT_LINE ('Empregado '|| emp_id || ' é sênior');
ELSIF emp_years > 5
THEN
DBMS_OUTPUT.PUT_LINE ('Empregado '|| emp_id || ' é pleno');
ELSE
DBMS_OUTPUT.PUT_LINE ('Empregado '|| emp_id || ' é júnior');
END IF;
END;
/

-- Exemplo 2: 

DECLARE
jobid employees.job_id%TYPE;
empid employees.employee_id%TYPE := 115;
reajuste NUMBER(3,2);
BEGIN
SELECT job_id INTO jobid from employees
WHERE employee_id = empid;
IF jobid = 'PU_CLERK' THEN
reajuste := .12;
ELSIF jobid = 'SH_CLERK' THEN
reajuste := .11;
ELSIF jobid = 'ST_CLERK' THEN
reajuste := .10;
ELSE
reajuste := .05;
END IF;
UPDATE EMPLOYEES
SET salary = salary + salary * reajuste
WHERE employee_id = empid;
END;
/

-- Case: 

DECLARE
nota CHAR(1) := UPPER('&nota');
resultado VARCHAR2(20);
BEGIN
resultado :=
CASE
WHEN nota = 'A' THEN 'Excelente'
WHEN nota = 'B' THEN 'Muito bom'
WHEN nota = 'C' THEN 'Bom'
WHEN nota IN ('D', 'E') THEN 'Reprovado'
ELSE 'Nota inválida'
END;
DBMS_OUTPUT.PUT_LINE ('Nota: '|| nota || '
Resultado: ' || resultado);
END;
/


-- Loop

DECLARE
ctry_id locations.country_id%TYPE := 'BR';
loc_id locations.location_id%TYPE;
counter NUMBER(2) := 1;
cty locations.city%TYPE := 'Araraquara';
BEGIN
SELECT MAX(location_id) INTO loc_id FROM locations
WHERE country_id = ctry_id;
LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((loc_id + counter), cty, ctry_id);
counter := counter + 1;
EXIT WHEN counter > 3;
END LOOP;
END;
/
-- While 

DECLARE
ctry_id locations.country_id%TYPE := 'BR';
loc_id locations.location_id%TYPE;
counter NUMBER(2) := 1;
cty locations.city%TYPE := 'Araraquara';
BEGIN
SELECT MAX(location_id) INTO loc_id FROM locations
WHERE country_id = ctry_id;
WHILE counter <= 3 LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((loc_id + counter), cty, ctry_id);
counter := counter + 1;
END LOOP;
END;
/
-- FOR

DECLARE
ctry_id locations.country_id%TYPE := 'BR';
loc_id locations.location_id%TYPE;
BEGIN
SELECT MAX(location_id) INTO loc_id FROM locations
WHERE country_id = ctry_id;
FOR i IN 0..5 LOOP
DELETE FROM locations
WHERE location_id = (loc_id - i);
END LOOP;
END;
/

-- Laços Aninhados 

BEGIN
<<outer_loop>>
FOR i IN 1..3 LOOP -- assign the values 1,2,3 to i
<<inner_loop>>
FOR i IN 1..3 LOOP
IF outer_loop.i = 2 THEN
DBMS_OUTPUT.PUT_LINE( 'outer: ' ||
TO_CHAR(outer_loop.i) || ' inner: ' ||
TO_CHAR(inner_loop.i));
END IF;
END LOOP inner_loop;
END LOOP outer_loop;
END;
/

-- Registros 

DECLARE
TYPE emp_tipo_registro IS RECORD
(last_name VARCHAR2(25),
job_id VARCHAR2(10),
salary NUMBER(8,2));
dados_emp emp_tipo_registro;
BEGIN
SELECT last_name, job_id, salary INTO dados_emp
FROM employees
WHERE employee_id = 100;
DBMS_OUTPUT.PUT_LINE ( 'Empregado: '|| dados_emp.last_name || '
Função: ' || dados_emp.job_id || '
Salário: ' || dados_emp.salary);
END;


-- Atributo %ROWTYPE

DECLARE
emp_rec employees%ROWTYPE;
emp_id employees.employee_id%TYPE := 100;
BEGIN
SELECT * INTO emp_rec FROM employees
WHERE employee_id = emp_id;
DBMS_OUTPUT.PUT_LINE ('Empregado: '|| emp_rec.employee_id || '
Nome: ' || emp_rec.last_name || '
Data de contratação: ' || emp_rec.hire_date || '
Salário: ' || emp_rec.salary || '
Departamento: ' || emp_rec.department_id);
END;
/