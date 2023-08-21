-- Função para alterar string
DELIMITER //
CREATE FUNCTION fn_texto(texto VARCHAR (255))
RETURNS VARCHAR(255) 
READS SQL DATA
    BEGIN
    SET texto = UPPER(texto),
		texto = REPLACE(texto,'À', 'A'),
    	texto = REPLACE(texto,'Á', 'A'),
    	texto = REPLACE(texto,'Ã', 'A'),
    	texto = REPLACE(texto,'Ä', 'A'),
    	texto = REPLACE(texto,'Â', 'A'),
    	texto = REPLACE(texto,'É', 'E'),
    	texto = REPLACE(texto,'È', 'E'),
        texto = REPLACE(texto,'Ê', 'E'),
    	texto = REPLACE(texto,'Ë', 'E'),
    	texto = REPLACE(texto,'Ì', 'I'),
    	texto = REPLACE(texto,'Í', 'I'),    
    	texto = REPLACE(texto,'Ï', 'I'),
        texto = REPLACE(texto,'Î', 'I'),
        texto = REPLACE(texto,'Ò', 'O'),
        texto = REPLACE(texto,'Ó', 'O'),
        texto = REPLACE(texto,'Ô', 'O'),
        texto = REPLACE(texto,'Õ', 'O'),
        texto = REPLACE(texto,'Ö', 'O'),
        texto = REPLACE(texto,'Ù', 'U'),
    	texto = REPLACE(texto,'Ú', 'U'),
        texto = REPLACE(texto,'Û', 'U'),
        texto = REPLACE(texto,'Ü', 'U'),
        texto = REPLACE(texto,'Ý', 'Y'),
        texto = REPLACE(texto,'Ç', 'C'),
        texto = trim(texto),
        texto = REPLACE(texto,"  "," ");
    RETURN texto;
    END //
DELIMITER ;

-- Triggers

-- tb_cliente_juridico

DELIMITER //
CREATE PROCEDURE sp_insert_tb_cliente_juridico(str VARCHAR(255), raz VARCHAR(255), cnp VARCHAR(18), em VARCHAR(255), st VARCHAR(7))
BEGIN
	IF (str OR raz OR cnp OR em OR st) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSE
    INSERT INTO tb_cliente_juridico (nome_fantasia, razao_social, cnpj, email, status)
		VALUES (fn_texto(str), fn_texto(raz), fn_texto(cnp), fn_texto(em), fn_texto(st));
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_cliente_juridico(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_cliente_juridico WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_cliente_juridico WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_cliente_juridico(id_update INT, str VARCHAR(255), raz VARCHAR(255), cnp VARCHAR(18), em VARCHAR(255), st VARCHAR(7))
BEGIN
	IF (str OR raz OR cnp OR em OR st) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF NOT EXISTS (SELECT id FROM tb_cliente_juridico WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		IF str IS NOT NULL AND (raz IS NULL AND cnp IS NULL AND em IS NULL AND st IS NULL) THEN
			UPDATE tb_cliente_juridico SET nome_fantasia = fn_texto(str) WHERE id = id_update;
		ELSEIF raz IS NOT NULL AND (str IS NULL AND cnp IS NULL AND em IS NULL AND st IS NULL) THEN
			UPDATE tb_cliente_juridico SET razao_social = fn_texto(raz) WHERE id = id_update;
		ELSEIF cnp IS NOT NULL AND (raz IS NULL AND str IS NULL AND em IS NULL AND st IS NULL) THEN
			UPDATE tb_cliente_juridico SET cnpj = fn_texto(cnp) WHERE id = id_update;
		ELSEIF em IS NOT NULL AND (raz IS NULL AND cnp IS NULL AND str IS NULL AND st IS NULL) THEN
			UPDATE tb_cliente_juridico SET email = fn_texto(em) WHERE id = id_update;
		ELSEIF st IS NOT NULL AND (raz IS NULL AND cnp IS NULL AND em IS NULL AND st IS NULL) THEN
			UPDATE tb_cliente_juridico SET status = fn_texto(st) WHERE id = id_update;
        END IF;
	END IF;
END //
DELIMITER ;

-- tb_endereco

DELIMITER //
CREATE PROCEDURE sp_insert_tb_endereco(ende VARCHAR(255), juri INT)
BEGIN
	IF ende IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos para endereço';
	ELSEIF juri REGEXP '^[A-Za-z]+$' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSEIF juri IS NOT NULL AND (SELECT id FROM tb_cliente_juridico WHERE id = juri) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente jurídico não encontrado';
    ELSE
		INSERT INTO tb_endereco (endereco,id_juridico) VALUES
			(fn_texto(ende),juri);
	END IF;
END//
DELIMITER ; 

DELIMITER //
CREATE PROCEDURE sp_delete_tb_endereco(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_endereco WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_endereco WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_endereco(i INT, ende VARCHAR(255), juri INT)
BEGIN
	IF ende IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos para endereço';
	ELSEIF juri REGEXP '^[A-Za-z]+$' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSEIF NOT EXISTS (SELECT id FROM tb_endereco WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		IF ende IS NOT NULL AND juri IS NULL THEN
			UPDATE tb_endereco SET endereco = fn_texto(ende) WHERE id = id_update;
		ELSEIF juri IS NOT NULL OR ende IS NULL THEN
			UPDATE tb_endereco SET id_juridico = juri WHERE id = id_update;
		END IF;
	END IF;
END //
DELIMITER ;

-- tb_tipo_conta

DELIMITER //
CREATE PROCEDURE sp_insert_tb_tipo_conta(tip VARCHAR(100))
BEGIN
	IF tip IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF tip REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSE
		INSERT INTO tb_tipo_conta (tipo) VALUES
			(fn_texto(tip));
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_tipo_conta(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_tipo_conta WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_tipo_conta WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_tipo_conta(id_update INT, tip VARCHAR(100))
BEGIN
	IF tip IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF tip REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
    ELSEIF NOT EXISTS (SELECT id FROM tb_tipo_conta WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		UPDATE tb_tipo_conta SET tipo = fn_texto(tip) WHERE id = id_update;
	END IF;		
END //
DELIMITER ;

-- tb_tipo_transacao

DELIMITER //
CREATE PROCEDURE sp_insert_tb_tipo_transacao(tip VARCHAR(100))
BEGIN
	IF tip IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF tip REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSE
		INSERT INTO tb_tipo_transacao (descricao) VALUES
			(fn_texto(tip));
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_tipo_transacao(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_tipo_transacao WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_tipo_transacao WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_tipo_transacao(id_update INT, tip VARCHAR(100))
BEGIN
	IF tip IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF tip REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
    ELSEIF NOT EXISTS (SELECT id FROM tb_tipo_transacao WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		UPDATE tb_tipo_transacao SET descricao = fn_texto(tip) WHERE id = id_update;
	END IF;		
END //
DELIMITER ;

-- tb_tipo_telefone

DELIMITER //
CREATE PROCEDURE sp_insert_tb_tipo_telefone(tip VARCHAR(100))
BEGIN
	IF tip IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF tip REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSE
		INSERT INTO tb_tipo_telefone (descricao) VALUES
			(fn_texto(tip));
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_tipo_telefone(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_tipo_telefone WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_tipo_telefone WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_tipo_telefone(id_update INT, tip VARCHAR(100))
BEGIN
	IF tip IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF tip REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
    ELSEIF NOT EXISTS (SELECT id FROM tb_tipo_telefone WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		UPDATE tb_tipo_telefone SET descricao = fn_texto(tip) WHERE id = id_update;
	END IF;		
END //
DELIMITER ;

-- tb_cliente_fisico

DELIMITER //
CREATE PROCEDURE sp_insert_tb_cliente_fisico(cp VARCHAR(14),str VARCHAR(255),sob VARCHAR(255),em VARCHAR(255),dt DATE,st VARCHAR(7),fil VARCHAR(255),ende INT)
BEGIN
	IF (str OR sob OR cp OR em OR st OR dt OR st OR fil OR ende) IS NULL OR length(fn_texto(str)) <= 2 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF ende REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSEIF dt > CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de nascimento futura';
	ELSEIF NOT EXISTS (SELECT id FROM tb_endereco WHERE id = ende) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Endereço não encontrado para o cliente';
	ELSE
		INSERT INTO tb_cliente_fisico (cpf,nome,sobrenome,email,dt_nasc,status,filiacao,id_endereco) VALUES
			(fn_texto(cp),fn_texto(str),fn_texto(sob),fn_texto(em),dt,fn_texto(st),fn_texto(fil),ende);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_cliente_fisico(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_cliente_fisico WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_cliente_fisico WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_cliente_fisico(id_update INT,cp VARCHAR(14),str VARCHAR(255),sob VARCHAR(255),em VARCHAR(255),dt DATE,st VARCHAR(7),fil VARCHAR(255),ende INT)
BEGIN
	IF (str OR sob OR cp OR em OR st OR dt OR st OR fil OR ende) IS NULL OR (length(fn_texto(str)) OR length(fn_texto(sob))) < 2 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode inserir valores nulos ou inválidos';
	ELSEIF ende REGEXP '^[[A-Za-z]+$]' OR id_update REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSEIF ende REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSEIF dt > CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de nascimento futura';
	ELSEIF NOT EXISTS (SELECT id FROM tb_endereco WHERE id = ende) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Endereço não encontrado para o cliente';
	ELSEIF NOT EXISTS (SELECT id FROM tb_cliente_fisico WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não encontrado';
	ELSE
		IF cp IS NOT NULL AND (str IS NULL AND sob IS NULL AND em IS NULL AND dt IS NULL AND st IS NULL AND fil IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET cpf = fn_texto(cp) WHERE id = id_update;
		ELSEIF str IS NOT NULL AND (cp IS NULL AND sob IS NULL AND em IS NULL AND dt IS NULL AND st IS NULL AND fil IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET nome = fn_texto(str) WHERE id = id_update;
		ELSEIF sob IS NOT NULL AND (str IS NULL AND cp IS NULL AND em IS NULL AND dt IS NULL AND st IS NULL AND fil IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET sobrenome = fn_texto(sob) WHERE id = id_update;
		ELSEIF em IS NOT NULL AND (str IS NULL AND sob IS NULL AND cp IS NULL AND dt IS NULL AND st IS NULL AND fil IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET email = fn_texto(em) WHERE id = id_update;
		ELSEIF dt IS NOT NULL AND (str IS NULL AND sob IS NULL AND em IS NULL AND cp IS NULL AND st IS NULL AND fil IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET dt_nasc = dt WHERE id = id_update;
		ELSEIF st IS NOT NULL AND (str IS NULL AND sob IS NULL AND em IS NULL AND dt IS NULL AND cp IS NULL AND fil IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET status = fn_texto(st) WHERE id = id_update;
		ELSEIF fil IS NOT NULL AND (str IS NULL AND sob IS NULL AND em IS NULL AND dt IS NULL AND st IS NULL AND cp IS NULL AND ende IS NULL) THEN
			UPDATE tb_cliente_fisico SET filiacao = fn_texto(fil) WHERE id = id_update;
		ELSEIF ende IS NOT NULL AND (str IS NULL AND sob IS NULL AND em IS NULL AND dt IS NULL AND st IS NULL AND fil IS NULL AND cp IS NULL) THEN
			UPDATE tb_cliente_fisico SET id_endereco = ende WHERE id = id_update;
		END IF;
	END IF;
END //
DELIMITER ;

-- tb_telefone

DELIMITER //
CREATE PROCEDURE sp_insert_tb_telefone(dd INT(2), nmr INT(9), tipo INT, jurid INT)
BEGIN
	IF dd REGEXP '^[[A-Za-z]+$]' AND nmr REGEXP '^[[A-Za-z]+$]' AND tipo REGEXP '^[[A-Za-z]+$]' AND jurid REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSE
		INSERT INTO tb_telefone (ddd,numero,id_tipo,id_juridico) VALUEs
			(dd,nmr,tipo,jurid);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_telefone(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_telefone WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_telefone WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_telefone(id_update INT, dd INT(2), nmr INT(9), tipo INT, jurid INT)
BEGIN
	IF dd REGEXP '^[[A-Za-z]+$]' AND nmr REGEXP '^[[A-Za-z]+$]' AND tipo REGEXP '^[[A-Za-z]+$]' AND jurid REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado inválido';
	ELSEIF NOT EXISTS (SELECT id FROM tb_telefone WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		IF dd IS NOT NULL AND (nmr IS NULL AND tipo IS NULL AND jurid IS NULL) THEN
			UPDATE tb_telefone SET ddd = dd WHERE id = id_update;
		ELSEIF nmr IS NOT NULL AND (dd IS NULL AND tipo IS NULL AND jurid IS NULL) THEN
			UPDATE tb_telefone SET numero = nmr WHERE id = id_update;
		ELSEIF tipo IS NOT NULL AND (dd IS NULL AND nmr IS NULL AND jurid IS NULL) THEN
			UPDATE tb_telefone SET id_tipo = tipo WHERE id = id_update;
		ELSEIF jurid IS NOT NULL AND (dd IS NULL AND tipo IS NULL AND jurid IS NULL) THEN
			UPDATE tb_telefone SET id_juridico = jurid WHERE id = id_update;
        END IF;
	END IF;
END //
DELIMITER ; 

-- tb_cliente_telefone

DELIMITER //
CREATE PROCEDURE sp_insert_tb_cliente_telefone(cli INT, tel INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_cliente_fisico WHERE id = cli) OR NOT EXISTS (SELECT id FROM tb_telefone WHERE id = tel) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente/telefone não encontrado';
	ELSE
		INSERT INTO tb_cliente_telefone VALUES (cli,tel);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_cliente_telefone(cli_old INT, tel_old INT, cli INT, tel INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_cliente_fisico WHERE id = cli) OR NOT EXISTS (SELECT id FROM tb_telefone WHERE id = tel) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente/telefone não encontrado';
	ELSE
		IF (cli AND cli_old) IS NOT NULL AND (tel AND tel_old) IS NULL THEN
			UPDATE tb_cliente_telefone SET id_cliente = cli WHERE id_cliente = cli_old;
		ELSEIF (tel AND tel_old) IS NOT NULL AND (cli AND cli_old) IS NULL THEN
			UPDATE tb_cliente_telefone SET id_telefone = tel WHERE id_telefone = tel_old;
        END IF;
    END IF;
END //
DELIMITER ;

-- tb_conta

DELIMITER //
CREATE PROCEDURE sp_insert_tb_conta(nmr VARCHAR(10),ag VARCHAR(4),sal FLOAT(10,2),st VARCHAR(7),tipo INT,fisico INT,jurid INT)
BEGIN
	IF st REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado errado';
	ELSEIF tipo REGEXP '^[[A-Za-z]+$]' AND fisico REGEXP '^[[A-Za-z]+$]' AND jurid REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado errado';
	ELSEIF fisico IS NOT NULL AND jurid IS NOT NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não se pode cadastrar uma conta que é ao mesmo tempo de um cliente físico e jurídico. Tente colocar um dos IDs como NULL';
	ELSE 
		INSERT INTO tb_conta (numero,agencia,saldo,status,id_tipo,id_fisico,id_juridico) VALUES
			(nmr,ag,sal,fn_texto(st),tipo,fisico,jurid);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_conta(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_conta WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_conta WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_conta(id_update INT,nmr VARCHAR(10),ag VARCHAR(4),sal FLOAT(10,2),st VARCHAR(7),tipo INT,fisico INT,jurid INT)
BEGIN
	IF st REGEXP '^[0-9]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado errado';
	ELSEIF tipo REGEXP '^[[A-Za-z]+$]' AND fisico REGEXP '^[[A-Za-z]+$]' AND jurid REGEXP '^[[A-Za-z]+$]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado errado';
	ELSEIF NOT EXISTS (SELECT id FROM tb_conta WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSEIF fisico IS NOT NULL AND jurid IS NOT NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não se pode cadastrar uma conta que é ao mesmo tempo de um cliente físico e jurídico. Tente colocar um dos IDs como NULL';
	ELSE 
		IF nmr IS NOT NULL AND (ag IS NULL AND sal IS NULL AND st IS NULL AND tipo IS NULL AND fisico IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET numero = nmr WHERE id = id_update;
		ELSEIF ag IS NOT NULL AND (nmr IS NULL AND sal IS NULL AND st IS NULL AND tipo IS NULL AND fisico IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET agencia = ag WHERE id = id_update;
		ELSEIF sal IS NOT NULL AND (ag IS NULL AND nmr IS NULL AND st IS NULL AND tipo IS NULL AND fisico IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET saldo = sal WHERE id = id_update;
		ELSEIF st IS NOT NULL AND (ag IS NULL AND sal IS NULL AND st IS NULL AND tipo IS NULL AND fisico IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET status = fn_texto(st) WHERE id = id_update;
		ELSEIF tipo IS NOT NULL AND (ag IS NULL AND sal IS NULL AND st IS NULL AND nmr IS NULL AND fisico IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET id_tipo = tipo WHERE id = id_update;
		ELSEIF fisico IS NOT NULL AND (ag IS NULL AND sal IS NULL AND st IS NULL AND tipo IS NULL AND nmr IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET id_fisico = fisico WHERE id = id_update;
		ELSEIF jurid IS NOT NULL AND (ag IS NULL AND sal IS NULL AND st IS NULL AND tipo IS NULL AND fisico IS NULL AND jurid IS NULL) THEN
			UPDATE tb_conta SET id_juridico = jurid WHERE id = id_update;
        END IF;
	END IF;
END //
DELIMITER ;

-- tb_transacao                                       valor FLOAT(10,2) NOT NULL,conta_saida INT NOT NULL,conta_destino INT NOT NULL,data DATE NOT NULL,id_tipo

DELIMITER //
CREATE PROCEDURE sp_insert_tb_transacao(val FLOAT(10,2),saida INT,dest INT,dt DATE,tipo INT)
BEGIN
	IF saida REGEXP '^[[A-Za-z]+$]' AND dest REGEXP '^[[A-Za-z]+$]' AND dt REGEXP '^[[A-Za-z]+$]' AND tipo REGEXP '^[[A-Za-z]+$]' AND val REGEXP '^[A-Za-z]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado errado';
	ELSEIF dt > CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data não pode ser futura';
	ELSE
		INSERT INTO tb_transacao (valor,conta_saida,conta_destino,data,id_tipo) VALUES
			(val,saida,dest,dt,tipo);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_tb_transacao(i INT)
BEGIN
	IF NOT EXISTS (SELECT id FROM tb_transacao WHERE id = i) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE
		DELETE FROM tb_transacao WHERE id = i;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_tb_transacao(id_update INT,val FLOAT(10,2),saida INT,dest INT,dt DATE,tipo INT) 
BEGIN
	IF saida REGEXP '^[[A-Za-z]+$]' AND dest REGEXP '^[[A-Za-z]+$]' AND dt REGEXP '^[[A-Za-z]+$]' AND tipo REGEXP '^[[A-Za-z]+$]' AND val REGEXP '^[A-Za-z]' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de dado errado';
	ELSEIF dt > CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data não pode ser futura';
	ELSEIF NOT EXISTS (SELECT id FROM tb_transacao WHERE id = id_update) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID não existe';
	ELSE 
		IF val IS NOT NULL AND (saida IS NULL AND dest IS NULL AND dt IS NULL AND tipo IS NULL) THEN
			UPDATE tb_transacao SET valor = val WHERE id = id_update;
		ELSEIF saida IS NOT NULL AND (val IS NULL AND dest IS NULL AND dt IS NULL AND tipo IS NULL) THEN
			UPDATE tb_transacao SET conta_saida = saida WHERE id = id_update;
		ELSEIF dest IS NOT NULL AND (val IS NULL AND saida IS NULL AND dt IS NULL AND tipo IS NULL) THEN
			UPDATE tb_transacao SET conta_destino = dest WHERE id = id_update;
		ELSEIF dt IS NOT NULL AND (val IS NULL AND dest IS NULL AND saida IS NULL AND tipo IS NULL) THEN
			UPDATE tb_transacao SET data = dt WHERE id = id_update;
		ELSEIF tipo IS NOT NULL AND (val IS NULL AND dest IS NULL AND dt IS NULL AND saida IS NULL) THEN
			UPDATE tb_transacao SET id_tipo = tipo WHERE id = id_update;
        END IF;
	END IF;
END //
DELIMITER ;