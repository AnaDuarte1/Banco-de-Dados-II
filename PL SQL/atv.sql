-- Exercicio 1:
SET SERVEROUTPUT ON;

DECLARE
    v_employee_id employees.employee_id%TYPE := 100; 
    v_first_name  employees.first_name%TYPE;
    v_last_name   employees.last_name%TYPE;
    v_hire_date   employees.hire_date%TYPE;

    v_anos_empresa NUMBER;
    v_nivel        VARCHAR2(20);
BEGIN
    SELECT first_name, last_name, hire_date
    INTO v_first_name, v_last_name, v_hire_date 
    FROM employees
    WHERE employee_id = v_employee_id;

    --(MONTHS_BETWEEN/12)
    v_anos_empresa := MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12;

    IF v_anos_empresa > 15 THEN
        v_nivel := 'Sênior';
    ELSIF v_anos_empresa >= 5 THEN
        v_nivel := 'Pleno';
    ELSE
        v_nivel := 'Júnior';
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- Análise de Nível de Experiência ---');
    DBMS_OUTPUT.PUT_LINE('Empregado: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Tempo de Empresa (Anos): ' || ROUND(v_anos_empresa, 2));
    DBMS_OUTPUT.PUT_LINE('Nível Determinado: ' || v_nivel);

EXCEPTION
    -- Tratamento de erro caso o ID não seja encontrado
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Empregado com ID ' || v_employee_id || ' não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro inesperado: ' || SQLERRM);
END;
/

-- Exercicio 2:
SET SERVEROUTPUT ON;

DECLARE
    v_employee_id employees.employee_id%TYPE := &id_do_empregado_para_bonus;

    v_first_name     employees.first_name%TYPE;
    v_last_name      employees.last_name%TYPE;
    v_hire_date      employees.hire_date%TYPE;
    v_salary         employees.salary%TYPE;

    c_bonus_por_ano CONSTANT NUMBER := 50.00;

    v_anos_totais    NUMBER;
    v_anos_completos INTEGER; 
    v_valor_bonus    NUMBER;
BEGIN
    SELECT first_name, last_name, hire_date, salary
    INTO v_first_name, v_last_name, v_hire_date, v_salary
    FROM employees
    WHERE employee_id = v_employee_id;

  
    -- MONTHS_BETWEEN(SYSDATE, hire_date)/12
    v_anos_totais := MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12;

    -- TRUNC (função SQL) é usada para remover a parte decimal, considerando apenas anos completos.
    v_anos_completos := TRUNC(v_anos_totais);

    -- 4. Calcular o valor do bônus
    v_valor_bonus := v_anos_completos * c_bonus_por_ano;

    DBMS_OUTPUT.PUT_LINE('--- Relatório de Bônus ---');
    DBMS_OUTPUT.PUT_LINE('ID do Empregado: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Nome Completo: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('Data de Contratação: ' || TO_CHAR(v_hire_date, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Anos Completos Trabalhados: ' || v_anos_completos);
    DBMS_OUTPUT.PUT_LINE('Salário Atual: R$' || TO_CHAR(v_salary, 'FM99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Valor do Bônus: R$' || TO_CHAR(v_valor_bonus, 'FM99,999.00'));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Empregado com ID ' || v_employee_id || ' não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro inesperado: ' || SQLERRM);
END;
/
