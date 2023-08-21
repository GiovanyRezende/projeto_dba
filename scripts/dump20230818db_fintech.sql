-- MariaDB dump 10.19  Distrib 10.4.22-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db_fintech
-- ------------------------------------------------------
-- Server version	10.4.22-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_cliente_fisico`
--

DROP TABLE IF EXISTS `tb_cliente_fisico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente_fisico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpf` varchar(14) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `sobrenome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `dt_nasc` date NOT NULL,
  `status` varchar(7) NOT NULL,
  `filiacao` varchar(255) NOT NULL,
  `id_endereco` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cpf_cliente_fisico` (`cpf`),
  KEY `fk_id_endereco_cliente_fisico` (`id_endereco`),
  CONSTRAINT `fk_id_endereco_cliente_fisico` FOREIGN KEY (`id_endereco`) REFERENCES `tb_endereco` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente_fisico`
--

LOCK TABLES `tb_cliente_fisico` WRITE;
/*!40000 ALTER TABLE `tb_cliente_fisico` DISABLE KEYS */;
INSERT INTO `tb_cliente_fisico` VALUES (1,'123.456.789-01','JOAO','SILVA','JOAO@EXAMPLE.COM','1985-05-15','ATIVO','PAI: JOSE, MAE: MARIA',2),(2,'987.654.321-09','MARIA','SANTOS','MARIA@EXAMPLE.COM','1990-09-20','ATIVO','PAI: PEDRO, MAE: ANA',2),(3,'456.789.012-34','CARLOS','FERREIRA','CARLOS@EXAMPLE.COM','1988-11-03','INATIVO','PAI: ANTONIO, MAE: LAURA',4),(4,'234.567.890-12','ANA','OLIVEIRA','ANA@EXAMPLE.COM','1995-02-10','ATIVO','PAI: EDUARDO, MAE: BEATRIZ',4),(5,'789.012.345-67','RAFAEL','MARTINS','RAFAEL@EXAMPLE.COM','1982-07-25','INATIVO','PAI: LUIZ, MAE: CLARA',6),(6,'567.890.123-45','CAMILA','ALMEIDA','CAMILA@EXAMPLE.COM','1998-08-12','ATIVO','PAI: JORGE, MAE: RENATA',6),(7,'901.234.567-89','FERNANDA','RODRIGUES','FERNANDA@EXAMPLE.COM','1987-03-30','ATIVO','PAI: MARCELO, MAE: ANDREA',6);
/*!40000 ALTER TABLE `tb_cliente_fisico` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_verificacao_endereco
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_verificacao_telefone
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_deletar_associativa_1
AFTER DELETE
ON tb_cliente_fisico
FOR EACH ROW
BEGIN
	DELETE FROM tb_cliente_telefone WHERE id_cliente = OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_cliente_juridico`
--

DROP TABLE IF EXISTS `tb_cliente_juridico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente_juridico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome_fantasia` varchar(255) NOT NULL,
  `razao_social` varchar(255) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cnpj_cliente_juridico` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente_juridico`
--

LOCK TABLES `tb_cliente_juridico` WRITE;
/*!40000 ALTER TABLE `tb_cliente_juridico` DISABLE KEYS */;
INSERT INTO `tb_cliente_juridico` VALUES (1,'EMPRESA A','RAZAO A LTDA.','12.345.678/9012-34','CONTATO@EMPRESAA.COM','ATIVO'),(2,'EMPRESA B','RAZAO B S.A.','56.789.012/3456-78','CONTATO@EMPRESAB.COM','ATIVO'),(3,'EMPRESA C','RAZAO C & FILHOS','90.123/4567/890-12','CONTATO@EMPRESAC.COM','INATIVO'),(4,'EMPRESA D','RAZAO D TECH','34.567.890/1234-56','CONTATO@EMPRESAD.COM','ATIVO'),(5,'EMPRESA E','RAZAO E SERVICOS','78.901.234/5678-90','CONTATO@EMPRESAE.COM','INATIVO');
/*!40000 ALTER TABLE `tb_cliente_juridico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente_telefone`
--

DROP TABLE IF EXISTS `tb_cliente_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente_telefone` (
  `id_cliente` int(11) NOT NULL,
  `id_telefone` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`,`id_telefone`),
  KEY `fk_id_telefone_cliente_telefone` (`id_telefone`),
  CONSTRAINT `fk_id_cliente_cliente_telefone` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente_fisico` (`id`),
  CONSTRAINT `fk_id_telefone_cliente_telefone` FOREIGN KEY (`id_telefone`) REFERENCES `tb_telefone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente_telefone`
--

LOCK TABLES `tb_cliente_telefone` WRITE;
/*!40000 ALTER TABLE `tb_cliente_telefone` DISABLE KEYS */;
INSERT INTO `tb_cliente_telefone` VALUES (1,1),(2,1),(3,3),(4,3),(5,5),(6,5),(7,5);
/*!40000 ALTER TABLE `tb_cliente_telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_conta`
--

DROP TABLE IF EXISTS `tb_conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_conta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) NOT NULL,
  `agencia` varchar(4) NOT NULL,
  `saldo` float(10,2) NOT NULL,
  `status` varchar(7) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `id_fisico` int(11) DEFAULT NULL,
  `id_juridico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_tipo_conta` (`id_tipo`),
  KEY `fk_id_fisico_conta` (`id_fisico`),
  KEY `fk_id_juridico_conta` (`id_juridico`),
  CONSTRAINT `fk_id_fisico_conta` FOREIGN KEY (`id_fisico`) REFERENCES `tb_cliente_fisico` (`id`),
  CONSTRAINT `fk_id_juridico_conta` FOREIGN KEY (`id_juridico`) REFERENCES `tb_cliente_juridico` (`id`),
  CONSTRAINT `fk_id_tipo_conta` FOREIGN KEY (`id_tipo`) REFERENCES `tb_tipo_conta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_conta`
--

LOCK TABLES `tb_conta` WRITE;
/*!40000 ALTER TABLE `tb_conta` DISABLE KEYS */;
INSERT INTO `tb_conta` VALUES (1,'1234567890','5678',500.00,'ATIVA',1,1,NULL),(2,'2345678901','1234',900.00,'ATIVA',2,2,NULL),(3,'3456789012','4321',0.00,'INATIVA',1,3,NULL),(4,'4567890123','8765',1052.00,'ATIVA',1,4,NULL),(5,'5678901234','2109',0.00,'INATIVA',2,5,NULL),(6,'9876543210','5678',15100.00,'ATIVA',1,NULL,1),(7,'8765432109','1234',6799.75,'ATIVA',2,NULL,2),(8,'7654321098','4321',0.00,'INATIVA',1,NULL,3),(9,'6543210987','8765',8850.75,'ATIVA',1,NULL,4),(10,'5432109876','2109',0.00,'INATIVA',2,NULL,5);
/*!40000 ALTER TABLE `tb_conta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_verificacao_n_de_contas
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_endereco`
--

DROP TABLE IF EXISTS `tb_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_endereco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `endereco` varchar(255) NOT NULL,
  `id_juridico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_juridico_cliente_juridico` (`id_juridico`),
  CONSTRAINT `fk_id_juridico_cliente_juridico` FOREIGN KEY (`id_juridico`) REFERENCES `tb_cliente_juridico` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_endereco`
--

LOCK TABLES `tb_endereco` WRITE;
/*!40000 ALTER TABLE `tb_endereco` DISABLE KEYS */;
INSERT INTO `tb_endereco` VALUES (1,'RUA DAS EMPRESAS, 123',1),(2,'AVENIDA PRINCIPAL, 456',NULL),(3,'PRACA DA INDUSTRIA, 789',2),(4,'RUA COMERCIAL, 789',NULL),(5,'AVENIDA DAS CORPORACOES, 321',3),(6,'ALAMEDA RESIDENCIAL, 654',NULL),(7,'ESTRADA DA EMPRESA, 987',4);
/*!40000 ALTER TABLE `tb_endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_telefone`
--

DROP TABLE IF EXISTS `tb_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_telefone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ddd` int(2) DEFAULT NULL,
  `numero` int(9) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `id_juridico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_tipo_telefone` (`id_tipo`),
  KEY `fk_id_juridico_telefone` (`id_juridico`),
  CONSTRAINT `fk_id_juridico_telefone` FOREIGN KEY (`id_juridico`) REFERENCES `tb_cliente_juridico` (`id`),
  CONSTRAINT `fk_id_tipo_telefone` FOREIGN KEY (`id_tipo`) REFERENCES `tb_tipo_telefone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_telefone`
--

LOCK TABLES `tb_telefone` WRITE;
/*!40000 ALTER TABLE `tb_telefone` DISABLE KEYS */;
INSERT INTO `tb_telefone` VALUES (1,11,987654321,1,NULL),(2,21,123456789,2,1),(3,31,55554444,1,NULL),(4,41,987612345,2,2),(5,51,876543210,1,NULL);
/*!40000 ALTER TABLE `tb_telefone` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_deletar_associativa_2
AFTER DELETE
ON tb_telefone
FOR EACH ROW
BEGIN
	DELETE FROM tb_cliente_telefone WHERE id_telefone = OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_tipo_conta`
--

DROP TABLE IF EXISTS `tb_tipo_conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tipo_conta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_conta`
--

LOCK TABLES `tb_tipo_conta` WRITE;
/*!40000 ALTER TABLE `tb_tipo_conta` DISABLE KEYS */;
INSERT INTO `tb_tipo_conta` VALUES (1,'CORRENTE'),(2,'POUPANCA');
/*!40000 ALTER TABLE `tb_tipo_conta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_telefone`
--

DROP TABLE IF EXISTS `tb_tipo_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tipo_telefone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_telefone`
--

LOCK TABLES `tb_tipo_telefone` WRITE;
/*!40000 ALTER TABLE `tb_tipo_telefone` DISABLE KEYS */;
INSERT INTO `tb_tipo_telefone` VALUES (1,'RESIDENCIAL'),(2,'COMERCIAL'),(3,'CELULAR');
/*!40000 ALTER TABLE `tb_tipo_telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_transacao`
--

DROP TABLE IF EXISTS `tb_tipo_transacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tipo_transacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_transacao`
--

LOCK TABLES `tb_tipo_transacao` WRITE;
/*!40000 ALTER TABLE `tb_tipo_transacao` DISABLE KEYS */;
INSERT INTO `tb_tipo_transacao` VALUES (1,'DEPOSITO'),(2,'SAQUE'),(3,'TRANSFERENCIA'),(4,'PAGAMENTO'),(5,'COMPRA'),(6,'RECEBIMENTO'),(7,'PIX');
/*!40000 ALTER TABLE `tb_tipo_transacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_transacao`
--

DROP TABLE IF EXISTS `tb_transacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_transacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` float(10,2) NOT NULL,
  `conta_saida` int(11) NOT NULL,
  `conta_destino` int(11) NOT NULL,
  `data` date NOT NULL,
  `id_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_tipo_transacao` (`id_tipo`),
  KEY `fk_conta_saida_transacao` (`conta_saida`),
  KEY `fk_conta_destino_transacao` (`conta_destino`),
  CONSTRAINT `fk_conta_destino_transacao` FOREIGN KEY (`conta_destino`) REFERENCES `tb_conta` (`id`),
  CONSTRAINT `fk_conta_saida_transacao` FOREIGN KEY (`conta_saida`) REFERENCES `tb_conta` (`id`),
  CONSTRAINT `fk_id_tipo_transacao` FOREIGN KEY (`id_tipo`) REFERENCES `tb_tipo_transacao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_transacao`
--

LOCK TABLES `tb_transacao` WRITE;
/*!40000 ALTER TABLE `tb_transacao` DISABLE KEYS */;
INSERT INTO `tb_transacao` VALUES (1,500.00,1,2,'2023-08-01',7),(2,250.50,2,4,'2023-08-02',7),(3,100.00,4,6,'2023-08-03',7),(4,700.75,7,4,'2023-08-04',7),(5,150.00,9,2,'2023-08-05',7);
/*!40000 ALTER TABLE `tb_transacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_verificacao_transacao
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `vw_dados_clientes_fisicos`
--

DROP TABLE IF EXISTS `vw_dados_clientes_fisicos`;
/*!50001 DROP VIEW IF EXISTS `vw_dados_clientes_fisicos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dados_clientes_fisicos` (
  `cliente_id` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `sobrenome` tinyint NOT NULL,
  `cpf` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `data_nascimento` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `filiacao` tinyint NOT NULL,
  `endereco` tinyint NOT NULL,
  `telefone` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dados_clientes_juridicos`
--

DROP TABLE IF EXISTS `vw_dados_clientes_juridicos`;
/*!50001 DROP VIEW IF EXISTS `vw_dados_clientes_juridicos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dados_clientes_juridicos` (
  `cliente_id` tinyint NOT NULL,
  `nome_fantasia` tinyint NOT NULL,
  `razao_social` tinyint NOT NULL,
  `cnpj` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `endereco` tinyint NOT NULL,
  `telefone` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_transacoes_clientes_fisicos`
--

DROP TABLE IF EXISTS `vw_transacoes_clientes_fisicos`;
/*!50001 DROP VIEW IF EXISTS `vw_transacoes_clientes_fisicos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_transacoes_clientes_fisicos` (
  `nome` tinyint NOT NULL,
  `cpf` tinyint NOT NULL,
  `valor_transacao` tinyint NOT NULL,
  `tipo_transacao` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_transacoes_clientes_juridicos`
--

DROP TABLE IF EXISTS `vw_transacoes_clientes_juridicos`;
/*!50001 DROP VIEW IF EXISTS `vw_transacoes_clientes_juridicos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_transacoes_clientes_juridicos` (
  `nome_fantasia` tinyint NOT NULL,
  `cnpj` tinyint NOT NULL,
  `valor_transacao` tinyint NOT NULL,
  `tipo_transacao` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_dados_clientes_fisicos`
--

/*!50001 DROP TABLE IF EXISTS `vw_dados_clientes_fisicos`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dados_clientes_fisicos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dados_clientes_fisicos` AS select `f`.`id` AS `cliente_id`,`f`.`nome` AS `nome`,`f`.`sobrenome` AS `sobrenome`,`f`.`cpf` AS `cpf`,`f`.`email` AS `email`,`f`.`dt_nasc` AS `data_nascimento`,`f`.`status` AS `status`,`f`.`filiacao` AS `filiacao`,`e`.`endereco` AS `endereco`,ifnull(`t`.`numero`,'N/A') AS `telefone` from (((`tb_cliente_fisico` `f` join `tb_endereco` `e` on(`f`.`id_endereco` = `e`.`id`)) left join `tb_cliente_telefone` `ct` on(`f`.`id` = `ct`.`id_cliente`)) left join `tb_telefone` `t` on(`ct`.`id_telefone` = `t`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dados_clientes_juridicos`
--

/*!50001 DROP TABLE IF EXISTS `vw_dados_clientes_juridicos`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dados_clientes_juridicos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dados_clientes_juridicos` AS select `c`.`id` AS `cliente_id`,`c`.`nome_fantasia` AS `nome_fantasia`,`c`.`razao_social` AS `razao_social`,`c`.`cnpj` AS `cnpj`,`c`.`email` AS `email`,`c`.`status` AS `status`,`e`.`endereco` AS `endereco`,ifnull(`t`.`numero`,'N/A') AS `telefone` from ((`tb_cliente_juridico` `c` join `tb_endereco` `e` on(`c`.`id` = `e`.`id_juridico`)) left join `tb_telefone` `t` on(`c`.`id` = `t`.`id_juridico`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_transacoes_clientes_fisicos`
--

/*!50001 DROP TABLE IF EXISTS `vw_transacoes_clientes_fisicos`*/;
/*!50001 DROP VIEW IF EXISTS `vw_transacoes_clientes_fisicos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_transacoes_clientes_fisicos` AS select `f`.`nome` AS `nome`,`f`.`cpf` AS `cpf`,`t`.`valor` AS `valor_transacao`,`tt`.`descricao` AS `tipo_transacao` from (((`tb_cliente_fisico` `f` join `tb_conta` `co` on(`f`.`id` = `co`.`id_fisico`)) join `tb_transacao` `t` on(`co`.`id` = `t`.`conta_saida`)) join `tb_tipo_transacao` `tt` on(`t`.`id_tipo` = `tt`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_transacoes_clientes_juridicos`
--

/*!50001 DROP TABLE IF EXISTS `vw_transacoes_clientes_juridicos`*/;
/*!50001 DROP VIEW IF EXISTS `vw_transacoes_clientes_juridicos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_transacoes_clientes_juridicos` AS select `c`.`nome_fantasia` AS `nome_fantasia`,`c`.`cnpj` AS `cnpj`,`t`.`valor` AS `valor_transacao`,`tt`.`descricao` AS `tipo_transacao` from (((`tb_cliente_juridico` `c` join `tb_conta` `co` on(`c`.`id` = `co`.`id_juridico`)) join `tb_transacao` `t` on(`co`.`id` = `t`.`conta_saida`)) join `tb_tipo_transacao` `tt` on(`t`.`id_tipo` = `tt`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-18 14:50:09
