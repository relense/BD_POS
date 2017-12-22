USE pos;


/*View AutoridadeTributariaLoja
*Com esta view temos a informação necessária para enviar à autoridade tributaria mensalmente
*/
CREATE OR REPLACE VIEW AutoridadeTributariaLoja AS
SELECT SUM(fa_custo_total) 'Lucro Com Iva', MONTHNAME(fa_data) Mes, SUM(fa_iva) 'Total Iva', SUM(fa_custo_total - fa_iva) 'Lucro Sem Iva'
FROM Faturacao
WHERE YEAR(fa_data) = YEAR(CURRENT_DATE)
AND MONTH(fa_data) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH);

/*View AutoridadeTributariaCliente
*Com esta view temos a informação necessária para enviar à autoridade tributaria mensalmente sobre os clientes
*/
CREATE OR REPLACE VIEW AutoridadeTributariaCliente AS
SELECT cli_nome 'Cliente Nome', fa_iva 'Iva Pago', (fa_custo_total - fa_iva) 'Custos Sem Iva', fa_custo_total 'Custo Com Iva', MONTHNAME(fa_data) Mes, cli_nif Nif
FROM Cliente
INNER JOIN ClienteVendas
ON cli_id = cv_cliente_id
INNER JOIN Vendas
ON cv_vendas_id = ve_id
INNER JOIN Faturacao
ON ve_id = fa_ve_id
WHERE YEAR(fa_data) = YEAR(CURDATE() )
AND MONTH(fa_data) = MONTH(CURDATE() - INTERVAL 1 MONTH);

/*View VolumeDeVendas
*Com esta view vamos conseguir identificar o volume de vendas mensal e também de todos os mes em que houve vendas.
*/
CREATE OR REPLACE VIEW VolumeDeVendas AS
SELECT DISTINCT COUNT(ve_id) 'Numero de Vendas', SUM(ve_custo) 'Lucro', SUM(ve_litros) 'Litros Vendidos', MONTHNAME(ve_data_venda) Mes
FROM vendas
GROUP BY YEAR(ve_data_venda) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
AND MONTH(ve_data_venda) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH);

/*View NumeroOfertasPorCliente
*Com esta view vai ser possível ver o numero de ofertas adquiridas por cliente
*/
CREATE OR REPLACE VIEW NumeroOfertasPorCliente AS
SELECT cli_nome Nome, COUNT(vo_ofertas_id) 'Numero Ofertas' FROM cliente
INNER JOIN ClienteVendas
ON cli_id = cv_cliente_id
INNER JOIN Vendas
ON cv_vendas_id = ve_id
INNER JOIN VendasOfertas
ON ve_id = vo_vendas_id
INNER JOIN Ofertas
ON vo_ofertas_id = of_id
GROUP BY cli_nome;

/*View OfertasMaisVendidasCategoria
*Com esta view vai ser possível identificar as ofertas mais vendidas nas 2 categorias que existem
*/
CREATE OR REPLACE VIEW OfertasMaisVendidasCategoria AS
SELECT DISTINCT of_categoria Categoria, of_nome Nome, COUNT(vo_ofertas_id)'Numero de Ofertas Vendidas'
FROM Ofertas
INNER JOIN VendasOfertas
ON of_id = vo_ofertas_id
GROUP BY vo_ofertas_id
HAVING COUNT(vo_ofertas_id) = (SELECT MAX(vo_ofertas_id) FROM 
								(SELECT COUNT(*) vo_ofertas_id
								FROM vendasofertas
								GROUP BY vo_ofertas_id) n);

/*View OfertasMaisProcuradasTop5
*Com esta view é possível saber quais as 5 ofertas mais procuradas pelos clientes
*/
CREATE OR REPLACE VIEW OfertaMaisProcurada AS
SELECT DISTINCT of_nome 'Nome', COUNT(vo_ofertas_id) 'Numero de Ofertas Vendidas'
FROM Ofertas
INNER JOIN VendasOfertas
ON of_id = vo_ofertas_id
GROUP BY vo_ofertas_id
ORDER BY COUNT(vo_ofertas_id) DESC
LIMIT 5;


/*View CombustivelMaisVendido
*Com esta view é possível saber qual o combústivel que foi mais vendido até hoje
*/
CREATE OR REPLACE VIEW CombustivelMaisVendido AS
SELECT co_nome 'Combustível', COUNT(ve_id) 'Numero de Vendas'
FROM Combustivel
INNER JOIN  Vendas
ON co_id = ve_id_combustivel
GROUP BY co_nome
HAVING COUNT(*) = (SELECT MAX(ve_id) FROM 
						(SELECT COUNT(*) ve_id
							FROM Vendas
                            GROUP BY ve_id_combustivel)n);

/*View CombustivelMenosVendido
*Com esta view é possível saber qual o combústivel que foi menos vendido até hoje
*/
CREATE OR REPLACE VIEW CombustivelMenosVendido AS
SELECT co_nome 'Combustível', COUNT(ve_id) 'Numero de 	Vendas'
FROM Combustivel
INNER JOIN  Vendas
ON co_id = ve_id_combustivel
GROUP BY co_nome
HAVING COUNT(*) = (SELECT MIN(ve_id) FROM 
						(SELECT COUNT(*) ve_id
							FROM Vendas
                            GROUP BY ve_id_combustivel)n);

/*View NVendasColaborador
*Com esta view vai ser possível identificar o colaborador que efetuou mais vendas
*/
CREATE OR REPLACE VIEW NVendasColaborador AS
SELECT  DISTINCT col_nome Colaborador , COUNT(ve_id_colaborador) 'Numero de Vendas'
FROM Colaborador
INNER JOIN Vendas
ON col_id = ve_id_colaborador
GROUP BY col_nome;

/*View ClienteComMaisCompras
*Com esta view vai ser possível identificar o cliente que fez mais compras
*/
CREATE OR REPLACE VIEW ClienteComMaisCompras AS
SELECT cli_nome Nome, COUNT(cv_cliente_id) 'Numero de Compras'
FROM Cliente
INNER JOIN ClienteVendas
ON cli_id = cv_cliente_id
GROUP BY cli_nome
HAVING COUNT(*) = (SELECT MAX(cv_cliente_id)  FROM
						(SELECT COUNT(*) cv_cliente_id
							FROM ClienteVendas
							GROUP BY cv_cliente_id) n);


/*View NVendasSemmCliente
*Com esta view vai ser possível identificar quantas vendas efetuadas não têm cliente
*/
CREATE OR REPLACE VIEW NVendasSemCliente AS
SELECT COUNT(ve_id)'Numero de Vendas Sem Cliente'
FROM Vendas
LEFT JOIN clienteVendas
ON ve_id = cv_vendas_id 
WHERE cv_vendas_id IS NULL;

                
                
/*View NVendasComCliente
*Com esta view vai ser possível identificar quantas vendas efetuadas têm um cliente registado
*/
CREATE OR REPLACE VIEW NVendasComCliente AS
SELECT COUNT(cv_cliente_id) 'Numero de Vendas Com cliente' 
FROM ClienteVendas;


/* Fase 2 */

/**********************************VIEWS*********************************************/

/*View TabelaCliente
*Com esta view vai ser possível mostrar a informação sobre todos os clientes
*/
CREATE OR REPLACE VIEW TabelaCliente AS
SELECT cli_id ID, cli_nome Nome, cli_data_registo 'Data Registo', 
cli_telefone Telefone, cli_localidade Localidade, cli_pontos Pontos, 
cli_empresa Empresa, cli_nif Nif, cli_data_nascimento 'Data de Nascimento', 
cli_rua Rua, cli_nr Nr, cli_andar Andar, cli_porta Porta, cli_codigo_postal 'Codigo_Postal', cli_estado Estado
FROM Cliente;

/*View TabelaColaborador
*Com esta view vamos conseguir visualizar todas as informações sobre os colaboradores
*/
CREATE OR REPLACE VIEW TabelaColaborador AS
SELECT col_id ID, col_nome Nome, col_data_registo 'Data Registo',
col_telefone Telefone, col_localidade Localidade, col_rua Rua, col_nr Nr, 
col_andar Andar, col_porta Porta, col_codigo_postal 'Codigo Postal',
col_data_nascimento 'Data de Nascimento', col_estado Estado
FROM Colaborador;

/*View TabelaFornecedor
*Com esta view vamos conseguir visualizar todas as informações sobre os fornecedores
*/
CREATE OR REPLACE VIEW TabelaFornecedor AS
SELECT for_id ID, for_nome Nome, for_data_registo 'Data Registo',
for_telefone Telefone, for_localidade Localidade, for_empresa Empresa,
for_rua Rua, for_nr Nr, for_andar Andar, for_porta Porta, for_codigo_postal 'Codigo Postal', for_estado Estado
FROM Fornecedor;

/*View TabelaCombustivel
*Com esta view vamos conseguir visualizar todas as informações sobre os combustiveis
*/
CREATE OR REPLACE VIEW TabelaCombustivel AS
SELECT co_id ID, co_custo_litro 'Custo por Litro',
co_nome Nome, co_data_inicio 'Data de Inicio',
co_data_fim 'Data de Fim', co_fornecedor_id 'ID Fornecedor',
co_stock Stock
FROM Combustivel;

/*View TabelaOfertas
*Com esta view vamos ser possível visualizar toda a informação sobre a tabela ofertas
*/
CREATE OR REPLACE VIEW TabelaOfertas AS
SELECT of_id ID, of_nome Nome, of_pontos Pontos,
of_data_inicio 'Data de Inicio', of_data_fim 'Data de Fim',
of_descricao Descricao, of_categoria Categoria,
of_numero_ofertas 'Numero de Ofertas', of_litros 'Litros'
FROM Ofertas
ORDER BY Categoria;

//*View TabelaVendas
*Com esta view é possível visualizar a informação sobre as vendas
*/
CREATE OR REPLACE VIEW TabelaVendas AS
SELECT ve_id ID, ve_id_Combustivel 'ID Combustivel',
ve_taxa_iva 'Taxa de Iva', ve_litros 'Litros',
ve_custo 'Custo', ve_data_venda 'Data de Venda', ve_id_colaborador 'Id Colaborador'
FROM Vendas;

/*View TabelaFaturacao
*Com esta view é possível visualizar as informações sobre as faturações
*/
CREATE OR REPLACE VIEW TabelaFaturacao AS
SELECT fa_id ID, fa_custo_total 'Custo Total',
fa_data Data, fa_iva Iva, fa_ve_id 'ID Venda', fa_estado 'Estado'
FROM Faturacao;

/*View TabelaClienteVenda
*Com esta view é possível visualizar as informações sobre a tabela cliente vendas
*/
CREATE OR REPLACE VIEW TabelaClienteVenda AS
SELECT cv_cliente_id 'Id Cliente', cv_vendas_id'Id Venda'
FROM clientevendas
ORDER BY cv_cliente_id;

/*View TabelaVendaOferta
*Com esta view é possível visualizar as informações sobre a tabela venda Oferta
*/
CREATE OR REPLACE VIEW TabelaVendaOferta AS
SELECT vo_vendas_id 'Id Venda', vo_ofertas_id'Id Oferta'
FROM vendasofertas
ORDER BY vo_vendas_id;

/*View OfertaMenosProcurada
*Com esta view é possível visualizar as ofertas menos vendidas 
*/
CREATE OR REPLACE VIEW OfertaMenosProcurada AS
SELECT DISTINCT of_nome 'Nome', COUNT(vo_ofertas_id) 'Numero de Ofertas Vendidas'
FROM Ofertas
INNER JOIN VendasOfertas
ON of_id = vo_ofertas_id
GROUP BY vo_ofertas_id
HAVING COUNT(*) > 0
ORDER BY COUNT(vo_ofertas_id) ASC
LIMIT 5;
 
 /*View nr_oferta_cliente
*Com esta view é possível visualizar todos os clientes, quantas faturas existem em seu nome, o total com iva e sem iva. 
*/
CREATE OR REPLACE VIEW nr_fatura_cliente AS
 SELECT cli_nome 'Nome', COUNT(cv_cliente_id) 'Numero de Faturas', SUM(fa_custo_total) 'Total Com Iva', (SUM(fa_custo_total) - SUM(fa_iva)) AS 'Total Sem Iva'  
 FROM cliente
 INNER JOIN clientevendas
 ON cli_id = cv_cliente_id
 INNER JOIN faturacao
 ON fa_ve_id = cv_vendas_id
 GROUP BY cli_nome
 ORDER BY cli_nome ASC;
	
/************************STORED PROCEDURES***************************************/

/*Procedure registar_cliente
*Stored Procedure que permite registar clientes de modo a que nenhum valor fique a null
*/
DROP PROCEDURE IF EXISTS sp_registar_cliente;
DELIMITER //
CREATE PROCEDURE sp_registar_cliente (cli_nome VARCHAR(20), cli_data_registo DATE, cli_telefone INT, cli_localidade VARCHAR(25), cli_pontos int, cli_empresa VARCHAR(20),
cli_nif INT, cli_data_nascimento DATE, cli_rua VARCHAR(25), cli_nr INT, cli_andar VARCHAR(10), cli_porta VARCHAR(10), cli_codigo_postal INT)
BEGIN

IF(ISNULL(cli_andar)) THEN
SET cli_andar = 'Não Tem';
END IF;

IF(ISNULL(cli_porta)) THEN
SET cli_porta = 'Não Tem';
END IF;

INSERT INTO Cliente (cli_nome, cli_data_registo, cli_telefone, cli_localidade, cli_pontos, cli_empresa, cli_nif, cli_data_nascimento, cli_rua, cli_nr, cli_andar, cli_porta, cli_codigo_postal) values (cli_nome, cli_data_registo, cli_telefone, cli_localidade, cli_pontos, cli_empresa, cli_nif, cli_data_nascimento, cli_rua, cli_nr, cli_andar, cli_porta, cli_codigo_postal);

END//
DELIMITER ;

/*Procedure registar colaborador
*Stored Procedure que permite registar colaboradores de modo a que nenhum valor fique a null
*/
DROP PROCEDURE IF EXISTS sp_registar_colaborador;
DELIMITER //
CREATE PROCEDURE sp_registar_colaborador (col_nome VARCHAR(20), col_data_registo DATE, col_telefone INT, col_localidade VARCHAR(25), col_rua VARCHAR(25), col_nr INT, col_andar VARCHAR(10), col_porta VARCHAR(10), col_codigo_postal INT, col_data_nascimento DATE)
BEGIN

IF(ISNULL(col_andar)) THEN
SET col_andar = 'Não Tem';
END IF;

IF(ISNULL(col_porta)) THEN
SET col_porta = 'Não Tem';
END IF;

INSERT INTO Colaborador (col_nome, col_data_registo, col_telefone, col_localidade, col_rua, col_nr, col_andar, col_porta, col_codigo_postal, col_data_nascimento) values (col_nome, col_data_registo, col_telefone, col_localidade, col_rua, col_nr, col_andar, col_porta, col_codigo_postal, col_data_nascimento) ;

END//
DELIMITER ;

/*Procedure registar_forncedor
*Com este procedure conseguimos registar fornecedores
*/
DROP PROCEDURE IF EXISTS sp_registar_fornecedor;
DELIMITER //
CREATE PROCEDURE sp_registar_fornecedor(for_nome VARCHAR(20), for_data_registo DATE, for_telefone INT, for_localidade VARCHAR(25), for_empresa VARCHAR(20), for_rua VARCHAR(25), for_nr INT, for_andar VARCHAR(10), for_porta VARCHAR(10), for_codigo_postal INT)
BEGIN

IF(ISNULL(for_andar)) THEN
SET for_andar = 'Não Tem';
END IF;

IF(ISNULL(for_porta)) THEN
SET for_porta = 'Não Tem';
END IF;

INSERT INTO Fornecedor (for_nome, for_data_registo, for_telefone, for_localidade, for_empresa, for_rua, for_nr, for_andar, for_porta, for_codigo_postal) values (for_nome, for_data_registo, for_telefone, for_localidade, for_empresa, for_rua, for_nr, for_andar, for_porta, for_codigo_postal);

END //
DELIMITER ;


/*Procedure registar_combustivel
*Com este procedure conseguimos registar combustiveis
*/
DROP PROCEDURE IF EXISTS sp_registar_combustivel;
DELIMITER //
CREATE PROCEDURE sp_registar_combustivel(co_custo_litro DOUBLE(16,2), co_nome VARCHAR(20), co_fornecedor_id INT, co_stockRecebido INT)
BEGIN

DECLARE ID INT;
DECLARE stock INT;
DECLARE estado VARCHAR(20);

SELECT for_estado INTO estado FROM fornecedor WHERE for_id = co_fornecedor_id;

IF(estado = 'Inativo' OR ISNULL(estado)) THEN

SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Fornecedor Inativo ou inexistente, não pode adicionar fatura`,
    MYSQL_ERRNO = `erron`;
END IF;

SET ID = fu_existeCombustivel(co_nome);
SELECT co_stock INTO stock FROM combustivel WHERE co_id = ID;

IF (ISNULL(ID) OR ID = '') THEN
	
    INSERT INTO Combustivel (co_custo_litro, co_nome, co_data_inicio, co_fornecedor_id, co_stock) VALUES (co_custo_litro, co_nome, CURDATE(), co_fornecedor_id, co_stockRecebido);

ELSE 

	SET co_stockRecebido = co_stockRecebido + stock;
    
	INSERT INTO Combustivel (co_custo_litro, co_nome, co_data_inicio, co_fornecedor_id, co_stock) VALUES (co_custo_litro, co_nome, CURDATE(), co_fornecedor_id, co_stockRecebido);
	
	UPDATE Combustivel
	SET co_data_fim = curdate(),
	co_stock = 0
	WHERE co_id = ID;
    
END IF;

END//
DELIMITER ;

/*Procedure registar_oferta
*Com este procedure conseguimos registar combustiveis
*/
DROP PROCEDURE IF EXISTS sp_registar_oferta;
DELIMITER //
CREATE PROCEDURE sp_registar_oferta(of_nome VARCHAR(20), of_pontos INT, of_data_inicio DATE, of_data_fim DATE, of_descricao VARCHAR(30), of_categoria VARCHAR(30), of_numero_ofertas INT, of_litros INT)
BEGIN

IF(ISNULL(of_litros)) THEN
	INSERT INTO Ofertas (of_nome, of_pontos, of_data_inicio, of_data_fim, of_descricao, of_categoria, of_numero_ofertas) VALUES (of_nome, of_pontos, of_data_inicio, of_data_fim, of_descricao, of_categoria, of_numero_ofertas);

ELSE
	INSERT INTO Ofertas (of_nome, of_pontos, of_data_inicio, of_data_fim, of_descricao, of_categoria, of_litros) VALUES (of_nome, of_pontos, of_data_inicio, of_data_fim, of_descricao, of_categoria, of_litros);

END IF;
END//
DELIMITER ;

/*Procedure registar venda
* Com este procedure conseguimos registar uma venda
*/
DROP PROCEDURE IF EXISTS sp_registar_venda;
DELIMITER //
CREATE PROCEDURE sp_registar_venda(ve_id_combustivel INT, ve_litros DOUBLE(16,2), ve_custo DOUBLE(16,2), ve_id_colaboradorEntrada INT)
BEGIN

DECLARE precoLitro double;
DECLARE ve_taxa_iva DOUBLE;
DECLARE data_fim DATE;
DECLARE estado VARCHAR(20);

SET ve_taxa_iva = 0.23;

SELECT co_custo_litro INTO precoLitro FROM Combustivel WHERE co_id = ve_id_combustivel;
SELECT co_data_fim INTO data_fim FROM Combustivel WHERE co_id = ve_id_combustivel;
SELECT col_estado INTO estado FROM colaborador WHERE col_id = ve_id_colaboradorEntrada;

IF (estado = 'Inativo' OR ISNULL(estado)) THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador inválido ou inexistente, escolha outro`,
    MYSQL_ERRNO = `erron`;

END IF;

IF(data_fim IS NOT NULL) THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Combustivel inválido, insira outro id`,
    MYSQL_ERRNO = `erron`;
END IF;

IF(ISNULL(ve_litros) AND ISNULL(ve_custo)) THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Insira custo ou litros para continuar`,
    MYSQL_ERRNO = `erron`;
END IF;
   
IF(ISNULL(ve_litros)) THEN
	
	SET ve_litros = fu_calcula_litros(ve_custo, precoLitro, ve_taxa_iva);

END IF;
    
IF(ISNULL(ve_custo)) THEN
	SET ve_custo =fu_calcula_custo(ve_litros, precoLitro , ve_taxa_iva) ;

END IF;

UPDATE combustivel
set co_stock = co_stock - ve_litros
WHERE co_id = ve_id_combustivel;
    
INSERT INTO Vendas(ve_id_combustivel, ve_taxa_iva, ve_litros, ve_custo, ve_data_venda, ve_id_colaborador) VALUES(ve_id_combustivel, ve_taxa_iva, ve_litros, ve_custo, CURDATE(), ve_id_colaboradorEntrada);
    
END //
DELIMITER ;


/*Procedure registar_fatura
*Com este procedure conseguimos registar uma fatura
*/
DROP PROCEDURE IF EXISTS sp_registar_fatura;
DELIMITER //
CREATE PROCEDURE sp_registar_fatura(fa_ve_idEntrada INT, cliente_id INT)
BEGIN

DECLARE fa_custo_total DOUBLE;
DECLARE iva DOUBLE;
DECLARE vendas_id INT;
DECLARE estado VARCHAR(20);

SELECT cli_estado INTO estado FROM cliente WHERE cli_id = cliente_id;
SELECT ve_custo INTO fa_custo_total FROM vendas WHERE ve_id = fa_ve_idEntrada;
SELECT ve_taxa_iva INTO iva FROM vendas WHERE ve_id = fa_ve_idEntrada;
SELECT ve_id INTO vendas_id FROM vendas WHERE fa_ve_idEntrada = ve_id;

IF(estado = 'Inativo' OR ISNULL(estado)) THEN

SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente Inativo ou inexistente, não pode adicionar fatura`,
    MYSQL_ERRNO = `erron`;
END IF;

IF(ISNULL(vendas_id)) THEN
    
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Não existe venda com esse id`,
    MYSQL_ERRNO = `erron`;
    
END IF;

SET iva = iva * fa_custo_total;

INSERT INTO Faturacao (fa_custo_total, fa_data, fa_iva, fa_ve_id) values(fa_custo_total, CURDATE(), iva, fa_ve_idEntrada);

CALL sp_relacionar_clienteVenda(cliente_id, fa_ve_idEntrada);

END//
DELIMITER ;

/*Procedure relacionar_clienteVenda
*Com este procedure conseguimos relacionar um cliente com uma venda
*/
DROP PROCEDURE IF EXISTS sp_relacionar_clienteVenda;
DELIMITER //
CREATE PROCEDURE sp_relacionar_clienteVenda(cv_cliente_id INT, cv_vendas_id INT)
BEGIN

INSERT INTO ClienteVendas (cv_cliente_id, cv_vendas_id) values(cv_cliente_id, cv_vendas_id);

END//
DELIMITER ;

/*Procedure relacionar_vendaOferta
*Com este procedure conseguimos relacionar uma venda com uma oferta
*/
DROP PROCEDURE IF EXISTS sp_relacionar_vendaOferta;
DELIMITER //
CREATE PROCEDURE sp_relacionar_vendaOferta(vo_vendas_id INT, vo_ofertas_id INT)
BEGIN

DECLARE tipo VARCHAR(20);
DECLARE combVenda INT;
DECLARE litros INT;
DECLARE cliente_pontos INT;
Declare pontos INT;
DECLARE cliente_id INT;
DECLARE nr_ofertas INT;

SELECT of_categoria INTO tipo FROM ofertas WHERE vo_ofertas_id = of_id;
SELECT co_id INTO combVenda FROM combustivel INNER JOIN vendas ON ve_id = vo_vendas_id WHERE ve_id_combustivel = co_id;
SELECT of_litros INTO litros FROM ofertas WHERE vo_ofertas_id = of_id;
SELECT cli_id INTO cliente_id FROM cliente INNER JOIN vendas ON vo_vendas_id = ve_id INNER JOIN clientevendas ON cv_vendas_id = ve_id WHERE cv_cliente_id = cli_id;
SELECT cli_pontos INTO cliente_pontos FROM Cliente WHERE cli_id = cliente_id;
SELECT of_pontos INTO pontos FROM ofertas WHERE vo_ofertas_id = of_id;
SELECT of_numero_ofertas INTO nr_ofertas FROM ofertas WHERE vo_ofertas_id = of_id; 

IF((cliente_pontos - pontos) < 0) THEN
	SIGNAL SQLSTATE
		'ERR0R'
	SET
		MESSAGE_TEXT = `Não tem pontos suficientes`,
		MYSQL_ERRNO = `erron`;
        
ELSEIF(nr_ofertas = 0) THEN
	SIGNAL SQLSTATE
		'ERROR'
	SET
		MESSAGE_TEXT = `Não há stock dessa oferta`,
		MYSQL_ERRNO = `erron`; 
ELSE

	UPDATE cliente
	SET cli_pontos = cli_pontos - pontos	
	WHERE cli_id = cliente_id;
	
INSERT INTO VendasOfertas (vo_vendas_id, vo_ofertas_id) values(vo_vendas_id, vo_ofertas_id);

	IF(tipo = 'Descontos') THEN
		UPDATE combustivel
		SET co_stock = co_stock - litros
		WHERE co_id = combVenda;
        
	ELSE
		UPDATE ofertas
		SET of_numero_ofertas = of_numero_ofertas - 1
		WHERE vo_ofertas_id = of_id;

	END IF;


END IF;

END//
DELIMITER ;


/*Procedure produtos_fatura
*Com este procedure conseguimos visualizar os detalhes de uma fatura a partir do seu id
*/
DROP PROCEDURE IF EXISTS sp_produtos_fatura;
DELIMITER //
CREATE PROCEDURE sp_produtos_fatura(fatura_id INT)
BEGIN
 
DECLARE vendas_id INT;
DECLARE vo_oferta_id INT;
DECLARE fa_idGuarda INT;

SELECT fa_id INTO fa_idGuarda FROM faturacao WHERE fa_id = fatura_id;

IF(ISNULL(fa_idGuarda) OR fa_idGuarda = '') THEN

	SIGNAL SQLSTATE
		'ERROR'
	SET
		MESSAGE_TEXT = `fatura inexistente`,
		MYSQL_ERRNO = `erron`; 
        
END IF;

SELECT ve_id INTO vendas_id FROM vendas INNER JOIN faturacao ON fa_ve_id = ve_id WHERE fa_id = fatura_id; 
SELECT COUNT(vo_ofertas_id) INTO vo_oferta_id FROM vendasOfertas WHERE vo_vendas_id = vendas_id;

IF(vo_oferta_id > 0) THEN

	
	SELECT fa_id 'Id Fatura', co_nome Combustivel, ve_litros Litros, of_nome Oferta
	FROM faturacao
	INNER JOIN vendas
	ON fa_ve_id = ve_id
	INNER JOIN Combustivel
	ON ve_id_combustivel = co_id
	INNER JOIN VendasOfertas
	ON vo_vendas_id = ve_id
	INNER JOIN Ofertas
	ON vo_ofertas_id = of_id
	WHERE fa_id = fatura_id;
 
 ELSE
 
	SELECT fa_id 'Id Fatura', co_nome Combustivel, ve_litros Litros
	FROM faturacao
	INNER JOIN vendas
	ON fa_ve_id = ve_id
	INNER JOIN Combustivel
	ON ve_id_combustivel = co_id
	WHERE fa_id = fatura_id;

END IF;
    
END//
DELIMITER ;

/*Procedure listar_ofertaS_categoria
*Com este procedure conseguimos listar as ofertas por ordem de mais vendida a partir de uma categoria
*/
DROP PROCEDURE IF EXISTS sp_listar_ofertas_categoria;
DELIMITER //
CREATE PROCEDURE sp_listar_ofertas_categoria(categoria VARCHAR(20))
BEGIN
SELECT DISTINCT of_categoria Categoria, of_nome Nome, COUNT(vo_ofertas_id)'Numero de Ofertas Vendidas'
FROM Ofertas
INNER JOIN VendasOfertas
ON of_id = vo_ofertas_id
WHERE of_categoria = categoria
GROUP BY vo_ofertas_id
ORDER BY COUNT(vo_ofertas_id) DESC;

END //
DELIMITER ;

/*Procedure produtos_fatura
*Com este procedure conseguimos visualizar os detalhes de uma fatura a partir do seu id
*/
DROP PROCEDURE IF EXISTS sp_resumo_fatura;
DELIMITER //
CREATE PROCEDURE sp_resumo_fatura(fatura_id INT)
BEGIN

	SELECT fa_id 'Id Fatura',cli_nome Nome, co_nome Combustivel, ve_litros Litros, COUNT(vo_ofertas_id) 'Numero Ofertas', SUM(fa_custo_total) 'Total Com Iva', (SUM(fa_custo_total) - SUM(fa_iva)) 'Total Sem Iva', fa_estado Estado
	FROM faturacao
	INNER JOIN vendas
	ON fa_ve_id = ve_id
	INNER JOIN Combustivel
	ON ve_id_combustivel = co_id
    INNER JOIN vendasOfertas
    ON vo_vendas_id = ve_id
    INNER JOIN clientevendas
    ON cv_vendas_id = ve_id
    INNER JOIN cliente
    ON cli_id = cv_cliente_id
	WHERE fa_id = fatura_id;

END//
DELIMITER ;

/*Procedure volume_anual_mes
*Com este procedure conseguimos visualizar os detalhes de todos os meses do ultimo ano
*/
DROP PROCEDURE IF EXISTS sp_volume_anual_mes;
DELIMITER //
CREATE PROCEDURE sp_volume_anual_mes(ano DATE)
BEGIN

SELECT DISTINCT COUNT(ve_id) 'Numero Vendas', SUM(fa_iva) 'Iva Pago', (SUM(fa_custo_total) - SUM(fa_iva)) 'Total Sem Iva', SUM(fa_custo_total) 'Total Com Iva', MONTHNAME(fa_data) Mes, cli_nif Nif
FROM Cliente
INNER JOIN ClienteVendas
ON cli_id = cv_cliente_id
INNER JOIN Vendas
ON cv_vendas_id = ve_id
INNER JOIN Faturacao
ON ve_id = fa_ve_id
WHERE YEAR(fa_data) = YEAR(ano)
GROUP BY Mes;

END//
DELIMITER ;

/*Procedure remover_venda
*Com este procedure conseguimos remover uma venda e fatura se estiver associada
*/
DROP PROCEDURE IF EXISTS sp_remover_venda;
 DELIMITER //
CREATE PROCEDURE sp_remover_venda(ve_idEntrada INT)
BEGIN

DECLARE Litros DOUBLE;
DECLARE Combustivel_id INT;
DECLARE fatura_id INT;

SELECT ve_litros INTO Litros FROM Vendas WHERE ve_id = ve_idEntrada;
SELECT co_id INTO Combustivel_id FROM Combustivel INNER JOIN vendas ON co_id = ve_id_combustivel WHERE ve_id = ve_idEntrada;
SELECT fa_id INTO fatura_id FROM faturacao INNER JOIN vendas ON fa_ve_id = ve_id WHERE ve_id = ve_idEntrada;

IF(ISNULL(ve_idEntrada)) THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Insira um id valido`,
    MYSQL_ERRNO = `erron`;
END IF;
    

UPDATE combustivel 
SET co_stock = co_stock + Litros 
WHERE Combustivel_id = co_id;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM vendas WHERE ve_id = ve_idEntrada;
SET FOREIGN_KEY_CHECKS = 1;

IF (fatura_id IS NOT NULL) THEN

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM faturacao WHERE fa_id = fatura_id;
DELETE FROM vendasofertas WHERE ve_idEntrada = vo_vendas_id;
DELETE FROM clienteVendas WHERE ve_idEntrada = cv_vendas_id;
SET FOREIGN_KEY_CHECKS = 1;

END IF; 
      
END //
DELIMITER ;

/*Procedure fechar_fatura
*Com este procedure conseguimos fechar uma fatura a partir do id
*/
DROP PROCEDURE IF EXISTS sp_fechar_fatura;
DELIMITER //
CREATE PROCEDURE sp_fechar_fatura(fatura_id INT)
BEGIN

UPDATE faturacao
SET fa_estado = 'Fechado'
WHERE fa_id = fatura_id;

CALL sp_resumo_fatura(fatura_id);

END //
DELIMITER ;

/*Procedure abrir_fatura
*Com este procedure conseguimos abrir uma fatura a partir do id
*/
DROP PROCEDURE IF EXISTS sp_abrir_fatura;
DELIMITER //
CREATE PROCEDURE sp_abrir_fatura(fatura_id INT)
BEGIN

UPDATE faturacao
SET fa_estado = 'Aberta'
WHERE fa_id = fatura_id;

CALL sp_resumo_fatura(fatura_id);

END //
DELIMITER ;

/*Procedure adcionar_combustivel
*Com este procedure conseguimos adicionar mais combustivel ao que já existe */
DROP PROCEDURE IF EXISTS sp_adicionar_combustivel;
DELIMITER //
CREATE PROCEDURE sp_adicionar_combustivel(fatura_idEntrada INT, quantidade INT)
BEGIN

DECLARE estado VARCHAR(20);
DECLARE fatura_vendas_id INT;
DECLARE preco_litro double;
DECLARE taxa_iva double;
DECLARE combustivel INT;

SELECT fa_estado INTO estado FROM faturacao WHERE fa_id = fatura_idEntrada;

IF(estado = 'Fechado') THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `fatura fechada`,
    MYSQL_ERRNO = `erron`;
END IF;
    
SELECT fa_ve_id INTO fatura_vendas_id FROM faturacao WHERE fa_id = fatura_idEntrada;
SELECT co_custo_litro INTO preco_litro FROM Combustivel INNER JOIN vendas ON ve_id = fatura_vendas_id WHERE ve_id_combustivel = co_id;
SELECT ve_taxa_iva INTO taxa_iva FROM vendas WHERE ve_id = fatura_vendas_id;
SELECT co_id INTO combustivel FROM combustivel INNER JOIN vendas ON ve_id = fatura_vendas_id WHERE ve_id_combustivel = co_id;

UPDATE vendas
SET ve_litros = ve_litros + quantidade,
ve_custo = fu_calcula_custo(ve_litros, preco_litro, taxa_iva)
WHERE ve_id = fatura_vendas_id;

UPDATE combustivel
SET co_stock = co_stock - quantidade
WHERE co_id = combustivel;

END //
DELIMITER ;

/*Procedure alterar_stock_combustivel
*Com este procedure conseguimos adicionar stock a um combustivel */
DROP PROCEDURE IF EXISTS sp_alterar_stock_combustivel;
DELIMITER //
CREATE PROCEDURE sp_alterar_stock_combustivel(combustivel_id INT, quantidade INT)
BEGIN

DECLARE data DATE;
SELECT co_data_fim INTO data FROM combustivel WHERE co_id = combustivel_id;

IF(data IS NOT NULL) THEN

SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Combustivel inválido`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE combustivel
SET co_stock = co_stock + quantidade
WHERE co_id = combustivel_id;

END //
DELIMITER ;

/*Procedure remove_combustivel_fatura
*Com este procedure conseguimos remover uma quantidade de combustivel de uma fatura */
DROP PROCEDURE IF EXISTS sp_remove_combustivel_fatura;
DELIMITER //
CREATE PROCEDURE sp_remove_combustivel_fatura(fatura_idEntrada INT, quantidade INT)
BEGIN

DECLARE estado VARCHAR(20);
DECLARE fatura_vendas_id INT;
DECLARE preco_litro double;
DECLARE taxa_iva double;
DECLARE combustivel INT;
DECLARE litros INT;

SELECT fa_estado INTO estado FROM faturacao WHERE fa_id = fatura_idEntrada;


IF(estado = 'Fechado') THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `fatura fechada`,
    MYSQL_ERRNO = `erron`;
    
ELSEIF(estado = '' OR ISNULL(estado)) THEN

SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `fatura inexistente`,
    MYSQL_ERRNO = `erron`;

END IF;
    
SELECT fa_ve_id INTO fatura_vendas_id FROM faturacao WHERE fa_id = fatura_idEntrada;
SELECT co_custo_litro INTO preco_litro FROM Combustivel INNER JOIN vendas ON ve_id = fatura_vendas_id WHERE ve_id_combustivel = co_id;
SELECT ve_taxa_iva INTO taxa_iva FROM vendas WHERE ve_id = fatura_vendas_id;
SELECT co_id INTO combustivel FROM combustivel INNER JOIN vendas ON ve_id = fatura_vendas_id WHERE ve_id_combustivel = co_id;
SELECT ve_litros INTO litros FROM vendas WHERE ve_id = fatura_vendas_id;

IF((litros - quantidade) <= 0) THEN
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Quantia inválida, quantidade fica menor que 0`,
    MYSQL_ERRNO = `erron`;
END IF;

UPDATE vendas
SET ve_litros = ve_litros - quantidade,
ve_custo = fu_calcula_custo(ve_litros, preco_litro, taxa_iva)
WHERE ve_id = fatura_vendas_id;

UPDATE combustivel
SET co_stock = co_stock + quantidade
WHERE co_id = combustivel;

END //
DELIMITER ;

/*Procedure remover_oferta
*Com este procedure conseguimos remover uma oferta */
DROP PROCEDURE IF EXISTS sp_remover_oferta;
DELIMITER //
CREATE PROCEDURE sp_remover_oferta(oferta_id INT)
BEGIN

	SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM ofertas WHERE of_id = oferta_id;
    SET FOREIGN_KEY_CHECKS = 1;

END //
DELIMITER ;

/*Procedure alterar_oferta_nome
*Com este procedure conseguimos alterar o nome de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_nome;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_nome(oferta_id INT, of_nomeEntrada VARCHAR(20))
BEGIN

	UPDATE ofertas
    SET of_nome = of_nomeEntrada
    WHERE of_id = oferta_id;

END //
DELIMITER ;

/*Procedure alterar_oferta_pontos
*Com este procedure conseguimos alterar os pontos uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_pontos;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_pontos(oferta_id INT, oferta_pontos INT)
BEGIN

	UPDATE ofertas
    SET of_pontos = oferta_pontos
    WHERE of_id = oferta_id;

END //
DELIMITER ;

/*Procedure alterar_oferta_data_inicio
*Com este procedure conseguimos alterar a data inicio de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_data_inicio;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_data_inicio(oferta_id INT, oferta_data_inicio DATE)
BEGIN

DECLARE data_fim DATE;

SELECT of_data_fim INTO data_fim FROM ofertas WHERE of_id = oferta_id;

IF(oferta_data_inicio < data_fim) THEN

	UPDATE ofertas
    SET of_data_inicio = oferta_data_inicio
    WHERE of_id = oferta_id;
    
ELSE
 
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Data de inicio maior que data de fim`,
    MYSQL_ERRNO = `erron`;

END IF;

END //
DELIMITER ;

/*Procedure alterar_oferta_data_fim
*Com este procedure conseguimos alterar a data fim de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_data_fim;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_data_fim(oferta_id INT, oferta_data_fim DATE)
BEGIN

DECLARE data_inicio DATE;

SELECT of_data_inicio INTO data_inicio FROM ofertas WHERE of_id = oferta_id;

IF(oferta_data_fim > data_inicio) THEN

	UPDATE ofertas
    SET of_data_fim = oferta_data_fim
    WHERE of_id = oferta_id;
    
ELSE
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Data de fim menor que data de inicio`,
    MYSQL_ERRNO = `erron`;

END IF;

END //
DELIMITER ;

/*Procedure alterar_oferta_descricao
*Com este procedure conseguimos alterar a descricao de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_descricao;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_descricao(oferta_id INT, oferta_descricao VARCHAR(25))
BEGIN

	UPDATE ofertas
    SET of_descricao = oferta_descricao
    WHERE of_id = oferta_id;

END //
DELIMITER ;

/*Procedure alterar_oferta_categoria
*Com este procedure conseguimos alterar a categoria de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_categoria;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_categoria(oferta_id INT, oferta_categoria VARCHAR(25))
BEGIN
IF(oferta_categoria = 'Material' OR oferta_categoria = 'Descontos') THEN
	UPDATE ofertas
    SET of_categoria = oferta_categoria
    WHERE of_id = oferta_id;
    
ELSE
SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Categoria Inválida`,
    MYSQL_ERRNO = `erron`;

END IF;

END //
DELIMITER ;

/*Procedure alterar_oferta_numeroOfertas
*Com este procedure conseguimos alterar o numero de ofertas de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_numeroOfertas;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_numeroOfertas(oferta_id INT, oferta_numero INT)
BEGIN

DECLARE categoria VARCHAR(20);
SELECT of_categoria INTO categoria FROM ofertas WHERE of_id = oferta_id;

IF(categoria = 'Material') THEN

	UPDATE ofertas
    SET of_numero_ofertas = oferta_numero
    WHERE of_id = oferta_id;

ELSE

SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Oferta inválida`,
    MYSQL_ERRNO = `erron`;
    
END IF;

END //
DELIMITER ;

/*Procedure alterar_oferta_litros
*Com este procedure conseguimos alterar os litros de uma oferta */
DROP PROCEDURE IF EXISTS sp_alterar_oferta_litros;
DELIMITER //
CREATE PROCEDURE sp_alterar_oferta_litros(oferta_id INT, oferta_litros INT)
BEGIN

DECLARE categoria VARCHAR(20);
SELECT of_categoria INTO categoria FROM ofertas WHERE of_id = oferta_id;

IF(categoria = 'Descontos') THEN

	UPDATE ofertas
    SET of_litros = oferta_litros
    WHERE of_id = oferta_id;
    
ELSE
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Não pode alterar os litros desta oferta`,
    MYSQL_ERRNO = `erron`;
    
END IF;

END //
DELIMITER ;

/*Procedure remover_fatura
*Com este procedure conseguimos remover uma oferta */
DROP PROCEDURE IF EXISTS sp_remover_fatura;
DELIMITER //
CREATE PROCEDURE sp_remover_fatura(fatura_id INT)
BEGIN

DECLARE vendas_id INT;
SELECT ve_id INTO vendas_id FROM vendas INNER JOIN faturacao ON fa_ve_id = ve_id WHERE fa_id = fatura_id;

	SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM faturacao WHERE fa_id = fatura_id;
    DELETE FROM clientevendas WHERE vendas_id = cv_vendas_id;
    SET FOREIGN_KEY_CHECKS = 1;

END //
DELIMITER ;

/*Procedure remover_oferta_fatura
*Com este procedure conseguimos remover uma oferta de uma fatura */
DROP PROCEDURE IF EXISTS sp_remover_oferta_fatura;
DELIMITER //
CREATE PROCEDURE sp_remover_oferta_fatura(fatura_id INT, oferta_nome VARCHAR(25))
BEGIN

DECLARE vendas_id INT;
DECLARE oferta_id VARCHAR(25);

SELECT ve_id INTO vendas_id FROM vendas INNER JOIN faturacao ON fa_ve_id = ve_id WHERE fa_id = fatura_id;
SELECT of_id INTO oferta_id FROM ofertas WHERE of_nome = oferta_nome;


	-- SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM vendasOfertas WHERE vo_ofertas_id = oferta_id AND vo_vendas_id = vendas_id;
   -- SET FOREIGN_KEY_CHECKS = 1;

END //
DELIMITER ;

/*Procedure desativar_cliente
*Com este procedure conseguimos desativar um cliente registado*/
DROP PROCEDURE IF EXISTS sp_desativar_cliente;
DELIMITER //
CREATE PROCEDURE sp_desativar_cliente(cli_idEntrada INT)
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_estado = 'Inativo'
WHERE cli_id = cli_idEntrada;

END //
DELIMITER ;

/*Procedure ativar_cliente
*Com este procedure conseguimos ativar um cliente registado */
DROP PROCEDURE IF EXISTS sp_ativar_cliente;
DELIMITER //
CREATE PROCEDURE sp_ativar_cliente(cli_idEntrada INT)
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_estado = 'Ativo'
WHERE cli_id = cli_idEntrada;

END //
DELIMITER ;

/*Procedure desativar_colaborador
*Com este procedure conseguimos desativar um colaborador*/
DROP PROCEDURE IF EXISTS sp_desativar_colaborador;
DELIMITER //
CREATE PROCEDURE sp_desativar_colaborador(col_idEntrada INT)
BEGIN

DECLARE colaborador_id INT;
SELECT col_id INTO colaborador_id FROM colaborador WHERE col_id = col_idEntrada;

IF(ISNULL(colaborador_id) OR colaborador_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE colaborador
SET col_estado = 'Inativo'
WHERE col_id = col_idEntrada;

END //
DELIMITER ;

/*Procedure ativar_colaborador
*Com este procedure conseguimos ativar um colaborador registado */
DROP PROCEDURE IF EXISTS sp_ativar_colaborador;
DELIMITER //
CREATE PROCEDURE sp_ativar_colaborador(col_idEntrada INT)
BEGIN

DECLARE colaborador_id INT;
SELECT col_id INTO colaborador_id FROM colaborador WHERE col_id = col_idEntrada;

IF(ISNULL(colaborador_id) OR colaborador_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE colaborador
SET col_estado = 'Ativo'
WHERE col_id = col_idEntrada;

END //
DELIMITER ;

/*Procedure desativar_fornecedor
*Com este procedure conseguimos desativar um fornecedor*/
DROP PROCEDURE IF EXISTS sp_desativar_fornecedor;
DELIMITER //
CREATE PROCEDURE sp_desativar_fornecedor(for_idEntrada INT)
BEGIN

DECLARE fornecedor_id INT;
SELECT for_id INTO fornecedor_id FROM fornecedor WHERE for_id = for_idEntrada;

IF(ISNULL(fornecedor_id ) OR fornecedor_id  = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Fornecedor inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE fornecedor
SET for_estado = 'Inativo'
WHERE for_id = for_idEntrada;

END //
DELIMITER ;

/*Procedure ativar_fornecedor
*Com este procedure conseguimos ativar um fornecedor*/
DROP PROCEDURE IF EXISTS sp_ativar_fornecedor;
DELIMITER //
CREATE PROCEDURE sp_ativar_fornecedor(for_idEntrada INT)
BEGIN

DECLARE fornecedor_id INT;
SELECT for_id INTO fornecedor_id FROM fornecedor WHERE for_id = for_idEntrada;

IF(ISNULL(fornecedor_id ) OR fornecedor_id  = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Fornecedor inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE fornecedor
SET for_estado = 'Ativo'
WHERE for_id = for_idEntrada;

END //
DELIMITER ;

/*Procedure alterar_venda_combustivel
*Com este procedure é possível alterar o combustivel de uma venda a partir do seu id
*/
DROP PROCEDURE IF EXISTS sp_alterar_venda_combustivel;
DELIMITER //
CREATE PROCEDURE sp_alterar_venda_combustivel(venda_id INT, combustivel_id INT)
BEGIN

DECLARE data DATE;
DECLARE v_id INT;
SELECT co_data_fim INTO data FROM combustivel WHERE co_id = combustivel_id;
SELECT ve_id INTO v_id FROM vendas WHERE ve_id = venda_id;

IF(ISNULL(v_id)) THEN
 SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `venda Invalida`,
    MYSQL_ERRNO = `erron`;
END IF;

IF(data IS NOT NULL) THEN
 SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Combustivel Invalido`,
    MYSQL_ERRNO = `erron`;

END IF;

UPDATE vendas
SET ve_id_combustivel = combustivel_id
WHERE ve_id = venda_id;

END//
DELIMITER ;

/*Procedure alterar_venda_colaborador
*Com este procedure é possível alterar o colaborador de uma venda a partir do seu id
*/
DROP PROCEDURE IF EXISTS sp_alterar_venda_colaborador;
DELIMITER //
CREATE PROCEDURE sp_alterar_venda_colaborador(venda_id INT, colaborador_id INT)
BEGIN

DECLARE c_id INT;
DECLARE v_id INT;

SELECT col_id INTO c_id FROM colaborador WHERE col_id = colaborador_id;
SELECT ve_id INTO v_id FROM vendas WHERE ve_id = venda_id;

IF(ISNULL(v_id)) THEN
 SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `venda Invalida`,
    MYSQL_ERRNO = `erron`;
END IF;

IF(ISNULL(c_id) OR c_id = '') THEN
 SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador Inexistente`,
    MYSQL_ERRNO = `erron`;

END IF;

UPDATE vendas
SET ve_id_colaborador = colaborador_id
WHERE ve_id = venda_id;

END//
DELIMITER ;

/*Procedure alterar_venda_litros
*Com este procedure é possível alterar a quantidade de litros de combustivel de uma venda a partir do seu id
*/
DROP PROCEDURE IF EXISTS sp_alterar_venda_litros;
DELIMITER //
CREATE PROCEDURE sp_alterar_venda_litros(venda_id INT, litros INT)
BEGIN

DECLARE v_id INT;
DECLARE preco_litros INT;
DECLARE fatura_id INT;
DECLARE custo DOUBLE;
DECLARE iva DOUBLE;

SELECT ve_id INTO v_id FROM vendas WHERE ve_id = venda_id;
SELECT co_custo_litro INTO preco_litros FROM combustivel INNER JOIN vendas ON ve_id = venda_id WHERE ve_id_combustivel = co_id;
SELECT fa_id INTO fatura_id FROM faturacao WHERE fa_ve_id = venda_id;
SELECT ve_taxa_iva INTO iva FROM vendas WHERE ve_id = venda_id;
SET custo = fu_calcula_custo(litros, preco_litros, iva);

IF(ISNULL(v_id)) THEN
 SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `venda Invalida`,
    MYSQL_ERRNO = `erron`;
END IF;


UPDATE vendas
SET ve_litros = litros, ve_custo = custo
WHERE ve_id = venda_id;

IF(fatura_id IS NOT NULL) THEN

UPDATE faturacao
SET fa_custo_total = custo
WHERE fa_id = fatura_id;

END IF;

END//
DELIMITER ;

/*Procedure alterar_venda_custo
*Com este procedure é possível alterar o custo de uma venda a partir do seu id
*/
DROP PROCEDURE IF EXISTS sp_alterar_venda_custo;
DELIMITER //
CREATE PROCEDURE sp_alterar_venda_custo(venda_id INT, custo INT)
BEGIN

DECLARE v_id INT;
DECLARE preco_litros DOUBLE;
DECLARE iva DOUBLE;
DECLARE litros INT;
DECLARE fatura_id INT;

SELECT ve_id INTO v_id FROM vendas WHERE ve_id = venda_id;
SELECT co_custo_litro INTO preco_litros FROM combustivel INNER JOIN vendas ON ve_id = venda_id WHERE ve_id_combustivel = co_id;
SELECT fa_id INTO fatura_id FROM faturacao WHERE fa_ve_id = venda_id;
SELECT ve_taxa_iva INTO iva FROM vendas WHERE ve_id = venda_id;
SET litros = fu_calcula_litros(custo, preco_litros, iva);

IF(ISNULL(v_id)) THEN
 SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `venda Invalida`,
    MYSQL_ERRNO = `erron`;
END IF;


UPDATE vendas
SET ve_litros = litros, ve_custo = custo
WHERE ve_id = venda_id;

IF(fatura_id IS NOT NULL) THEN

UPDATE faturacao
SET fa_custo_total = custo
WHERE fa_id = fatura_id;

END IF;

END//

DELIMITER ;

/*Procedure alterar_cliente_nome
*Com este procedure é possível alterar o nome de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_cliente_nome;
DELIMITER //
CREATE PROCEDURE sp_alterar_cliente_nome(cli_idEntrada INT, nome VARCHAR(20))
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_nome = nome
WHERE cli_id = cli_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_cliente_telefone
*Com este procedure é possível alterar o telefone de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_cliente_telefone;
DELIMITER //
CREATE PROCEDURE sp_alterar_cliente_telefone(cli_idEntrada INT, telefone INT)
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_telefone = telefone
WHERE cli_id = cli_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_cliente_localidade
*Com este procedure é possível alterar a localidade de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_cliente_localidade;
DELIMITER //
CREATE PROCEDURE sp_alterar_cliente_localidade(cli_idEntrada INT, localidade VARCHAR(20))
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_localidade = localidade
WHERE cli_id = cli_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_cliente_empresa
*Com este procedure é possível alterar a empresa de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_cliente_empresa;
DELIMITER //
CREATE PROCEDURE sp_alterar_cliente_empresa(cli_idEntrada INT, empresa VARCHAR(20))
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_empresa = empresa
WHERE cli_id = cli_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_cliente_nif
*Com este procedure é possível alterar o nif de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_cliente_nif;
DELIMITER //
CREATE PROCEDURE sp_alterar_cliente_nif(cli_idEntrada INT, nif INT)
BEGIN

DECLARE cliente_id INT;
SELECT cli_id INTO cliente_id FROM cliente WHERE cli_id = cli_idEntrada;

IF(ISNULL(cliente_id) OR cliente_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Cliente inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE cliente
SET cli_nif = nif
WHERE cli_id = cli_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_colaborador_nome
*Com este procedure é possível alterar o nome de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_colaborador_nome;
DELIMITER //
CREATE PROCEDURE sp_alterar_colaborador_nome(col_idEntrada INT, nome VARCHAR(20))
BEGIN

DECLARE colaborador_id INT;
SELECT col_id INTO colaborador_id FROM colaborador WHERE col_id = col_idEntrada;

IF(ISNULL(colaborador_id) OR colaborador_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE colaborador
SET col_nome = nome
WHERE col_id = col_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_colaborador_telefone
*Com este procedure é possível alterar o telefone de um cliente
*/
DROP PROCEDURE IF EXISTS sp_alterar_colaborador_telefone;
DELIMITER //
CREATE PROCEDURE sp_alterar_colaborador_telefone(col_idEntrada INT, telefone INT)
BEGIN

DECLARE colaborador_id INT;
SELECT col_id INTO colaborador_id FROM colaborador WHERE col_id = col_idEntrada;

IF(ISNULL(colaborador_id) OR colaborador_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE colaborador
SET col_telefone = telefone
WHERE col_id = col_idEntrada;

END//
DELIMITER ;

/*Procedure alterar_colaborador_localidade
*Com este procedure é possível alterar a localidade de um colaborador
*/
DROP PROCEDURE IF EXISTS sp_alterar_colaborador_localidade;
DELIMITER //
CREATE PROCEDURE sp_alterar_colaborador_localidade(col_idEntrada INT, localidade VARCHAR(20))
BEGIN

DECLARE colaborador_id INT;
SELECT col_id INTO colaborador_id FROM colaborador WHERE col_id = col_idEntrada;

IF(ISNULL(colaborador_id) OR colaborador_id = '') THEN
    SIGNAL SQLSTATE
    'ERR0R'
SET
    MESSAGE_TEXT = `Colaborador inexistente`,
    MYSQL_ERRNO = `erron`;
    
END IF;

UPDATE colaborador
SET col_localidade = localidade
WHERE col_id = col_idEntrada;

END//
DELIMITER ;


/*View fatura_cliente_data
*Com esta view é possível visualizar uma fatura de um cliente, num mes, a partir do seu id e de uma data, quantas faturas existem em seu nome, o total com iva e sem iva. 
*/
DROP PROCEDURE IF EXISTS sp_fatura_cliente_data;
DELIMITER //
CREATE PROCEDURE sp_fatura_cliente_data(data DATE, cliente_id INT)
BEGIN

SELECT cli_nome 'Nome', COUNT(cv_cliente_id) 'Numero de Faturas', SUM(fa_custo_total) 'Total Com Iva', (SUM(fa_custo_total) - SUM(fa_iva)) AS 'Total Sem Iva'  
FROM cliente
INNER JOIN clientevendas
ON cli_id = cv_cliente_id
INNER JOIN faturacao
ON fa_ve_id = cv_vendas_id
WHERE YEAR(fa_data) = YEAR(data)
AND MONTH(fa_data) = MONTH(DATA)
AND cli_id = cliente_id; 
 
END //
DELIMITER ;

/************************STORED FUNCTIONS***************************************/

/*Function existeCombustivel
*Retorna o id do combustivel a partir do nome
*/
DROP FUNCTION IF EXISTS fu_existeCombustivel;
DELIMITER $$
CREATE FUNCTION fu_existeCombustivel(co_nomeRecebido VARCHAR(20)) 
RETURNS INT
BEGIN

DECLARE ID INT;

SELECT co_id INTO ID FROM COMBUSTIVEL WHERE co_nomeRecebido = co_nome AND ISNULL(co_data_fim);
 
RETURN ID;
END $$
DELIMITER ;
 
/*Function calculaPontos
*Retorna quantos pontos foram ganhos na venda
*/
DROP FUNCTION IF EXISTS fu_calculaPontos;
DELIMITER $$
CREATE FUNCTION fu_calculaPontos(ve_idRecebido INT) 
RETURNS INT
BEGIN

DECLARE pontos INT;
DECLARE litros DOUBLE;

SELECT ve_litros INTO litros FROM vendas WHERE ve_id = ve_idRecebido;
 
SET pontos = litros;
 
RETURN pontos;
END $$
DELIMITER ;
 
/*Function encontrarIdCliente
*Retorna Id do cliente
*/
DROP FUNCTION IF EXISTS fu_encontrarClienteId;
DELIMITER $$
CREATE FUNCTION fu_encontrarClienteId(ve_idRecebido INT) 
RETURNS INT
BEGIN

DECLARE Id INT;
SELECT cv_cliente_id INTO Id FROM clienteVendas WHERE cv_vendas_id = ve_idRecebido;

 
RETURN Id;
END $$
DELIMITER ;

/*Function calcula_sem_custo
*Calcular custo dos litros e retorna esse custo
*/
DROP FUNCTION IF EXISTS fu_calcula_custo;
DELIMITER $$
CREATE FUNCTION fu_calcula_custo(ve_litros int, co_custo_litro double, ve_taxa_iva double)
RETURNS DECIMAL(10,2)
BEGIN

DECLARE custo DECIMAL;
SET custo = ((ve_litros * co_custo_litro) * ve_taxa_iva) + (ve_litros * co_custo_litro);
RETURN custo;

END$$
    
    DELIMITER ;
    
/*Function calcula_sem_litros
* Calcular litros por custo
*/
DROP FUNCTION IF EXISTS fu_calcula_litros;
DELIMITER $$
CREATE FUNCTION fu_calcula_litros(ve_custo double, co_custo_litro double , ve_taxa_iva double)
RETURNS DECIMAL(10,2)
BEGIN

RETURN((ve_custo - (ve_custo * ve_taxa_iva)) / co_custo_litro);

END$$
    
DELIMITER ;

/************************TRIGGERS***************************************/


DROP TRIGGER IF EXISTS tr_associar_pontos;
DELIMITER $$
CREATE TRIGGER tr_associar_pontos AFTER INSERT ON clienteVendas
FOR EACH ROW
BEGIN

DECLARE pontos DOUBLE;

SET pontos = fu_calculaPontos(NEW.cv_vendas_id);

UPDATE Cliente 
SET cli_pontos = cli_pontos + pontos
WHERE cli_id = NEW.cv_cliente_id;

END $$
DELIMITER ;