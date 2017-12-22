USE pos;

/*Insererir dados na tabela Cliente*/
CALL sp_registar_cliente ('Jonas', str_to_date('2016.01.01','%Y.%m.%d'), 915152789, 'Lisboa', 500, 'Sadin', 24587915, str_to_date('1992.05.12', '%Y.%m.%d'), "Rua Alves Santos", 5, '1º','A',2500); 
CALL sp_registar_cliente ('Rui', str_to_date('2015.05.12','%Y.%m.%d'), 916243897, 'Setubal', 245, 'TerraCotaa', 45135798, str_to_date('1989.03.20', '%Y.%m.%d'), "Rua Jacinto Andrade", 7, null, null, 2900); 
CALL sp_registar_cliente ('Andre', str_to_date('2016.03.11','%Y.%m.%d'), 911892543, 'Lisboa', 458,'Landa', 29874561, str_to_date('1995.06.04', '%Y.%m.%d'), "Rua Moreira OL", 10, '2º','B',5500); 
CALL sp_registar_cliente ('Lopes', str_to_date('2015.07.20','%Y.%m.%d'), 963879534, 'Almada', 500, 'Grouje', 24587915, str_to_date('1993.10.25', '%Y.%m.%d'), "Avenida Europa", 4, '3º','C',2910); 
CALL sp_registar_cliente ('Paulo', str_to_date('2014.12.01','%Y.%m.%d'), 934587326, 'Cascais', 78, 'Kool', 13458794, str_to_date('1990.05.07', '%Y.%m.%d'), "Avenida Portal", 5, null, null, 5470); 
CALL sp_registar_cliente ('Pedro', str_to_date('2013.11.20', '%Y.%m.%d'), 925554123, 'Faro' , 90,'TicTravel', 154222,  str_to_date('1988.11.20', '%Y.%m.%d'), "Avenida Trip" , 6 , null, null, 451);
CALL sp_registar_cliente ('Jose', str_to_date('2016.01.11','%Y.%m.%d'), 910000458, 'Porto' , 545 , 'Moveit', 14587988, str_to_date('1995.10.25','%Y.%m.%d'), "Rua Jose DelWhiskey", 41, null, null, 2541 );
CALL sp_registar_cliente ('Diana', str_to_date('2014.02.21','%Y.%m.%d'), 920125487, 'Seixal', 1425, 'JabbaTaxi', 15548798, str_to_date('1980.10.05','%Y.%m.%d'), "Rua do Cavaco", 7, null, null, 2840);
CALL sp_registar_cliente ('Miguel', str_to_date('2015.03.25', '%Y.%m.%d'), 920111523, 'Corroios', 5000, 'DingDong', 14457821, str_to_date('1996.05.14','%Y.%m.%d'), "Praceta Afonso Henriques", 8 , null, null, 2694);
CALL sp_registar_cliente ('Luis', str_to_date('2013.02.09', '%Y.%m.%d'), 920113243, 'Setubal', 700, 'DingDong', 55612456, str_to_date('1994.08.14','%Y.%m.%d'), "Algum lado", 3 , null, null, 2234);
CALL sp_registar_cliente ('Petra', str_to_date('2015.12.25', '%Y.%m.%d'), 920111523, 'Angola', 5000, 'Praias', 2468123, str_to_date('1992.05.20','%Y.%m.%d'), "Rua em Africa", 2 , null, null, 0003);
CALL sp_registar_cliente ('Neo', str_to_date('1999.03.25', '%Y.%m.%d'), 920111523, 'Matrix', 5000, 'Zion', 548913256, str_to_date('1978.05.14','%Y.%m.%d'), "Unknown Street", 0 , null, null, 9999);
CALL sp_registar_cliente ('Ruben', str_to_date('2013.10.04', '%Y.%m.%d'), 920111523, 'Lisboa', 5000, 'Empresa X', 4549412, str_to_date('1993.06.24','%Y.%m.%d'), "Rua Malmeqer Nao é", 14 , null, null, 8432);
CALL sp_registar_cliente ('Carvas', str_to_date('2012.03.23', '%Y.%m.%d'), 920111523, 'Algures', 4999, 'Empresa Y', 14457821, str_to_date('1991.01.11','%Y.%m.%d'), "Planeta Escondido", 01 , null, null, 2002);
CALL sp_registar_cliente ('Polus', str_to_date('2011.02.25', '%Y.%m.%d'), 920111523, 'Loonar', 5000, 'Street' , 1466221, str_to_date('1992.05.13','%Y.%m.%d'), "Korner Surfer", 10 , null, null, 2694);
CALL sp_registar_cliente ('Romolus', str_to_date('2011.02.25', '%Y.%m.%d'), 920111523, 'Loonar', 5000, 'Street' , 10000021, str_to_date('1992.05.14','%Y.%m.%d'), "Korner Surfer", 11 , null, null, 2694);
CALL sp_registar_cliente ('Holis', str_to_date('2016.04.25', '%Y.%m.%d'), 92434433, 'Luna', 5000, 'Empresa X' , 100443321, str_to_date('1995.06.14','%Y.%m.%d'), "BLAAAA", 2 , null, null, 1294);
CALL sp_registar_cliente ('Coru', str_to_date('2016.05.20', '%Y.%m.%d'), 920124223, 'Loonar', 5000, 'Street' , 10000021, str_to_date('1994.05.14','%Y.%m.%d'), "Korner Ridge", 3 , null, null, 2645);
CALL sp_registar_cliente ('Gajo', str_to_date('2015.04.03', '%Y.%m.%d'), 923231523, 'Place', 230, 'QUALQA' , 1342400021, str_to_date('1996.02.04','%Y.%m.%d'), "Barker", 10 , null, null, 2694);
CALL sp_registar_cliente ('20Ultimo', str_to_date('2016.05.30', '%Y.%m.%d'), 91123829, 'CabouEste', 5000, 'Bica' , 10000021, str_to_date('1991.01.14','%Y.%m.%d'), "Vista de Setubal", 01 , null, null, 1900);

/*Inserir dados na tabela Colaborador*/
CALL sp_registar_colaborador ('Kore', str_to_date('2015.03.14','%Y.%m.%d'), 91458752, 'Setubal', 'Rua Super Homem', 23, '5º', 'G', 2900, str_to_date('1990.05.17','%Y.%m.%d'));
CALL sp_registar_colaborador ('Yann', str_to_date('2016.02.03','%Y.%m.%d'), 934516879, 'Montijo','Avenida Plural', 5, null, null, 4500, str_to_date('1985.10.16','%Y.%m.%d'));
CALL sp_registar_colaborador ('Karlos', str_to_date('2014.10.22','%Y.%m.%d'), 924571284,'Almada','Rua dos Peixes', 8, '1º','Esquerdo', 5400, str_to_date('1991.05.14','%Y.%m.%d'));
CALL sp_registar_colaborador ('Lara', str_to_date('2015.12.20','%Y.%m.%d'), 914758234, 'Setubal', 'Rua Destruida', 1, null, null, 2910, str_to_date('1993.04.07','%Y.%m.%d'));
CALL sp_registar_colaborador ('Mario', str_to_date('2016.04.01','%Y.%m.%d'), 916289341, 'Lisboa', 'Avenida 5 Espanha', 5, '4º', 'A', 3550, str_to_date('1991.01.08','%Y.%m.%d'));
CALL sp_registar_colaborador ('Carlos', str_to_date('2014.05.06','%Y.%m.%d'), 921458221, 'Setubal', 'Avenida Peixinho Dourado', 8, '2º', 'B', 2456, str_to_date('1992.02.12','%Y.%m.%d'));
CALL sp_registar_colaborador ('Cecilia', str_to_date('2014.11.15','%Y.%m.%d'), 921114589, 'Seixal', 'Rua D.Dinis', 5, null, null, 2458, str_to_date('1991.01.31','%Y.%m.%d'));
CALL sp_registar_colaborador ('Maró', str_to_date('2012.11.15','%Y.%m.%d'), 932312319, 'Setubal', 'Rua D.Dinas', 2, null, null, 2233, str_to_date('1991.01.04','%Y.%m.%d'));
CALL sp_registar_colaborador ('Kool', str_to_date('2014.12.12','%Y.%m.%d'), 921177489, 'Lisboa', 'Rua Repetida', 5, null, null, 2458, str_to_date('1991.01.31','%Y.%m.%d'));
CALL sp_registar_colaborador ('kola', str_to_date('2014.01.16','%Y.%m.%d'), 923232323, 'Setubal', 'Rua Sao Jaquim', 39, null, null, 2758, str_to_date('1991.03.31','%Y.%m.%d'));
CALL sp_registar_colaborador ('kolo', str_to_date('2014.02.13','%Y.%m.%d'), 921132389, 'Montijo', 'Rua Alentejo', 10, null, null, 8768, str_to_date('1991.05.31','%Y.%m.%d'));
CALL sp_registar_colaborador ('kole', str_to_date('2014.06.14','%Y.%m.%d'), 92232389, 'New York', 'Avenida Ar', 2, null, null, 2776, str_to_date('1991.04.30','%Y.%m.%d'));
CALL sp_registar_colaborador ('Paulo', str_to_date('2012.10.15','%Y.%m.%d'), 92311145, 'Seixal', 'Marques Ines', 10, null, null, 6558, str_to_date('1992.03.31','%Y.%m.%d'));
CALL sp_registar_colaborador ('Caló', str_to_date('2013.09.11','%Y.%m.%d'), 921114589, 'Lisboa', 'Rua Lopes Andrade', 7, null, null, 2468, str_to_date('1991.04.30','%Y.%m.%d'));
CALL sp_registar_colaborador ('Nocas', str_to_date('2015.12.15','%Y.%m.%d'), 921352558, 'OLE', 'Rua De Deus', 1, null, null, 1458, str_to_date('1993.03.09','%Y.%m.%d'));
CALL sp_registar_colaborador ('Tildas', str_to_date('2014.11.15','%Y.%m.%d'), 921114589, 'Seixal', 'Margem Sul', 2, null, null, 2348, str_to_date('1995.05.31','%Y.%m.%d'));
CALL sp_registar_colaborador ('Trapla', str_to_date('2012.02.27','%Y.%m.%d'), 943252239, 'Setubal', 'Rua Baixa', 1, null, null, 6666, str_to_date('1991.10.10','%Y.%m.%d'));
CALL sp_registar_colaborador ('Pinhal', str_to_date('2014.02.19','%Y.%m.%d'), 918201489, 'Montijo', 'Rua Algures', 7, null, null, 4348, str_to_date('1992.02.19','%Y.%m.%d'));
CALL sp_registar_colaborador ('Priscila', str_to_date('2014.11.15','%Y.%m.%d'), 921114589, 'Pinhal Novo', 'Rua Soma', 6, null, null, 2425, str_to_date('1993.11.12','%Y.%m.%d'));
CALL sp_registar_colaborador ('Raminho', str_to_date('2014.11.15','%Y.%m.%d'), 921114589, 'Algures', 'Rua Vida', 3, null, null, 5555, str_to_date('1994.08.24','%Y.%m.%d'));

/*Inserir dados na tabela Fornecedor*/
CALL sp_registar_fornecedor ('Luis', str_to_date('2010.05.18','%Y.%m.%d'), 916458237, 'Setubal', 'CombusAll', 'Rua dos combustiveis', 10, null, null, 3150); 
CALL sp_registar_fornecedor ('Pedro', str_to_date('2012.12.04','%Y.%m.%d'), 935761592, 'Almada', 'EnergiasVivas', 'Rua Sofle', 2, null, null, 4500);
CALL sp_registar_fornecedor ('Torin', str_to_date('2011.07.30','%Y.%m.%d'), 916732851, 'Setubal', 'LigaLeve', 'Rua Joaquem Almeida', 5,'2º','C', 5500);
CALL sp_registar_fornecedor ('Holha', str_to_date('2015.05.08','%Y.%m.%d'), 963482516, 'Almada', 'SabesCombustivel', 'Avenida Mal Me Quer', 6, '3º', 'D', 3690);
CALL sp_registar_fornecedor ('Hefe', str_to_date('2015.08.06','%Y.%m.%d'), 964829537, 'Montijo', 'MundoVerde', 'Avenida Qualquer', 8, null, null, 2350);
CALL sp_registar_fornecedor ('Ze', str_to_date('2010.11.24','%Y.%m.%d'), 924587112, 'Amora' , 'DieselLife', 'Rua Zeca Afonso', 8, null, null, 2451);
CALL sp_registar_fornecedor ('Diogo', str_to_date('2009.03.22','%Y.%m.%d'), 914567852, 'Sesimbra', 'TreeHug', 'Rua Mane', 1, null, null, 2548);
CALL sp_registar_fornecedor ('Yah', str_to_date('2008.04.21','%Y.%m.%d'), 97453735, 'Setubal', 'TreeMongered', 'Rua Kebab', 10, null, null, 0952);
CALL sp_registar_fornecedor ('Han Solo', str_to_date('2007.06.16','%Y.%m.%d'), 93423522, 'Lisboa', 'TomSavior', 'Rua vida', 2, null, null, 1092);
CALL sp_registar_fornecedor ('Lalanja Boy', str_to_date('2013.04.09','%Y.%m.%d'), 91242852, 'Algures', 'AlguresCA', 'Rua Perdida', 5, null, null, 9367);
CALL sp_registar_fornecedor ('Carto', str_to_date('2010.02.10','%Y.%m.%d'), 932527852, 'Cevilha', 'SpanCompany', 'La Rua Rua', 34, null, null, 1528);
CALL sp_registar_fornecedor ('Yur', str_to_date('2011.08.25','%Y.%m.%d'), 939478278, 'Pertinho', 'Kiirmon', 'Rua Francesa', 54, null, null, 2111);
CALL sp_registar_fornecedor ('Yomcha', str_to_date('2007.01.10','%Y.%m.%d'), 96323232, 'Cidade', 'Polis', 'Rua Polis', 14, null, null, 1248);
CALL sp_registar_fornecedor ('Goku', str_to_date('2010.05.10','%Y.%m.%d'), 9163473, 'Pinhal Novo', 'World', 'Rua World', 19, null, null, 4923);
CALL sp_registar_fornecedor ('Freeza', str_to_date('2001.10.22','%Y.%m.%d'), 91434645, 'Nave Espacial', 'Freeza Company', 'Desconhecida', 0, null, null, 1001);
CALL sp_registar_fornecedor ('Satan', str_to_date('2004.06.16','%Y.%m.%d'), 92131852, 'Nameque', 'SatanEmprsa', 'Rua Nameque', 12, null, null, 1123);
CALL sp_registar_fornecedor ('Trolha', str_to_date('2014.01.21','%Y.%m.%d'), 914522852, 'Sesimbra', 'Pelota', 'Rua Pelota', 11, null, null, 1156);
CALL sp_registar_fornecedor ('Robulha', str_to_date('2012.10.10','%Y.%m.%d'), 95353852, 'Montijo', 'Arbore', 'Rua Arbore', 12, null, null, 2382);
CALL sp_registar_fornecedor ('Marques', str_to_date('2011.12.01','%Y.%m.%d'), 9525353, 'Setubal', 'Flore', 'Rua Flore', 13, null, null, 2313);
CALL sp_registar_fornecedor ('Fornecedor', str_to_date('2010.12.17','%Y.%m.%d'), 91213852, 'Alcacer', 'Penoi', 'Rua Penoi', 16, null, null, 1252);

/*Inserir dados na tabela Combustivel*/
CALL sp_registar_combustivel (1.24, 'Gasolina 95', 1, 400);
CALL sp_registar_combustivel (0.99, 'Gasoleo', 2, 90000);
CALL sp_registar_combustivel (1.20, 'Gasolina 95', 5, 90000);
CALL sp_registar_combustivel (1.40, 'Gasolina 98', 3, 90000);

/*Inserir dados na tabela Ofertas*/
CALL sp_registar_oferta ('Bicicleta 110', 5000, str_to_date('2016.01.05','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Bicicleta todo terreno', 'Material', 20, null);
CALL sp_registar_oferta ('Apito', 100, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Faz barulho', 'Material', 100, null);
CALL sp_registar_oferta ('Porta Chaves', 150, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Decoracao', 'Material', 100, null);
CALL sp_registar_oferta ('Peluche', 800, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Fofo', 'Material', 100, null);
CALL sp_registar_oferta ('DVD', 400, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Filme à escolha', 'Material', 100, null);
CALL sp_registar_oferta ('Livro', 400, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Livro à escolha', 'Material', 100, null);
CALL sp_registar_oferta ('Cafe', 50, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Café', 'Material', 10000, null);
CALL sp_registar_oferta ('Pequeno-Almoço', 200, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Pequeno Almoço', 'Material', 1000, null);
CALL sp_registar_oferta ('Gelado', 150, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Gelado à escolha', 'Material', 1000, null);
CALL sp_registar_oferta ('Cenas', 990, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Cenas', 'Material', 200, null);
CALL sp_registar_oferta ('Magic Sword', 99999, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Espada Magica!', 'Material', 1, null);
CALL sp_registar_oferta ('Carro', 99999999, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Megan Prateado', 'Material', 5, null);
CALL sp_registar_oferta ('Portal', 500, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Portal para local', 'Material', 2, null);
CALL sp_registar_oferta ('Jogo', 15000, str_to_date('2016.03.20','%Y.%m.%d'), str_to_date('2016.05.20','%Y.%m.%d'), 'Jogo à escolha', 'Material', 1000, null);
CALL sp_registar_oferta ('5 Litros',  450, str_to_date('2016.01.01','%Y.%m.%d'), str_to_date('2016.05.01','%Y.%m.%d'), 'Gasolina 95 5 Litros', 'Descontos', null, 5);
CALL sp_registar_oferta ('10 Litros', 900, str_to_date('2016.01.15','%Y.%m.%d'), str_to_date('2016.06.01','%Y.%m.%d'), 'Gasolina 95 10 Litros', 'Descontos', null, 10);
CALL sp_registar_oferta ('10 Litros', 900, str_to_date('2016.01.15','%Y.%m.%d'), str_to_date('2016.06.01','%Y.%m.%d'), 'Gasoleo 5 Litros', 'Descontos', null, 5);
CALL sp_registar_oferta ('10 Litros', 800, str_to_date('2016.02.01','%Y.%m.%d'), str_to_date('2016.06.01','%Y.%m.%d'), 'Gasoleo 10 Litros', 'Descontos', null, 10);
CALL sp_registar_oferta ('10 Litros', 900, str_to_date('2016.01.15','%Y.%m.%d'), str_to_date('2016.06.01','%Y.%m.%d'), 'Gasolina 98 10 Litros', 'Descontos', null, 10);
CALL sp_registar_oferta ('5 Litros', 450, str_to_date('2016.01.15','%Y.%m.%d'), str_to_date('2016.06.01','%Y.%m.%d'), 'Gasolina 98 5 Litros', 'Descontos', null, 5);

/*Inserir dados na tabela Vendas*/
CALL sp_registar_venda (2, 15, null, 1);
CALL sp_registar_venda (2, 14, null, 2);
CALL sp_registar_venda (4, null, 10.0, 3);
CALL sp_registar_venda (3, 20, null, 1);
CALL sp_registar_venda (4, null, 10, 2);
CALL sp_registar_venda (3, null, 15, 10);
CALL sp_registar_venda (3, 8, null, 15);
CALL sp_registar_venda (4, 10, null, 13);
CALL sp_registar_venda (3, null, 50, 9);
CALL sp_registar_venda (2, null, 35, 19);
CALL sp_registar_venda (3, 19, null, 8);
CALL sp_registar_venda (4, 5, null, 7);
CALL sp_registar_venda (2, null, 17, 9);
CALL sp_registar_venda (3, 19, null, 17);
CALL sp_registar_venda (4, null, 29, 5);
CALL sp_registar_venda (3, 48, null, 18);
CALL sp_registar_venda (3, 26, null, 15);
CALL sp_registar_venda (4, null, 10, 11);
CALL sp_registar_venda (2, 18, null, 12);
CALL sp_registar_venda (4, null, 50, 17);
CALL sp_registar_venda (3, 15, null, 10);
CALL sp_registar_venda (2, 20, null, 9);
CALL sp_registar_venda (4, null, 20, 10);
CALL sp_registar_venda (4, 2, null, 15);
CALL sp_registar_venda (4, null, 40, 12);
CALL sp_registar_venda (2, null, 30, 17);
CALL sp_registar_venda (3, 8, null, 15);
CALL sp_registar_venda (3, 15, null, 19);
CALL sp_registar_venda (3, 18, null, 16);

/*Inserir dados na tabela Faturacao e na tabela ClienteVendas*/
CALL sp_registar_fatura (1, 1);
CALL sp_registar_fatura (2, 2);
CALL sp_registar_fatura (3, 3);
CALL sp_registar_fatura (4, 4);
CALL sp_registar_fatura (5, 5);
CALL sp_registar_fatura (6, 6);
CALL sp_registar_fatura (9, 10);
CALL sp_registar_fatura (10, 10);
CALL sp_registar_fatura (11, 2);
CALL sp_registar_fatura (12, 14);
CALL sp_registar_fatura (16, 4);
CALL sp_registar_fatura (18, 5);
CALL sp_registar_fatura (20, 16);
CALL sp_registar_fatura (22, 14);
CALL sp_registar_fatura (23, 17);
CALL sp_registar_fatura (25, 1);
CALL sp_registar_fatura (27, 4);
CALL sp_registar_fatura (28, 2);
CALL sp_registar_fatura (29, 19);
CALL sp_registar_fatura (26, 9);



/*Inserir dados na tabela Vendas Ofertas*/
CALL sp_relacionar_vendaOferta (10, 2);
CALL sp_relacionar_vendaOferta (2,3);
CALL sp_relacionar_vendaOferta (1, 2);
CALL sp_relacionar_vendaOferta (2, 2);
CALL sp_relacionar_vendaOferta (3, 7);
CALL sp_relacionar_vendaOferta (4, 7);
CALL sp_relacionar_vendaOferta (5, 7);
CALL sp_relacionar_vendaOferta (6, 7);
CALL sp_relacionar_vendaOferta (7, 4);
CALL sp_relacionar_vendaOferta (8, 4);
CALL sp_relacionar_vendaOferta (8, 13);
CALL sp_relacionar_vendaOferta (9, 7);
CALL sp_relacionar_vendaOferta (10, 9);
CALL sp_relacionar_vendaOferta (10, 7);
CALL sp_relacionar_vendaOferta (12, 7);
CALL sp_relacionar_vendaOferta (15, 10);
CALL sp_relacionar_vendaOferta (17, 14);
CALL sp_relacionar_vendaOferta (19, 16);
CALL sp_relacionar_vendaOferta (22, 13);
CALL sp_relacionar_vendaOferta (23, 7);
CALL sp_relacionar_vendaOferta (24, 10);
CALL sp_relacionar_vendaOferta (24, 7);