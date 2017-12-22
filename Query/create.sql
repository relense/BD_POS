DROP DATABASE IF EXISTS pos; /*Apagar a base de dados se já existir */

CREATE DATABASE pos;/*criar a base dados*/

USE pos;/* usar a base de dados*/

/*Criação da tabela dos Clientes
*Com esta vamos conseguir obter as informações necessárias sobre um cliente que esteja registo na empresa
*/
CREATE TABLE Cliente
(
	cli_id INT AUTO_INCREMENT PRIMARY KEY,
    cli_nome VARCHAR (20) NOT NULL,
    cli_data_registo DATE NOT NULL,
    cli_telefone INT NOT NULL,
    cli_localidade VARCHAR(25) NOT NULL,
    cli_pontos INT DEFAULT 0 NOT NULL,
    cli_empresa VARCHAR (20) NOT NULL,
    cli_nif INT NOT NULL,
    cli_data_nascimento DATE NOT NULL,
    cli_rua VARCHAR (25) NOT NULL,
    cli_nr INT NOT NULL,
    cli_andar VARCHAR (10),
    cli_porta VARCHAR (10),
    cli_codigo_postal INT NOT NULL,
    cli_estado VARCHAR(20) NOT NULL DEFAULT 'Ativo'
);

/*Criação da tabela dos Colaborares da empresa
*Com estava vamos conseguir obter todas as informações nessárias sobre um colaborador que trabalha estação de serviço
*/
CREATE TABLE Colaborador
(
	col_id INT AUTO_INCREMENT PRIMARY KEY,
    col_nome VARCHAR (20) NOT NULL,
    col_data_registo DATE NOT NULL,
    col_telefone INT NOT NULL,
    col_localidade VARCHAR (25) NOT NULL,
    col_rua VARCHAR (25) NOT NULL,
    col_nr INT NOT NULL,
    col_andar VARCHAR (10),
    col_porta VARCHAR (10),
    col_codigo_postal INT NOT NULL,
    col_data_nascimento DATE NOT NULL,
    col_estado VARCHAR (20) NOT NULL DEFAULT 'Ativo'
);

/*Criação da tabela dos Fornecedores
*Com estava vamos conseguir obter todas as informações nessárias sobre um fornecedor de combustivel
*/
CREATE TABLE Fornecedor
(
	for_id INT AUTO_INCREMENT PRIMARY KEY,
    for_nome VARCHAR (20) NOT NULL,
    for_data_registo DATE NOT NULL,
    for_telefone INT NOT NULL,
    for_localidade VARCHAR (25) NOT NULL,
    for_empresa VARCHAR (20) NOT NULL,
    for_rua VARCHAR (25) NOT NULL,
    for_nr INT NOT NULL,
    for_andar VARCHAR (10),
    for_porta VARCHAR (10),
    for_codigo_postal INT NOT NULL,
    for_estado VARCHAR(20) NOT NULL DEFAULT 'Ativo'
);

/*Criação da tabela Combustível
*Com esta tabela vamos saber tudo sobre o combustivel que é vendido na estação de serviço
*/
CREATE TABLE Combustivel
(
	co_id INT AUTO_INCREMENT PRIMARY KEY,
    co_custo_litro DOUBLE(16,2) NOT NULL,
    co_nome VARCHAR (20) NOT NULL,
    co_data_inicio DATE NOT NULL,
    co_data_fim DATE,
    co_fornecedor_id INT NOT NULL,
    co_stock INT NOT NULL,
    FOREIGN KEY(co_fornecedor_id)
		REFERENCES Fornecedor (for_id)
);

/*Criação da tabela Ofertas
*Com esta vamos saber tudo sobre as ofertas ofericidas aos clientes registados
*/
CREATE TABLE Ofertas
(
	of_id INT AUTO_INCREMENT PRIMARY KEY,
    of_nome VARCHAR (20) NOT NULL,
    of_pontos INT NOT NULL,
    of_data_inicio DATE NOT NULL,
    of_data_fim DATE,
    of_descricao VARCHAR (30) NOT NULL,
    of_categoria VARCHAR (20) NOT NULL,
    of_numero_ofertas INT,
    of_litros INT
);

/*Criação da tabela Vendas
*com esta tabela vamos saber tudo sobre as vendas efectuadas na estação de serviço
*/
CREATE TABLE Vendas
(
	ve_id INT AUTO_INCREMENT PRIMARY KEY,
    ve_id_combustivel INT NOT NULL,
    ve_taxa_iva DOUBLE(16,2) NOT NULL,
    ve_litros DOUBLE(16,2),
    ve_custo DOUBLE(16,2),
    ve_data_venda DATE NOT NULL,
    ve_id_colaborador INT NOT NULL,
	FOREIGN KEY(ve_id_combustivel)
		REFERENCES Combustivel(co_id),
	FOREIGN KEY(ve_id_colaborador)
		REFERENCES Colaborador(col_id)
);

/*Criacação da tabela Faturacao
*Com esta tabela vamos saber tudo sobre a faturação da estação de serviço
*/
CREATE TABLE Faturacao
(
	fa_id INT AUTO_INCREMENT PRIMARY KEY,
    fa_custo_total DOUBLE (16,2) NOT NULL,
    fa_data DATE NOT NULL,
    fa_iva DOUBLE (16,2) NOT NULL,
    fa_ve_id INT UNIQUE NOT NULL,
    fa_estado VARCHAR(20) DEFAULT 'Fechada',
    FOREIGN KEY (fa_ve_id)
		REFERENCES Vendas (ve_id)
	ON DELETE CASCADE
    
);

/*Criação da tabela Cliente
*Com esta tabela vamos saber que vendas têm cliente associado
*/
CREATE TABLE ClienteVendas
(
	cv_cliente_id INT NOT NULL,
    cv_vendas_id INT NOT NULL,
    FOREIGN KEY(cv_cliente_id)
		REFERENCES Cliente (cli_id),
	FOREIGN KEY(cv_vendas_id)
		REFERENCES Vendas (ve_id)
	ON DELETE CASCADE
);

/*Criacao da Tabela VendasOfertas
*Com esta vamos conseguir identificar as vendas que têm ofertas
*/
CREATE TABLE VendasOfertas
(
	vo_vendas_id INT NOT NULL,
    vo_ofertas_id INT NOT NULL,
    FOREIGN KEY(vo_vendas_id)
		REFERENCES Vendas (ve_id),
	FOREIGN KEY(vo_ofertas_id)
		REFERENCES Ofertas (of_id)
	ON DELETE CASCADE
);