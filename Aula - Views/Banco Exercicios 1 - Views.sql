-- 2. Crie uma view simples chamada view_d_songs que contenha o ID, o título e o 
-- artista da tabela da DJs on Demand para cada código do tipo “New Age”. Na subconsulta, use o alias “Song Title” para o título da coluna.

CREATE VIEW view_d_songs AS
SELECT id, title AS "Song Title", artist
FROM d_songs
WHERE type_code = 'New Age';


-- 4. REPLACE view_d_songs. Adicione type_code à lista de colunas. Use aliases para todas as colunas.

CREATE OR REPLACE VIEW view_d_songs (ID_DA_MUSICA, TITULO_DA_MUSICA, ARTISTA, CODIGO_DO_TIPO) AS
SELECT id, title, artist, type_code
FROM d_songs
WHERE type_code = 'New Age';

-- 5. Jason Tsang, o DJ da DJs on Demand, precisa de uma lista dos eventos passados e dos planejados para 
--os próximos meses a fim de que possa tomar as providências necessárias para a preparação do equipamento de cada evento. 
--Como gerente da empresa, você não quer que ele tenha acesso ao preço que os clientes pagaram pelos eventos. 
--Crie uma view para ser usada por Jason que exiba o nome e a data do evento e a descrição do tema. Use aliases para cada nome de coluna.

CREATE VIEW view_agenda_eventos_dj AS
SELECT
    event_name AS "Nome do Evento",
    event_date AS "Data do Evento",
    theme_description AS "Descrição do Tema"
FROM d_events;

-- 6. Segundo a política da empresa, somente a alta gerência tem permissão de acessar os salários de cada funcionário. 
--Entretanto, os gerentes dos departamentos precisam saber os salários mínimo, máximo e a média salarial, agrupados por departamento. 
-- Use o banco de dados Oracle a fim de preparar uma view que exiba as informações necessárias para esses gerentes.

CREATE VIEW view_salarios_por_departamento AS
SELECT
    d.department_name AS "Departamento",
    MIN(e.salary) AS "Salário Mínimo",
    MAX(e.salary) AS "Salário Máximo",
    ROUND(AVG(e.salary), 2) AS "Média Salarial"
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


