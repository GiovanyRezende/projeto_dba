-- Trigger para verificar se o cliente físico já tem um conta corrente e/ou uma poupança
DELIMITER //
CREATE TRIGGER tr_verificacao_n_de_contas
BEFORE INSERT
ON tb_conta
FOR EACH ROW
BEGIN
    DECLARE numero_fisico_poupanca INT;
    DECLARE numero_fisico_corrente INT;

    SET numero_fisico_poupanca = (SELECT COUNT(co.id) 
                                  FROM tb_conta AS co
                                  INNER JOIN tb_tipo_conta AS t ON t.id = co.id_tipo
                                  WHERE t.tipo = 'POUPANCA' AND co.id_fisico = NEW.id_fisico);

    SET numero_fisico_corrente = (SELECT COUNT(co.id) 
                                  FROM tb_conta AS co
                                  INNER JOIN tb_tipo_conta AS t ON t.id = co.id_tipo
                                  WHERE t.tipo = 'CORRENTE' AND co.id_fisico = NEW.id_fisico);

    IF (NEW.id_tipo = 1 AND numero_fisico_corrente > 0) OR (NEW.id_tipo = 2 AND numero_fisico_poupanca > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente já possui uma conta desse tipo';
    END IF;
END //
DELIMITER ;

-- Trigger para alterar saldos das contas
DELIMITER //
CREATE TRIGGER tr_verificacao_transacao
BEFORE INSERT
ON tb_transacao
FOR EACH ROW
BEGIN
    DECLARE transacao FLOAT(10,2);

    SET transacao = NEW.valor;

    IF transacao > (SELECT saldo FROM tb_conta WHERE id = NEW.conta_saida) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta saída possui saldo insuficiente';
    ELSEIF transacao = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transação inexistente: valor igual a 0';
    ELSEIF (SELECT status FROM tb_conta WHERE id = NEW.conta_saida) = 'INATIVA' OR (SELECT status FROM tb_conta WHERE id = NEW.conta_destino) = 'INATIVA' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta inativa para transações';
	ELSEIF NEW.conta_destino = NEW.conta_saida THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta não pode fazer transação para ela mesma';
    ELSE
        UPDATE tb_conta SET saldo = saldo - transacao WHERE id = NEW.conta_saida;
        UPDATE tb_conta SET saldo = saldo + transacao WHERE id = NEW.conta_destino;
    END IF;
END //
DELIMITER ;

-- Trigger para barrar cadastro de um endereço de um cliente jurídico para um cliente físico
DELIMITER //
CREATE TRIGGER tr_verificacao_endereco
BEFORE INSERT
ON tb_cliente_fisico
FOR EACH ROW
BEGIN
    DECLARE endereco_juridico INT;

    SET endereco_juridico = (SELECT id_juridico
    FROM tb_endereco AS e
    WHERE id = NEW.id_endereco);

    IF endereco_juridico IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente físico não pode ter endereço de cliente jurídico';
    END IF;
END //
DELIMITER ;

-- Trigger para barrar cadastro de um telefone de um cliente jurídico para um cliente físico
DELIMITER //
CREATE TRIGGER tr_verificacao_telefone
BEFORE INSERT
ON tb_cliente_fisico
FOR EACH ROW
BEGIN
    DECLARE telefone_juridico INT;

    SET telefone_juridico = (SELECT id_juridico
    FROM tb_telefone AS e
    WHERE id = NEW.id_endereco);

    IF telefone_juridico IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente físico não pode ter telefone de cliente jurídico';
    END IF;
END //
DELIMITER ;

-- Triggers para deletar item de tb_cliente_telefone se nem o cliente nem o telefone existirem mais
DELIMITER //
CREATE TRIGGER tr_deletar_associativa_1
AFTER DELETE
ON tb_cliente_fisico
FOR EACH ROW
BEGIN
	DELETE FROM tb_cliente_telefone WHERE id_cliente = OLD.id;
END // 
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_deletar_associativa_2
AFTER DELETE
ON tb_telefone
FOR EACH ROW
BEGIN
	DELETE FROM tb_cliente_telefone WHERE id_telefone = OLD.id;
END // 
DELIMITER ;