-- CRIAÇÃO DAS TABELAS

-- Tabela para armazenar as informações de cada concurso

CREATE TABLE Concursos (
    ID INT PRIMARY KEY,
    NumeroConcurso INT NOT NULL UNIQUE,
    DataSorteio DATE NOT NULL
);

-- Tabela para armazenar os 6 números sorteados de cada concurso
CREATE TABLE NumerosSorteados (
    ConcursoID INT,
    Numero INT NOT NULL,
    CONSTRAINT pk_numeros_sorteados PRIMARY KEY (ConcursoID, Numero),
    CONSTRAINT fk_concursos FOREIGN KEY (ConcursoID) REFERENCES Concursos(ID)
);


-- INSERÇÃO DE DADOS PARA TESTE

-- Inserindo alguns resultados fictícios/reais para popular o banco.

-- Concurso 1 (Exemplo 1)
INSERT INTO Concursos (ID, NumeroConcurso, DataSorteio) VALUES (1, 2700, TO_DATE('2025-03-15', 'YYYY-MM-DD'));
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (1, 4);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (1, 10);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (1, 15);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (1, 25);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (1, 33);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (1, 42);

-- Concurso 2 (Exemplo 2 - Mês de Março)
INSERT INTO Concursos (ID, NumeroConcurso, DataSorteio) VALUES (2, 2701, TO_DATE('2025-03-22', 'YYYY-MM-DD'));
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (2, 5);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (2, 10);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (2, 22);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (2, 25);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (2, 48);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (2, 59);

-- Concurso 3 (Exemplo 3 - Mês de Abril)
INSERT INTO Concursos (ID, NumeroConcurso, DataSorteio) VALUES (3, 2702, TO_DATE('2025-04-05', 'YYYY-MM-DD'));
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (3, 7);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (3, 11);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (3, 18);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (3, 35);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (3, 42);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (3, 51);

-- Concurso 4 (Exemplo 4 - Jogo que será verificado na Consulta 5)
INSERT INTO Concursos (ID, NumeroConcurso, DataSorteio) VALUES (4, 2703, TO_DATE('2025-04-12', 'YYYY-MM-DD'));
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (4, 8);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (4, 17);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (4, 29);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (4, 38);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (4, 53);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (4, 60);

-- Concurso 5 (Exemplo 5 - Para ter mais dados de frequência)
INSERT INTO Concursos (ID, NumeroConcurso, DataSorteio) VALUES (5, 2704, TO_DATE('2025-05-19', 'YYYY-MM-DD'));
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (5, 10);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (5, 15);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (5, 25);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (5, 41);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (5, 42);
INSERT INTO NumerosSorteados (ConcursoID, Numero) VALUES (5, 58);


-- 4. CONSULTAS (SELECT) RELEVANTES

-- CONSULTA 1:
-- Dado um número, indicar qual a frequência com que os outros números aparecem
-- associados a ele nos sorteios anteriores.

SELECT
    ns2.Numero AS NumeroAssociado,
    COUNT(*) AS Frequencia
FROM
    NumerosSorteados ns1
JOIN
    NumerosSorteados ns2 ON ns1.ConcursoID = ns2.ConcursoID
WHERE
    ns1.Numero = 10  -- << Altere o número desejado aqui
    AND ns1.Numero <> ns2.Numero -- Garante que não estamos contando o próprio número
GROUP BY
    ns2.Numero
ORDER BY
    Frequencia DESC;


-- CONSULTA 2:
-- Dado um mês, indicar os números que mais aparecem em sorteios anteriores
-- nesse mês, independente do dia e ano do sorteio.

SELECT
    ns.Numero,
    COUNT(ns.Numero) AS Frequencia
FROM
    NumerosSorteados ns
JOIN
    Concursos c ON ns.ConcursoID = c.ID
WHERE
    EXTRACT(MONTH FROM c.DataSorteio) = 3 -- << Altere o mês desejado aqui (1 a 12)
GROUP BY
    ns.Numero
ORDER BY
    Frequencia DESC;


-- CONSULTA 3:
-- Dado o número 25, mostre a frequência dentro de um período de 6 meses de
-- jogos anteriores.


SELECT
    COUNT(*) AS FrequenciaDoNumero25
FROM
    NumerosSorteados ns
JOIN
    Concursos c ON ns.ConcursoID = c.ID
WHERE
    ns.Numero = 25 
    AND c.DataSorteio >= ADD_MONTHS(SYSDATE, -6);

-- CONSULTA 4:
-- Consultar os 6 números que menos apareceram nos resultados anteriores.


SELECT
    Numero,
    COUNT(Numero) AS Frequencia
FROM
    NumerosSorteados
GROUP BY
    Numero
ORDER BY
    Frequencia ASC
FETCH FIRST 6 ROWS ONLY; 


-- CONSULTA 5:
-- Dado 6 números, consultar se esses números já foram sorteados.


SELECT
    c.NumeroConcurso,
    c.DataSorteio,
    'Sim, esta combinação já foi sorteada!' AS Resultado
FROM
    NumerosSorteados ns
JOIN
    Concursos c ON ns.ConcursoID = c.ID
WHERE
    ns.Numero IN (8, 17, 29, 38, 53, 60) 
GROUP BY
    c.NumeroConcurso, c.DataSorteio
HAVING
    COUNT(ns.Numero) = 6; 


