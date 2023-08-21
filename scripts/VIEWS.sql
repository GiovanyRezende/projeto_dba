-- Views dos clientes
CREATE VIEW vw_dados_clientes_juridicos AS
SELECT
    c.id AS cliente_id,
    c.nome_fantasia AS nome_fantasia,
    c.razao_social AS razao_social,
    c.cnpj AS cnpj,
    c.email AS email,
    c.status AS status,
    e.endereco AS endereco,
    IFNULL(t.numero,'N/A') AS telefone
FROM tb_cliente_juridico AS c
INNER JOIN tb_endereco AS e ON c.id = e.id_juridico
LEFT JOIN tb_telefone AS t ON c.id = t.id_juridico;

CREATE VIEW vw_dados_clientes_fisicos AS
SELECT
    f.id AS cliente_id,
    f.nome AS nome,
    f.sobrenome AS sobrenome,
    f.cpf AS cpf,
    f.email AS email,
    f.dt_nasc AS data_nascimento,
    f.status AS status,
    f.filiacao AS filiacao,   
    e.endereco AS endereco,
    IFNULL(t.numero,'N/A') AS telefone
FROM tb_cliente_fisico AS f
INNER JOIN tb_endereco AS e ON f.id_endereco = e.id
LEFT JOIN tb_cliente_telefone AS ct ON f.id = ct.id_cliente
LEFT JOIN tb_telefone AS t ON ct.id_telefone = t.id;

-- Views das transações
CREATE VIEW vw_transacoes_clientes_juridicos AS
SELECT
    c.nome_fantasia AS nome_fantasia, 
    c.cnpj AS cnpj,
    t.valor AS valor_transacao,
    tt.descricao AS tipo_transacao
FROM tb_cliente_juridico AS c
INNER JOIN tb_conta AS co ON c.id = co.id_juridico
INNER JOIN tb_transacao AS t ON co.id = t.conta_saida
INNER JOIN tb_tipo_transacao AS tt ON t.id_tipo = tt.id;

CREATE VIEW vw_transacoes_clientes_fisicos AS
SELECT
    f.nome  AS nome,
    f.cpf AS cpf,
    t.valor AS valor_transacao,
    tt.descricao AS tipo_transacao
FROM tb_cliente_fisico AS f
INNER JOIN tb_conta AS co ON f.id = co.id_fisico
INNER JOIN tb_transacao AS t ON co.id = t.conta_saida
INNER JOIN tb_tipo_transacao AS tt ON t.id_tipo = tt.id;