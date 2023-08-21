CALL sp_insert_tb_cliente_juridico('Empresa A', 'Razão A Ltda.', '12.345.678/9012-34', 'contato@empresaA.com', 'Ativo');
    CALL sp_insert_tb_cliente_juridico('Empresa B', 'Razão B S.A.', '56.789.012/3456-78', 'contato@empresaB.com', 'Ativo');
    CALL sp_insert_tb_cliente_juridico('Empresa C', 'Razão C & Filhos', '90.123/4567/890-12', 'contato@empresaC.com', 'Inativo');
    CALL sp_insert_tb_cliente_juridico('Empresa D', 'Razão D Tech', '34.567.890/1234-56', 'contato@empresaD.com', 'Ativo');
    CALL sp_insert_tb_cliente_juridico('Empresa E', 'Razão E Serviços', '78.901.234/5678-90', 'contato@empresaE.com', 'Inativo');
    

    CALL sp_insert_tb_endereco('Rua das Empresas, 123', 1);
    CALL sp_insert_tb_endereco('Avenida Principal, 456', NULL);
    CALL sp_insert_tb_endereco('Praça da Indústria, 789', 2);
    CALL sp_insert_tb_endereco('Rua Comercial, 789', NULL);
    CALL sp_insert_tb_endereco('Avenida das Corporações, 321', 3);
    CALL sp_insert_tb_endereco('Alameda Residencial, 654', NULL);
    CALL sp_insert_tb_endereco('Estrada da Empresa, 987', 4);


    CALL sp_insert_tb_tipo_conta('Corrente');
    CALL sp_insert_tb_tipo_conta('Poupança');
    

    CALL sp_insert_tb_tipo_transacao('Depósito');
    CALL sp_insert_tb_tipo_transacao('Saque');
    CALL sp_insert_tb_tipo_transacao('Transferência');
    CALL sp_insert_tb_tipo_transacao('Pagamento');
    CALL sp_insert_tb_tipo_transacao('Compra');
    CALL sp_insert_tb_tipo_transacao('Recebimento');
    CALL sp_insert_tb_tipo_transacao('PIX');
    

    CALL sp_insert_tb_tipo_telefone('Residencial');
    CALL sp_insert_tb_tipo_telefone('Comercial');
    CALL sp_insert_tb_tipo_telefone('Celular');
    

    CALL sp_insert_tb_cliente_fisico('123.456.789-01', 'João', 'Silva','joao@example.com', '1985-05-15', 'Ativo', 'Pai: José, Mãe: Maria', 2);
    CALL sp_insert_tb_cliente_fisico('987.654.321-09', 'Maria', 'Santos', 'maria@example.com', '1990-09-20', 'Ativo', 'Pai: Pedro, Mãe: Ana', 2);
    CALL sp_insert_tb_cliente_fisico('456.789.012-34', 'Carlos', 'Ferreira', 'carlos@example.com', '1988-11-03', 'Inativo', 'Pai: Antonio, Mãe: Laura', 4);
    CALL sp_insert_tb_cliente_fisico('234.567.890-12', 'Ana', 'Oliveira', 'ana@example.com', '1995-02-10', 'Ativo', 'Pai: Eduardo, Mãe: Beatriz', 4);
    CALL sp_insert_tb_cliente_fisico('789.012.345-67', 'Rafael', 'Martins', 'rafael@example.com', '1982-07-25', 'Inativo', 'Pai: Luiz, Mãe: Clara', 6);
    CALL sp_insert_tb_cliente_fisico('567.890.123-45', 'Camila', 'Almeida', 'camila@example.com', '1998-08-12', 'Ativo', 'Pai: Jorge, Mãe: Renata', 6);
    CALL sp_insert_tb_cliente_fisico('901.234.567-89', 'Fernanda', 'Rodrigues', 'fernanda@example.com', '1987-03-30', 'Ativo', 'Pai: Marcelo, Mãe: Andrea', 6);


    CALL sp_insert_tb_telefone(11, 987654321, 1, NULL);
    CALL sp_insert_tb_telefone(21, 123456789, 2, 1);
    CALL sp_insert_tb_telefone(31, 55554444, 1, NULL);
    CALL sp_insert_tb_telefone(41, 987612345, 2, 2);
    CALL sp_insert_tb_telefone(51, 876543210, 1, NULL);


    CALL sp_insert_tb_cliente_telefone(1,1);
    CALL sp_insert_tb_cliente_telefone(2,1);
    CALL sp_insert_tb_cliente_telefone(3,3);
    CALL sp_insert_tb_cliente_telefone(4,3);
    CALL sp_insert_tb_cliente_telefone(5,5);
    CALL sp_insert_tb_cliente_telefone(6,5);
    CALL sp_insert_tb_cliente_telefone(7,5);
    

    CALL sp_insert_tb_conta('1234567890', '5678', 1000.00, 'Ativa', 1, 1, NULL);
    CALL sp_insert_tb_conta('2345678901', '1234', 500.50, 'Ativa', 2, 2, NULL);
    CALL sp_insert_tb_conta('3456789012', '4321', 0.00, 'Inativa', 1, 3, NULL);
    CALL sp_insert_tb_conta('4567890123', '8765', 200.75, 'Ativa', 1, 4, NULL);
    CALL sp_insert_tb_conta('5678901234', '2109', 0.00, 'Inativa', 2, 5, NULL);
    

    CALL sp_insert_tb_conta('9876543210', '5678', 15000.00, 'Ativa', 1, NULL, 1);
    CALL sp_insert_tb_conta('8765432109', '1234', 7500.50, 'Ativa', 2, NULL, 2);
    CALL sp_insert_tb_conta('7654321098', '4321', 0.00, 'Inativa', 1, NULL, 3);
    CALL sp_insert_tb_conta('6543210987', '8765', 9000.75, 'Ativa', 1, NULL, 4);
    CALL sp_insert_tb_conta('5432109876', '2109', 0.00, 'Inativa', 2, NULL, 5);
    

    CALL sp_insert_tb_transacao(500.00, 1, 2, '2023-08-01', 7);
    CALL sp_insert_tb_transacao(250.50, 2, 4, '2023-08-02', 7);
    CALL sp_insert_tb_transacao(100.00, 4, 6, '2023-08-03', 7);
    CALL sp_insert_tb_transacao(700.75, 7, 4, '2023-08-04', 7);
    CALL sp_insert_tb_transacao(150.00, 9, 2, '2023-08-05', 7);