CREATE DATABASE IF NOT EXISTS db_fintech
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_fintech;

CREATE TABLE IF NOT EXISTS tb_cliente_juridico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_fantasia VARCHAR(255) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    email VARCHAR(255) NOT NULL,
    status VARCHAR(7) NOT NULL,
    CONSTRAINT uq_cnpj_cliente_juridico UNIQUE (cnpj)
);

CREATE TABLE IF NOT EXISTS tb_endereco (
    id INT PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(255) NOT NULL,
    id_juridico INT,
    CONSTRAINT fk_id_juridico_cliente_juridico FOREIGN KEY (id_juridico) REFERENCES tb_cliente_juridico (id)
);

CREATE TABLE IF NOT EXISTS tb_tipo_conta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_tipo_transacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_tipo_telefone (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_cliente_fisico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(14) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    dt_nasc DATE NOT NULL,
    status VARCHAR(7) NOT NULL,
    filiacao VARCHAR(255) NOT NULL,
    id_endereco INT NOT NULL,
    CONSTRAINT uq_cpf_cliente_fisico UNIQUE (cpf),
    CONSTRAINT fk_id_endereco_cliente_fisico FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id)
);

CREATE TABLE IF NOT EXISTS tb_telefone (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ddd INT(2),
    numero INT(9) NOT NULL,
    id_tipo INT NOT NULL,
    id_juridico INT,
    CONSTRAINT fk_id_tipo_telefone FOREIGN KEY (id_tipo) REFERENCES tb_tipo_telefone (id),
    CONSTRAINT fk_id_juridico_telefone FOREIGN KEY (id_juridico) REFERENCES tb_cliente_juridico (id)
);

CREATE TABLE IF NOT EXISTS tb_cliente_telefone (
    id_cliente INT,
    id_telefone INT,
    PRIMARY KEY (id_cliente, id_telefone),
    CONSTRAINT fk_id_cliente_cliente_telefone FOREIGN KEY (id_cliente) REFERENCES tb_cliente_fisico (id),
    CONSTRAINT fk_id_telefone_cliente_telefone FOREIGN KEY (id_telefone) REFERENCES tb_telefone (id)
);

CREATE TABLE IF NOT EXISTS tb_conta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10) NOT NULL,
    agencia VARCHAR(4) NOT NULL,
    saldo FLOAT(10,2) NOT NULL,
    status VARCHAR(7) NOT NULL,
    id_tipo INT NOT NULL,
    id_fisico INT,
    id_juridico INT,
    CONSTRAINT fk_id_tipo_conta FOREIGN KEY (id_tipo) REFERENCES tb_tipo_conta (id),
    CONSTRAINT fk_id_fisico_conta FOREIGN KEY (id_fisico) REFERENCES tb_cliente_fisico (id),
    CONSTRAINT fk_id_juridico_conta FOREIGN KEY (id_juridico) REFERENCES tb_cliente_juridico (id)
);

CREATE TABLE IF NOT EXISTS tb_transacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    valor FLOAT(10,2) NOT NULL,
    conta_saida INT NOT NULL,
    conta_destino INT NOT NULL,
    data DATE NOT NULL,
    id_tipo INT NOT NULL,
    CONSTRAINT fk_id_tipo_transacao FOREIGN KEY (id_tipo) REFERENCES tb_tipo_transacao (id),
    CONSTRAINT fk_conta_saida_transacao FOREIGN KEY (conta_saida) REFERENCES tb_conta (id),
    CONSTRAINT fk_conta_destino_transacao FOREIGN KEY (conta_destino) REFERENCES tb_conta (id)
);