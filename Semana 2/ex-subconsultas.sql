--Exercicios Subconsultas

--Ex01: Consultar o primeiro nome, sobrenome e data de contratação dos empregados que trabalham no mesmo departamento que o empregado com sobrenome Zlotkey (excluindo ele próprio).

Select first_name, last_name, hire_date
FROM employees
WHERE department_id =
        (SELECT department_id
         FROM employees
         WHERE last_name = 'Zlotkey')
AND last_name <> 'Zlotkey';
         
--EX02: Consultar o primeiro nome, sobrenome e data de contratação dos empregados que foram contratados depois do empregado com sobrenome Davies.

Select first_name, last_name, hire_date
FROM employees
WHERE hire_date >
        (SELECT hire_date
         FROM employees
         WHERE last_name = 'Davies')
AND last_name <> 'Davies'
ORDER BY hire_date;

--EX03: Consultar os sobrenomes dos empregados que são gerentes de departamento.
SELECT last_name
FROM employees
WHERE employee_id IN
        (SELECT manager_id
         FROM departments)
         
--EX04: Consultar o sobrenome e o id do cargo dos empregados que não trabalham em departamentos que contêm a palavra ‘sales’ no nome do departamento
SELECT last_name, job_id
FROM employees
WHERE department_id NOT IN
        (SELECT department_id
         FROM departments
         WHERE department_name like '%Sales%');
         
--EX05: Consultar o sobrenome e o salário dos empregados cujo salário é menor que o salário de algum empregado com id de cargo ‘ST_MAN’.
SELECT last_name, salary
FROM employees
WHERE salary < ANY
        (SELECT salary
         FROM employees
         WHERE job_id = 'ST_MAN')
ORDER BY salary;

-- EX06: Consultar o sobrenome e o salário dos empregados cujo salário é maior que o salário de todos os empregados do departamento com id = 50.
SELECT last_name, salary
FROM employees
WHERE salary > ALL
        (SELECT salary
         FROM employees
         WHERE department_id = 50)
ORDER BY salary;

--EX07: Consultar o primeiro nome, sobrenome e salário dos empregados que possuem o mesmo cargo que o empregado com sobrenome Zlotkey e ganham salário maior que ele
SELECT first_name, last_name, salary
FROM employees
WHERE job_id =
        (SELECT job_id
         FROM employees
         WHERE last_name = 'Zlotkey')
AND salary > 
        (SELECT salary
         FROM employees
         WHERE last_name = 'Zlotkey');
         
--EX08: Consultar id de países que possuem departamentos da empresa.
SELECT country_id
FROM countries
WHERE country_id IN
        (SELECT l.country_id
         FROM departments d, locations l
         WHERE d.location_id = l.location_id);
         
--EX09: Quais são os nomes dos departamentos que estão na cidade Seattle?

SELECT department_name
FROM departments
WHERE location_id IN
        (SELECT location_id
         FROM locations
         WHERE city = 'Seattle');

--EX10: Crie uma consulta para retornar todos os funcionários que têm um salário superior ao de Lorentz e que sejam do mesmo departamento que Abel.
SELECT first_name,last_name
FROM employees
WHERE salary >
        (SELECT salary
         FROM employees
         WHERE last_name = 'Lorentz')
AND department_id =
        (SELECT department_id
         FROM employees
         WHERE last_name = 'Abel');
         
--EX11: Crie uma consulta para retornar todos os funcionários que têm o mesmo id de cargo que Rajs e que foram contratados depois de Davies.
SELECT first_name,last_name
FROM employees
WHERE job_id =
        (SELECT job_id
         FROM employees
         WHERE last_name = 'Rajs')
AND hire_date >
        (SELECT hire_date
         FROM employees
         WHERE last_name = 'Davies');
         
--EX12: Encontre os sobrenomes de todos os funcionários cujos salários são iguais ao salário mínimo de qualquer departamento.
SELECT last_name, job_id,salary
FROM employees
WHERE salary = ANY
        (SELECT min_salary
         FROM jobs);
         
--EX13: Quais funcionários têm salários inferiores aos dos programadores do departamento de TI?
SELECT last_name, job_id,salary
FROM employees
WHERE salary < ALL
        (SELECT salary
         FROM employees
         WHERE job_id = 'IT_PROG');

--EX14: Liste last_name, first_name, department_id e manager_id de todos os funcionários que têm o mesmo department_id e manager_id que o funcionário 141. Exclua o funcionário 141 do conjunto de resultados.
SELECT last_name, first_name, department_id, manager_id
FROM employees
WHERE department_id = ALL
        (SELECT department_id
         FROM employees
         WHERE employee_id = 141)
AND manager_id = ALL
        (SELECT manager_id
         FROM employees
         WHERE employee_id = 141)
AND employee_id <> 141;
























