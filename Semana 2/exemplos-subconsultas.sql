-- Subconsultas

-- EX01
SELECT last_name, salary
FROM employees
WHERE salary >
    (SELECT salary
        FROM employees
        WHERE last_name = 'Gates');
        
-- EX02       
SELECT first_name, last_name, salary
FROM employees
WHERE job_id =
    (SELECT job_id
    FROM employees
    WHERE last_name = 'Abel')
AND salary >
    (SELECT salary
    FROM employees
    WHERE last_name = 'Chen');

-- EX03 - Dá erro porque retorna mais de uma função IT_PROG
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY =
    (SELECT SALARY
    FROM EMPLOYEES
    WHERE JOB_ID = 'IT_PROG');
    
--EX04 - IN (Está em...)
--Recuperar os sobrenomes dos empregados que ganham os mesmos salários que os dos empregados com função IT_PROG
SELECT last_name, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary IN 
    (SELECT salary
    FROM employees
    WHERE job_id = 'IT_PROG');
    
--EX05 - NOT IN (Não está em...)
--Recuperar os sobrenomes dos empregados que ganham salários diferentes dos salários dos empregados com função IT_PROG
SELECT last_name, salary
FROM employees
WHERE salary NOT IN
    (SELECT salary
    FROM employees
    WHERE job_id = 'IT_PROG');
    
--EX06 - ANY (Precisa só que um retorne TRUE)
-- Recuperar os sobrenomes dos empregados que ganham salários menores que o salário de ALGUM empregado com função IT_PROG
SELECT last_name, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY
    (SELECT salary
    FROM employees
    WHERE job_id = 'IT_PROG');
    
--ex07 - ALL (Precisa que TODOS retornem TRUE)
--Recuperar os sobrenomes dos empregados que ganham salários menores que TODOS os salários dos empregados com função IT_PROG
SELECT last_name, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ALL
    (SELECT salary
    FROM employees
    WHERE job_id = 'IT_PROG');