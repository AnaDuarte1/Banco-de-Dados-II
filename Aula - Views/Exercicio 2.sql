--1)Criar uma view EMP_ST_CLERK que contenha dados dos empregados com função ‘ST_CLERK’

CREATE VIEW EMP_ST_CLERK AS
SELECT employee_id, last_name, email, hire_date, job_id
FROM employees
WHERE job_id = 'ST_CLERK';

--2)Criar (ou alterar) a view de modo que não seja possível alterar seu conteúdo com funções de
--empregado diferentes de ‘ST_CLERK’

CREATE OR REPLACE VIEW EMP_ST_CLERK AS
SELECT employee_id, last_name, email, hire_date, job_id
FROM employees
WHERE job_id = 'ST_CLERK'
WITH CHECK OPTION;

--3)Adicione um novo empregado na view EMP_ST_CLERK, com a função ‘ST_CLERK

INSERT INTO EMP_ST_CLERK (employee_id, last_name, email, hire_date, job_id)
VALUES (555, 'ANA', 'anaberocha@mail.com', sysdate, 'ST_CLERK');

--4)Explique o que aconteceu na tabela Employees:
-- R: A operação INSERT foi bem-sucedida. Como EMP_ST_CLERK é uma view simples, o comando foi repassado para a tabela employees, e um novo registro foi adicionado a ela.

--5)Atualize EMP_ST_CLERK de modo que o empregado adicionado tenha a função ‘IT_PROG

UPDATE EMP_ST_CLERK
SET    job_id = 'IT_PROG'
WHERE  employee_id = 999;

--6)Explique o que aconteceu: 
-- R: A operação de UPDATE falhou. A cláusula WITH CHECK OPTION impediu a alteração, pois o novo job_id ('IT_PROG') não satisfaz a condição da view (job_id = 'ST_CLERK').
-- O banco de dados retornou um erro de violação da cláusula CHECK OPTION.

--7)Remova da view o empregado adicionado anteriormente

DELETE FROM EMP_ST_CLERK
WHERE employee_id = 999;

--8)Explique o que aconteceu na tabela Employees:
-- R: A operação DELETE foi bem-sucedida. O comando foi repassado para a tabela employees, e o registro do empregado foi permanentemente removido dela.

--9)Criar uma visão DEPT_MAN_VIEW que contenha dados dos gerentes de departamento

CREATE VIEW DEPT_MAN_VIEW AS
SELECT
    m.last_name AS "Nome do Gerente",
    j.job_title AS "Título da Função",
    (m.salary * 12) AS "Salário Anual",
    d.department_name AS "Nome do Departamento",
    l.city AS "Cidade"
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN jobs j ON m.job_id = j.job_id
JOIN locations l ON d.location_id = l.location_id;

--10)É possível atualizar DEPT_MAN_VIEW? Justifique.
-- R: Não. A view não é atualizável porque é construída sobre uma junção (JOIN) de múltiplas tabelas. 
--O banco de dados não consegue determinar de forma inequívoca qual tabela de base deve ser modificada, gerando ambiguidade.

--11)Criar uma visão DEPT_JOB_VIEW que contenha uma relação da quantidade de empregados
--por função e por nome de departamento

CREATE VIEW DEPT_JOB_VIEW AS
SELECT
    d.department_name AS "Nome do Departamento",
    j.job_title AS "Nome da Função",
    COUNT(e.employee_id) AS "Quantidade de Empregados"
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
GROUP BY
    d.department_name,
    j.job_title
ORDER BY
    d.department_name,
    j.job_title;

--12)É possível atualizar DEPT_JOB_VIEW? Justifique.
-- R: Não. A view não é atualizável por conter junções (JOINs), uma função de grupo (COUNT) e uma cláusula GROUP BY. 
--As linhas da view representam dados agregados, e não linhas individuais de uma tabela, tornando as operações DML logicamente impossíveis.
