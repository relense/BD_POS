use pos;
/* Fase 1*/
SELECT * FROM AutoridadeTributariaLoja; /* Aparece vazio porque a faturas têm a data do mes de maio e suposto aparecer a info do mes anterior*/
SELECT * FROM AutoridadeTributariaCliente; /* Aparece vazio porque a faturas têm a data do mes de maio e suposto aparecer a info do mes anterior*/
SELECT * FROM VolumeDeVendas;
SELECT * FROM NumeroOfertasPorCliente;
SELECT * FROM OfertasMaisVendidasCategoria;
SELECT * FROM OfertaMaisProcurada;
SELECT * FROM CombustivelMaisVendido;
SELECT * FROM CombustivelMenosVendido;
SELECT * FROM NVendasColaborador;
SELECT * FROM ClienteComMaisCompras;
SELECT * FROM NVendasSemCliente;
SELECT * FROM NVendasComCliente;
 
/* Fase 2*/

/* VIEWS */

/*Ver tabela cliente*/
SELECT * FROM TabelaCliente;

/*Ver tabela Colaborador*/
SELECT * FROM TabelaColaborador;

/*Ver tabela Fornecedor*/
SELECT * FROM TabelaFornecedor;

/*Ver tabela Combustivel*/
SELECT * FROM TabelaCombustivel;

/*Ver tabela ofertas*/ 
SELECT * FROM TabelaOfertas;

/*Ver tabela Vendas*/
SELECT * FROM TabelaVendas;

/*Ver tabela faturacao*/
SELECT * FROM tabelafaturacao;

/*Ver tabela clienteVendas*/
SELECT * FROM TabelaClienteVenda;

/*Ver tabela vendasOfertas*/
SELECT * FROM TabelaVendaOferta;

/*Ver clientes e quantas faturas existem e nome deles*/
SELECT * FROM nr_fatura_cliente;

/* Ver quais as ofertas menos vendidas*/
SELECT * FROM OfertaMenosProcurada;

/*  STORED PROCEDURE */


/*Registar um Cliente*/
CALL sp_registar_cliente('Rui', str_to_date('2015.05.12','%Y.%m.%d'), 916243897, 'Setubal', 245, 'TerraCotaa', 45135798, str_to_date('1989.03.20', '%Y.%m.%d'), "Rua Jacinto Andrade", 7, null, null, 2900);
SELECT * FROM TabelaCliente;

/*Registar um Colaborador*/
CALL sp_registar_colaborador('Kore', str_to_date('2015.03.14','%Y.%m.%d'), 91458752, 'Setubal', 'Rua Super Homem', 23, '5º', 'G', 2900,  str_to_date('1990.05.17','%Y.%m.%d'));
CALL sp_registar_colaborador('Kore', str_to_date('2015.03.14','%Y.%m.%d'), 91458752, 'Setubal', 'Rua Super Homem', 23, null, null, 2900,  str_to_date('1990.05.17','%Y.%m.%d'));
SELECT * FROM TabelaColaborador;

/*Registar um Fornecedor*/
CALL sp_registar_fornecedor('Luis', str_to_date('2010.05.18','%Y.%m.%d'), 916458237, 'Setubal', 'CombusAll', 'Rua dos combustiveis', 10, null, null, 3150);
SELECT * FROM TabelaFornecedor;

/*Registar um Combustivel*/
CALL sp_registar_combustivel(1.24, 'Gasolina 95', 1, 400);
CALL sp_registar_combustivel(1.24, 'Gasolina 95', 1, 400);
CALL sp_registar_combustivel(1.24, 'Gasolina 95', 1, 200);
SELECT * FROM TabelaCombustivel;

/*Registar uma Ofertas*/
CALL sp_registar_oferta('5 Litros', 300, curdate(), str_to_date('2016.05.01','%Y.%m.%d'), 'Gasolina 95 5 Litros', 'Descontos', null, 5);
SELECT * FROM TabelaOfertas;

/*Registar uma Fatura*/
CALL sp_registar_fatura (8, 5);
SELECT * FROM TabelaFaturacao;

/*Relacionar um cliente com uma venda*/
CALL sp_relacionar_clienteVenda(1,5);
SELECT * FROM ClienteVendas;

/*Relacionar uma venda com uma oferta*/
CALL sp_relacionar_vendaOferta(1, 2);
CALL sp_relacionar_vendaOferta(4, 7);
SELECT * FROM VendasOfertas;

/*Mostra os produtos associados a um id de uma fatura*/
CALL sp_produtos_fatura(2); 

/*Registar uma venda*/
CALL sp_registar_venda(4, 10, null,  3);
CALL sp_registar_venda(2, null, 20, 2);
SELECT * FROM TabelaVendas;

/*Listar as categorias por ofertas*/
CALL sp_listar_ofertas_categoria('Material');

/*Detalhes de uma fatura a partir do seu id*/
CALL sp_resumo_fatura(2);
CALL sp_resumo_fatura(3);
CALL sp_resumo_fatura(8);

/* Volume anual de vendas divido por meses*/
CALL sp_volume_anual_mes(str_to_date('2016.06.30','%Y.%m.%d'));

/*Remover uma venda a partir do seu id*/
CALL sp_remover_venda(1); 
CALL sp_remover_venda(2); 
SELECT * FROM tabelavendas;
SELECT * FROM clientevendas;
SELECT * FROM tabelafaturacao;
SELECT * FROM vendasofertas;

/*Fechar uma fatura a partir do seu id*/
CALL sp_fechar_fatura(5);
CALL sp_fechar_fatura(6);

/*Abrir uma fatura a partir do seu id*/
CALL sp_abrir_fatura(5);
CALL sp_abrir_fatura(6);
SELECT * FROM tabelafaturacao;

/*Adicionar quantidade de um combustivel a uma fatura e por consequencia a uma venda, recebe id da fatura e a quantidade de combustivel*/
CALL sp_adicionar_combustivel(3, 5);
SELECT * FROM tabelavendas;

/*Alterar o stock de um combustivel, dá-se o id e a quantidade. Só funciona se a data_fim = null*/
CALL sp_alterar_stock_combustivel(2, 200);
SELECT * FROM tabelaCombustivel;

//*Remove uma quantidade de combustivel de uma fatura, recebe o id da fatura e a quantidade a remover*/
CALL sp_remove_combustivel_fatura(3, 5);
CALL sp_resumo_fatura(3);

CALL sp_remove_combustivel_fatura(5, 2); 
CALL sp_resumo_fatura(5);

/*Remover uma oferta, recebe o id da oferta*/
CALL sp_remover_oferta(20);
CALL sp_remover_oferta(19);
SELECT * FROM tabelaOfertas;

/*Alterar nome de uma oferta*/
CALL sp_alterar_oferta_nome(1, 'OLEEEE');
SELECT * FROM tabelaOfertas;

/*Alterar pontos de uma oferta*/
CALL sp_alterar_oferta_pontos(1, 500);
SELECT * FROM tabelaOfertas;

/*Alterar data inicio de uma oferta*/
CALL sp_alterar_oferta_data_inicio(1, str_to_date('2016.05.19', '%Y.%m.%d'));
SELECT * FROM tabelaOfertas;

/*Alterar data fim de uma oferta*/
CALL sp_alterar_oferta_data_fim(1, str_to_date('2016.05.22', '%Y.%m.%d')); 
SELECT * FROM tabelaOfertas;

/*Alterar desricao de uma oferta*/
CALL sp_alterar_oferta_descricao(1, 'Cenas do Mexixo');
SELECT * FROM tabelaOfertas;

/*Alterar categoria de uma oferta*/
CALL sp_alterar_oferta_categoria(1, 'Material');
SELECT * FROM tabelaOfertas;

/*Alterar o numero de ofertas de uma oferta*/
CALL sp_alterar_oferta_numeroOfertas(1, 50);
SELECT * FROM tabelaOfertas;

/*Alterar o numero de litros de uma oferta*/
CALL sp_alterar_oferta_litros(15, 10);
SELECT * FROM tabelaOfertas;

/*Remove uma fatura, recebe o id da fatura*/
CALL sp_remover_fatura(4);
SELECT * FROM tabelafaturacao;
SELECT * FROM tabelaVendas;
SELECT * FROM clienteVendas;

/*Remove uma oferta de uma fatura, recebe o id e o nome da oferta a remover*/
CALL sp_remover_oferta_fatura(8, 'Café'); 
CALL sp_produtos_fatura(8);

/*Muda o estado de um cliente para inativo*/
CALL sp_desativar_cliente(1);
SELECT * FROM tabelaCliente;

/*Muda o estado de um cliente para ativo*/
CALL sp_ativar_cliente(1);
SELECT * FROM tabelaCliente;

/*Muda o estado de um colaborador para inativo*/
CALL sp_desativar_colaborador(2);
SELECT * FROM tabelacolaborador;

/*Muda o estado de um colaborador para ativo*/
CALL sp_ativar_colaborador(2);
SELECT * FROM tabelacolaborador;

/*Muda o estado de um fornecedor para inativo*/
CALL sp_desativar_fornecedor(1);
SELECT * FROM tabelafornecedor;

/*Muda o estado de um fornecedor para inativo*/
CALL sp_ativar_fornecedor(1);
SELECT * FROM tabelaFornecedor;

/*Alterar o combustivel de uma venda*/
CALL sp_alterar_venda_combustivel(1, 4);
SELECT * FROM tabelaVEndas;

/*Alterar o colaborador de uma venda*/
CALL sp_alterar_venda_colaborador(1, 19);
SELECT * FROM tabelaVendas;

/*Alterar litros de uma venda*/
CALL sp_alterar_venda_litros(1, 19); 
SELECT * FROM tabelaVendas;
SELECT * FROM tabelaFaturacao;

/*Alterar custo de uma venda*/
CALL sp_alterar_venda_custo(1, 40); 
SELECT * FROM tabelaVEndas;
SELECT * FROM tabelaFaturacao;


/**********ALTERAR CLIENTE***********/

/*Alterar o nome de um cliente*/
CALL sp_alterar_cliente_nome(1, 'Olee');
SELECT * FROM tabelaCliente;

/*Alterar o telefone de um cliente*/
CALL sp_alterar_cliente_telefone(1, 1111111);
SELECT * FROM tabelaCliente;

/*Alterar localidade de um cliente*/
CALL sp_alterar_cliente_localidade(1, 'VIDA');
SELECT * FROM tabelaCliente;

/*Alterar empresa de um cliente*/
CALL sp_alterar_cliente_empresa(1, 'Chato');
SELECT * FROM tabelaCliente;

/*Alterar nif de um cliente*/
CALL sp_alterar_cliente_nif(1, 222222);
SELECT * FROM tabelacliente;


/*Visualizar o numero de faturas de um cliente, a partir do seu id e de uma data*/
CALL sp_fatura_cliente_data(str_to_date('2016.06.02', '%Y.%m.%d'), 1);
CALL sp_registar_fatura(28, 1);
CALL sp_fatura_cliente_data(str_to_date('2016.06.02', '%Y.%m.%d'), 1);


/********Alterar Colaborador ***********/

/*Alterar o nome de um colaborador*/
CALL sp_alterar_colaborador_nome(1, 'OLEE');
SELECT * FROM tabelaColaborador;

/*Alterar o telefone de um colaborador*/
CALL sp_alterar_colaborador_telefone(1, 111111);
SELECT * FROM tabelacolaborador;

/*Altera a localidade de um colaborador*/
CALL sp_alterar_colaborador_localidade(1, 'CHATO');
SELECT * FROM tabelacolaborador;


/* Testar Trigger */

CALL sp_registar_fatura (24, 1);
SELECT * FROM TabelaCliente;
SELECT * FROM TabelaVendas;
SELECT * FROM tabelafaturacao;
SELECT * FROM ClienteVendas;

/************************************/