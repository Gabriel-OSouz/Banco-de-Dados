CREATE SCHEMA STREAMING_PROJETO;
SET SEARCH_PATH TO STREAMING_PROJETO;

-- Criação das tabelas do banco de dados

-- Criação da entidade Pessoa
CREATE TABLE PESSOA(
		id_user DECIMAL(9) NOT NULL,
		nome CHAR(30) NOT NULL,
		email CHAR(100) NOT NULL,
		endereco CHAR(100) NOT NULL,
	    tipo CHAR(20) NOT NULL,
		CONSTRAINT CHAVEPESSOA
				PRIMARY KEY (id_user)
);

-- Criação da entidade PADRAO
CREATE TABLE PADRAO(
		id_user DECIMAL(9) NOT NULL,
		CONSTRAINT CHAVEPADRAO
				PRIMARY KEY (id_user),
		 CONSTRAINT ESTRANGEIRAPESSOA
         		FOREIGN KEY (id_user) REFERENCES PESSOA
);

-- Criação da entidade NEGOCIOS
CREATE TABLE NEGOCIOS(
		id_user DECIMAL(9) NOT NULL,
		cnpj CHAR(20) NOT NULL,
		CONSTRAINT CHAVENEGOCIOS
				PRIMARY KEY (id_user),
		CONSTRAINT ESTRANGEIRAPESSOA
         		FOREIGN KEY (id_user) REFERENCES PESSOA
);

-- Criação da entidade Artista
CREATE TABLE ARTISTA(
		nome_artista CHAR(40) NOT NULL,
		data_nasci DATE NOT NULL,
		idade DECIMAL(9) NOT NULL,
		endereco CHAR(100) NOT NULL,
		url CHAR(200),
		CONSTRAINT CHAVEARTISTA
				PRIMARY KEY (nome_artista)
);

-- Criação da entidade MUSICA
CREATE TABLE MUSICA(
	titulo_musica CHAR(100) NOT NULL, 
	ano CHAR(50) NOT NULL,
	genero CHAR(50) NOT NULL,
	exclusivo BOOLEAN NOT NULL,
	nome_artista CHAR(40) NOT NULL,
	id_user DECIMAL(9) NOT NULL,
	CONSTRAINT CHAVEMUSICA
		PRIMARY KEY (titulo_musica,nome_artista),
	CONSTRAINT ESTRANGEIRAARTISTA
		FOREIGN KEY (nome_artista) REFERENCES ARTISTA,
	CONSTRAINT ESTRANGEIRANEGOCIOS
		FOREIGN KEY (id_user) REFERENCES NEGOCIOS
);

-- Criação da entidade HIT
CREATE TABLE HIT(
	titulo_musica CHAR(100) NOT NULL,
	nome_artista CHAR(40) NOT NULL,
	CONSTRAINT CHAVEHIT
		PRIMARY KEY (titulo_musica,nome_artista),
	CONSTRAINT ESTRANGEIRAMUSICA
		FOREIGN KEY (titulo_musica,nome_artista) REFERENCES MUSICA	
);

-- Criação da entidade SINGLE
CREATE TABLE SINGLE(
	nome_artista CHAR(40) NOT NULL,
	titulo_musica CHAR(100) NOT NULL,
	CONSTRAINT CHAVESINGLE
		PRIMARY KEY (titulo_musica,nome_artista),
	CONSTRAINT ESTRANGEIRAMUSICA
		FOREIGN KEY (nome_artista,titulo_musica) REFERENCES MUSICA
);


-- Criando a entidade ALBUM
CREATE TABLE ALBUM(
	nome_album CHAR(100) NOT NULL,
	id_user DECIMAL(9) NOT NULL,
	CONSTRAINT CHAVEALBUM
		PRIMARY KEY (nome_album, id_user),
	CONSTRAINT ESTRANGEIRAALBUM
		FOREIGN KEY (id_user) REFERENCES PADRAO
);

-- Criando entidade POSSUI	
CREATE TABLE POSSUI(
	num_rastreamento DECIMAL(9) NOT NULL,
	nome_album CHAR(100) NOT NULL,
	id_user DECIMAL(9) NOT NULL,
	titulo_musica CHAR(100) NOT NULL,
	nome_artista CHAR(40) NOT NULL,
	CONSTRAINT CHAVEPOSSUI
		PRIMARY KEY (nome_album,id_user,titulo_musica,nome_artista),
	CONSTRAINT ESTRANGEIRAALBUM
		FOREIGN KEY (nome_album,id_user) REFERENCES ALBUM,
	CONSTRAINT ESTRANGEIRAHIT
		FOREIGN KEY (titulo_musica,nome_artista) REFERENCES HIT
);

-- Criação da entidade SIMILARIDADE
CREATE TABLE SIMILARIDADE(
	id_user1 DECIMAL(9) NOT NULL,
	id_user2 DECIMAL(9) NOT NULL,
	grau CHAR(20),
	CONSTRAINT CHAVESIMILARIDADE
		PRIMARY KEY (id_user1,id_user2),
	CONSTRAINT ESTRANGEIRA1
		FOREIGN KEY (id_user1) REFERENCES PADRAO,
	CONSTRAINT ESTRANGEIRA2
		FOREIGN KEY (id_user2) REFERENCES PADRAO
);

-- Criação da entidade PREMIUM 
CREATE TABLE PREMIUM(
	id_premium DECIMAL(9) NOT NULL,
	ativo BOOLEAN NOT NULL,
	CONSTRAINT CHAVEPREMIUM
		PRIMARY KEY (id_premium)
);

-- criação da entidade GRUPO
CREATE TABLE GRUPO(
	id_premium DECIMAL(9) NOT NULL,
	id_user DECIMAL(9) NOT NULL,
	CONSTRAINT CHAVEGRUPO
		PRIMARY KEY (id_premium,id_user),
	CONSTRAINT ESTRANGEIRAPREMIUM
		FOREIGN KEY (id_premium) REFERENCES PREMIUM,
	CONSTRAINT ESTRANGEIRAPADRAO
		FOREIGN KEY (id_user) REFERENCES PADRAO
);

-- criação da entidade EXCLUSIVOS
CREATE TABLE EXCLUSIVOS(
	id_premium DECIMAL(9) NOT NULL,
	titulo_musica CHAR(100) NOT NULL,
	nome_artista CHAR(40) NOT NULL,
	CONSTRAINT CHAVEEXCLUSIVOS
		PRIMARY KEY (id_premium,titulo_musica,nome_artista),
	CONSTRAINT ESTRANGEIRAPREMIUM
		FOREIGN KEY (id_premium) REFERENCES PREMIUM,
	CONSTRAINT ESTRANGEIRANOMEARTISTA
		FOREIGN KEY (titulo_musica,nome_artista) REFERENCES MUSICA
);

INSERT INTO PESSOA VALUES (441, 'Lidiana Pinheiro Assunção', 'lidianapa@gmail.com','69097-169, Rua Vivaldo Barros 100, Cidade Nova, Manaus,AM','Padrao');
INSERT INTO PESSOA VALUES (442, 'Lara Rosário Campelo', 'lararc@gmail.com','13412-467, Rua das Amburanas 1101, Bosque dos Lenheiros , Piracicaba,SP','Padrao');
INSERT INTO PESSOA VALUES (443, 'Maribel Pestana Carqueijeiro', 'maribel@gmail.com','59604-402, Vila de Socorro 653, Lagoa do Mato, Mossoró,RN','Padrao');
INSERT INTO PESSOA VALUES (444, 'Manel Lira Frade', 'manel@gmail.com','69900-475, Rua Pernambuco 15000, Bosque, Rio Branco,AC','Padrao');
INSERT INTO PESSOA VALUES (445, 'Carlota Cabreira Teodoro', 'carlota@gmail.com','78117-352, Rua das Avencas 45, Cristo Rei, Várzea Grande,MT','Padrao');
INSERT INTO PESSOA VALUES (446, 'Dafne Cavaco Quintas', 'dafnecq@gmail.com','78117-352, Rua das Avencas 90, Cristo Rei, Várzea Grande,MT','Padrao');
INSERT INTO PESSOA VALUES (447, 'Edmundo Igrejas Canário', 'edmundo@gmail.com','13412-467, Rua das Amburanas 168, Bosque dos Lenheiros , Piracicaba,SP','Padrao');
INSERT INTO PESSOA VALUES (448, 'Fabiano Brito Félix', 'fabiano@gmail.com','78117-352, Rua das Avencas 40, Cristo Rei, Várzea Grande,MT','Padrao');
INSERT INTO PESSOA VALUES (449, 'Veronika Poças Granjeiro', 'veronika@gmail.com','69900-475, Rua Pernambuco 15000, Bosque, Rio Branco,AC','Padrao');
INSERT INTO PESSOA VALUES (450, 'Gabrielly Bandeira Leiria', 'gabbl@gmail.com','13412-467, Rua das Amburanas 199, Bosque dos Lenheiros, Piracicaba,SP','Padrao');

INSERT INTO PESSOA VALUES (541, 'Franklin J. Murphy', 'Franklin@gmail.com','39765 Lane Stravenue Apt. 260 USA','Negocios');
INSERT INTO PESSOA VALUES (642, 'Sean C. Shuttleworth', 'Sean@gmail.com','45131 Stroman Road Suite 030 USA','Negocios');
INSERT INTO PESSOA VALUES (743, 'Leola B. Briner', 'Leola@gmail.com','258 McGlynn Trace Apt. 808 USA','Negocios');
INSERT INTO PESSOA VALUES (844, 'Alton M. Ellison', 'Alton@gmail.com','40154 Crooks Harbor 852 USA','Negocios');
INSERT INTO PESSOA VALUES (945, 'Janet J. Hemphill', 'Janet@gmail.com','64270 Kunze Loop 11201 USA','Negocios');
INSERT INTO PESSOA VALUES (146, 'John D. Temple', 'John@gmail.com','258 McGlynn Trace Apt. 900 USA','Negocios');
INSERT INTO PESSOA VALUES (247, 'Audrey J. Williamson', 'Audrey@gmail.com','64270 Kunze Loop 12852 CANADA','Negocios');
INSERT INTO PESSOA VALUES (348, 'Elinor W. Smith', 'Elinor@gmail.com','393 Bednar Plains 5563 USA','Negocios');
INSERT INTO PESSOA VALUES (649, 'Ralph A. Stocks', 'Ralph@gmail.com','393 Bednar Plains 7865 USA','Negocios');
INSERT INTO PESSOA VALUES (850, 'Juanita H. Salas', 'Juanita@gmail.com','258 McGlynn Trace Apt. 810 USA','Negocios');

INSERT INTO PADRAO VALUES(441);
INSERT INTO PADRAO VALUES(442);
INSERT INTO PADRAO VALUES(443);
INSERT INTO PADRAO VALUES(444);
INSERT INTO PADRAO VALUES(445);
INSERT INTO PADRAO VALUES(446);
INSERT INTO PADRAO VALUES(447);
INSERT INTO PADRAO VALUES(448);
INSERT INTO PADRAO VALUES(449);
INSERT INTO PADRAO VALUES(450);


INSERT INTO NEGOCIOS VALUES(541,'08.272.831/0001-24');
INSERT INTO NEGOCIOS VALUES(642,'55.095.457/0001-19');
INSERT INTO NEGOCIOS VALUES(743,'19.074.390/0001-72');
INSERT INTO NEGOCIOS VALUES(844,'43.203.750/0001-73');
INSERT INTO NEGOCIOS VALUES(945,'16.520.998/0001-95');
INSERT INTO NEGOCIOS VALUES(146,'59.515.216/0001-32');
INSERT INTO NEGOCIOS VALUES(247,'23.100.253/0001-32');
INSERT INTO NEGOCIOS VALUES(348,'35.508.030/0001-98');
INSERT INTO NEGOCIOS VALUES(649,'24.597.960/0001-49');
INSERT INTO NEGOCIOS VALUES(850,'45.574.942/0001-11');

INSERT INTO ARTISTA VALUES('Wayne Gretzky','03/07/1997',0,'https://www.instagram.com/wayky');
INSERT INTO ARTISTA VALUES('Julia Stiles','08/04/1961',0,'https://www.facebook.com/justilesoficial');
INSERT INTO ARTISTA VALUES('Miranda Cosgrove','02/04/1946',0,'https://www.facebook.com/mirandacos_oficial');
INSERT INTO ARTISTA VALUES('Lena Headey','04/04/1968',0,'https://www.instagram.com/lenaheadeyofc');
INSERT INTO ARTISTA VALUES('Natasha Richardson','10/04/1976',0,'https://www.facebook.com/natashaofc');
INSERT INTO ARTISTA VALUES('Gabriella Wilde','02/04/1967',0,'https://www.instagram.com/gabwild');
INSERT INTO ARTISTA VALUES('Sean Bean','07/03/1971',0,'https://www.instagram.com/seanbeanoficial');
INSERT INTO ARTISTA VALUES('Kiefer Sutherland','08/04/1990',0,'https://www.facebook.com/kefersthofc');
INSERT INTO ARTISTA VALUES('Angelina Jolie','11/06/1998',0,'https://www.facebook.com/angelinajolieofc');
INSERT INTO ARTISTA VALUES('Jay Baruchel','04/01/1969',0,'https://www.instagram.com/jaybaruchel');

INSERT INTO MUSICA VALUES('All Star','03/03/2019','Pop Internacional',TRUE,'Lena Headey',850);
INSERT INTO MUSICA VALUES('Back to Black','02/01/2020','Rock Internacional',TRUE,'Gabriella Wilde',541);
INSERT INTO MUSICA VALUES('El Justiceiro','07/07/2018','Pop Internacional',TRUE,'Lena Headey',945);
INSERT INTO MUSICA VALUES('Flor da Pele','11/01/2019','MPB',TRUE,'Lena Headey',743);
INSERT INTO MUSICA VALUES('You And I','09/07/2018','Pop Internacional',FALSE,'Gabriella Wilde',247);
INSERT INTO MUSICA VALUES('Wind Of Change (Acustica)','08/12/2021','Rock Internacional',FALSE,'Angelina Jolie',844);
INSERT INTO MUSICA VALUES('Moment Of Glory','05/06/2018','Rock Internacional',FALSE,'Angelina Jolie',146);
INSERT INTO MUSICA VALUES('Erva Venenosa','12/05/2019','MPB',FALSE,'Jay Baruchel',348);
INSERT INTO MUSICA VALUES('Pais e Filhos (Acústico)','02/01/2021','MPB',FALSE,'Julia Stiles',649);
INSERT INTO MUSICA VALUES('Quero Te Encontrar','08/04/2021','MPB',FALSE,'Jay Baruchel',850);

INSERT INTO MUSICA VALUES('Downtown','02/09/2021','Pop Internacional',TRUE,'Kiefer Sutherland',247);
INSERT INTO MUSICA VALUES('Bonekinha','08/03/2021','Pop Internacional',TRUE,'Miranda Cosgrove',649);
INSERT INTO MUSICA VALUES('Mistério do planeta','11/02/2019','MPB',FALSE,'Kiefer Sutherland',649);
INSERT INTO MUSICA VALUES('Alegria, alegria','12/06/2018','MPB',FALSE,'Natasha Richardson',348);
INSERT INTO MUSICA VALUES('Como nossos pais','04/03/2018','MPB',FALSE,'Natasha Richardson',348);
INSERT INTO MUSICA VALUES('Metamorfose ambulante','10/01/2020','MPB',FALSE,'Natasha Richardson',844);
INSERT INTO MUSICA VALUES('The Unforgiven II','01/04/2018','Rock Internacional',FALSE,'Wayne Gretzky',844);
INSERT INTO MUSICA VALUES('Fade To Black','09/02/2019','Rock Internacional',FALSE,'Wayne Gretzky',642);
INSERT INTO MUSICA VALUES('Nothing Else Matters','05/02/2021','Rock Internacional',FALSE,'Sean Bean',945);
INSERT INTO MUSICA VALUES('Dust In The Wind','04/07/2018','Rock Internacional',FALSE,'Sean Bean',247);

INSERT INTO HIT VALUES('Downtown','Kiefer Sutherland');
INSERT INTO HIT VALUES('Bonekinha','Miranda Cosgrove');
INSERT INTO HIT VALUES('Mistério do planeta','Kiefer Sutherland');
INSERT INTO HIT VALUES('Como nossos pais','Natasha Richardson');
INSERT INTO HIT VALUES('Metamorfose ambulante','Natasha Richardson');
INSERT INTO HIT VALUES('The Unforgiven II','Wayne Gretzky');
INSERT INTO HIT VALUES('Fade To Black','Wayne Gretzky');
INSERT INTO HIT VALUES('Nothing Else Matters','Sean Bean');
INSERT INTO HIT VALUES('Dust In The Wind','Sean Bean');
INSERT INTO HIT VALUES('Alegria, alegria','Natasha Richardson');

INSERT INTO SINGLE VALUES('All Star','Lena Headey');
INSERT INTO SINGLE VALUES('Back to Black','Gabriella Wilde');
INSERT INTO SINGLE VALUES('El Justiceiro','Lena Headey');
INSERT INTO SINGLE VALUES('Flor da Pele','Lena Headey');
INSERT INTO SINGLE VALUES('You And I','Gabriella Wilde');
INSERT INTO SINGLE VALUES('Wind Of Change (Acustica)','Angelina Jolie');
INSERT INTO SINGLE VALUES('Moment Of Glory','Angelina Jolie');
INSERT INTO SINGLE VALUES('Erva Venenosa','Jay Baruchel');
INSERT INTO SINGLE VALUES('Pais e Filhos (Acústico)','Julia Stiles');
INSERT INTO SINGLE VALUES('Quero Te Encontrar','Jay Baruchel');

INSERT INTO ALBUM VALUES('ALBUM LEGAL',441);
INSERT INTO ALBUM VALUES('ALBUM LOUCO',442);
INSERT INTO ALBUM VALUES('AS MELLHORES',443);
INSERT INTO ALBUM VALUES('MUSICAS BOAS',444);
INSERT INTO ALBUM VALUES('CORRIDA MATINAL',445);
INSERT INTO ALBUM VALUES('TREINO BOM',446);
INSERT INTO ALBUM VALUES('PENSAMENTOS LEGAIS',447);
INSERT INTO ALBUM VALUES('PLAYLIST CHUVA',448);
INSERT INTO ALBUM VALUES('ANOS 2000',449);
INSERT INTO ALBUM VALUES('DIVERSÃO IMENSA',450);

INSERT INTO POSSUI VALUES(1520,'ALBUM LEGAL',441,'Downtown','Kiefer Sutherland');
INSERT INTO POSSUI VALUES(1521,'ALBUM LOUCO',442,'Bonekinha','Miranda Cosgrove');
INSERT INTO POSSUI VALUES(1522,'AS MELLHORES',443,'Mistério do planeta','Kiefer Sutherland');
INSERT INTO POSSUI VALUES(1523,'MUSICAS BOAS',444,'Downtown','Kiefer Sutherland');
INSERT INTO POSSUI VALUES(1524,'CORRIDA MATINAL',445,'Mistério do planeta','Kiefer Sutherland');
INSERT INTO POSSUI VALUES(1525,'TREINO BOM',446,'Fade To Black','Wayne Gretzky');
INSERT INTO POSSUI VALUES(1526,'PENSAMENTOS LEGAIS',447,'Alegria, alegria','Natasha Richardson');
INSERT INTO POSSUI VALUES(1527,'PLAYLIST CHUVA',448,'Dust In The Wind','Sean Bean');
INSERT INTO POSSUI VALUES(1528,'ANOS 2000',449,'The Unforgiven II','Wayne Gretzky');
INSERT INTO POSSUI VALUES(1529,'DIVERSÃO IMENSA',450,'Alegria, alegria','Natasha Richardson');

INSERT INTO SIMILARIDADE VALUES(441,450);
INSERT INTO SIMILARIDADE VALUES(450,442);
INSERT INTO SIMILARIDADE VALUES(442,444);
INSERT INTO SIMILARIDADE VALUES(441,447);
INSERT INTO SIMILARIDADE VALUES(445,446);
INSERT INTO SIMILARIDADE VALUES(449,448);
INSERT INTO SIMILARIDADE VALUES(441,446);
INSERT INTO SIMILARIDADE VALUES(447,443);
INSERT INTO SIMILARIDADE VALUES(444,443);
INSERT INTO SIMILARIDADE VALUES(441,449);

INSERT INTO PREMIUM VALUES(4560,TRUE);
INSERT INTO PREMIUM VALUES(4561,TRUE);
INSERT INTO PREMIUM VALUES(4562,TRUE);
INSERT INTO PREMIUM VALUES(4563,TRUE);
INSERT INTO PREMIUM VALUES(4564,TRUE);
INSERT INTO PREMIUM VALUES(4565,TRUE);
INSERT INTO PREMIUM VALUES(4566,FALSE);
INSERT INTO PREMIUM VALUES(4567,FALSE);
INSERT INTO PREMIUM VALUES(4568,TRUE);
INSERT INTO PREMIUM VALUES(4569,TRUE);

INSERT INTO GRUPO VALUES(4560,441);
INSERT INTO GRUPO VALUES(4561,442);
INSERT INTO GRUPO VALUES(4562,450);
INSERT INTO GRUPO VALUES(4563,443);
INSERT INTO GRUPO VALUES(4564,450);
INSERT INTO GRUPO VALUES(4565,446);
INSERT INTO GRUPO VALUES(4566,449);
INSERT INTO GRUPO VALUES(4567,447);
INSERT INTO GRUPO VALUES(4568,445);
INSERT INTO GRUPO VALUES(4569,449);


INSERT INTO EXCLUSIVOS VALUES(4560,'All Star','Lena Headey');
INSERT INTO EXCLUSIVOS VALUES(4561,'Back to Black','Gabriella Wilde');
INSERT INTO EXCLUSIVOS VALUES(4562,'All Star','Lena Headey');
INSERT INTO EXCLUSIVOS VALUES(4563,'Downtown','Kiefer Sutherland');
INSERT INTO EXCLUSIVOS VALUES(4564,'Downtown','Kiefer Sutherland');
INSERT INTO EXCLUSIVOS VALUES(4565,'Downtown','Kiefer Sutherland');
INSERT INTO EXCLUSIVOS VALUES(4566,'Downtown','Kiefer Sutherland');
INSERT INTO EXCLUSIVOS VALUES(4567,'Bonekinha','Miranda Cosgrove');
INSERT INTO EXCLUSIVOS VALUES(4568,'All Star','Lena Headey');
INSERT INTO EXCLUSIVOS VALUES(4569,'Flor da Pele','Lena Headey');


-- Consultas

-- 1# Todos os usuários que não possuem uma conta premium
SET SEARCH_PATH TO STREAMING_PROJETO1_bd1;

SELECT DISTINCT PE.Nome
FROM PADRAO AS PA, GRUPO AS GU, PESSOA AS PE
WHERE (PE.id_user = PA.id_user) AND	
	  (PE.id_user = GU.id_user);

/*
"Gabrielly Bandeira Leiria     "
"Veronika Poças Granjeiro      "
"Carlota Cabreira Teodoro      "
"Lara Rosário Campelo          "
"Dafne Cavaco Quintas          "
"Lidiana Pinheiro Assunção     "
"Maribel Pestana Carqueijeiro  "
"Edmundo Igrejas Canário       "
*/

-- 2# Todas as músicas internacionais (independente do estilo) que tem como cantora 'Angelina Jolie'
SET SEARCH_PATH TO STREAMING_PROJETO1_bd1;
SELECT AR.nome_artista, MU.titulo_musica
FROM MUSICA AS MU, ARTISTA AS AR
WHERE 	(AR.nome_artista = MU.nome_artista) AND
		(MU.genero LIKE '%Internacional%') AND
		(MU.nome_artista = 'Angelina Jolie');

/*
"Angelina Jolie                          "	"Wind Of Change (Acustica)                                                                           "
"Angelina Jolie                          "	"Moment Of Glory                                                                                     "
*/

-- 3# Liste os nome dos artistas que nasceram antes de 1980 (em ordem alfabética) e a quantidade de hits lançados no aplicativo 
SET SEARCH_PATH TO STREAMING_PROJETO1_bd1;

SELECT HI.nome_artista,COUNT(HI.nome_artista) AS quantidade 
FROM ARTISTA AS AR, HIT AS HI
WHERE (AR.nome_artista = HI.nome_artista) AND
	  (AR.data_nasci < '01/01/1980')
GROUP BY HI.nome_artista
ORDER BY HI.nome_artista ASC;	

/*
"Miranda Cosgrove                        "	1
"Natasha Richardson                      "	3
"Sean Bean                               "	2
*/

-- 4# Nome dos artistas e o nome de todas as músicas exclusivas que foram lançadas no ano de 2021 em ordem decrescente
SET SEARCH_PATH TO STREAMING_PROJETO1_bd1;

SELECT MU.titulo_musica, AR.nome_artista
FROM MUSICA AS MU, ARTISTA AS AR
WHERE(AR.nome_artista = MU.nome_artista) AND
	 (MU.exclusivo = TRUE) AND
	 (MU.ano > '01/01/2021')
ORDER BY MU.titulo_musica DESC;

/*
"Flor da Pele  "	"Lena Headey                             "
"El Justiceiro "	"Lena Headey                             "
"Downtown      "	"Kiefer Sutherland                       "
"Bonekinha     "	"Miranda Cosgrove                        "
"Back to Black "	"Gabriella Wilde                         "
"All Star      "	"Lena Headey                             "
*/

-- 5# Nome dos Artista que pelo menos 1 HIT lançado no aplicativo
SET SEARCH_PATH TO STREAMING_PROJETO1_bd1;

SELECT  HI.nome_artista
FROM HIT AS HI
GROUP BY HI.nome_artista
HAVING COUNT(HI.titulo_musica) <= 1;

/*
"Miranda Cosgrove                        "
*/

-- 6# idade dos músicos nascidos antes de 1990 retiradas pela data de nascimento em ordem alfabética
SET SEARCH_PATH TO STREAMING_PROJETO_bd1;

SELECT AR.nome_artista AS nome,
	   AGE(CURRENT_DATE,AR.data_nasci) AS idade
FROM ARTISTA AS AR
WHERE (AR.data_nasci < '01/01/1990')
ORDER BY AR.nome_artista ASC;

/*
"Gabriella Wilde                         "	"54 years 6 mons 13 days"
"Jay Baruchel                            "	"52 years 9 mons 11 days"
"Julia Stiles                            "	"60 years 6 mons 7 days"
"Lena Headey                             "	"53 years 6 mons 11 days"
"Miranda Cosgrove                        "	"75 years 6 mons 13 days"
"Natasha Richardson                      "	"45 years 6 mons 5 days"
"Sean Bean                               "	"50 years 7 mons 8 days"
*/

-- 7# Qual o número de músicas por artista
SET SEARCH_PATH TO STREAMING_PROJETO_bd1;

SELECT MU.nome_artista, COUNT(MU.titulo_musica)
FROM ARTISTA AS AR, MUSICA AS MU
WHERE (AR.nome_artista = MU.nome_artista)
GROUP BY MU.nome_artista

/*
"Julia Stiles                            "	1
"Natasha Richardson                      "	3
"Kiefer Sutherland                       "	2
"Jay Baruchel                            "	2
"Gabriella Wilde                         "	2
"Wayne Gretzky                           "	2
"Miranda Cosgrove                        "	1
"Lena Headey                             "	3
"Angelina Jolie                          "	2
"Sean Bean                               "	2
*/

-- 8# Quais são as músicas que aparecem pelo menos 2 vezes em albums
SET SEARCH_PATH TO STREAMING_PROJETO_bd1;

SELECT PO.titulo_musica AS titulo, COUNT(PO.titulo_musica) AS Quantidade
FROM MUSICA AS MU, POSSUI AS PO
WHERE (MU.titulo_musica = PO.titulo_musica)
GROUP BY PO.titulo_musica
HAVING COUNT(MU.titulo_musica) >= 2;

/*
"Alegria, alegria    "	2
"Downtown            "	2
"Mistério do planeta "	2
*/

-- top 3 dos usuários do tipo negócios que administram mais artistas em ordem alfabética
SET SEARCH_PATH TO STREAMING_PROJETO_bd1;

SELECT DISTINCT MU.id_user, PE.nome, COUNT(MU.id_user)
FROM MUSICA AS MU, NEGOCIOS AS NE, PESSOA AS PE
WHERE (PE.id_user = NE.id_user) AND
	  (NE.id_user = MU.id_user)
GROUP BY MU.id_user, PE.nome
ORDER BY PE.nome,COUNT(MU.id_user) DESC
LIMIT 3;

/*
844	"Alton M. Ellison              "	3
247	"Audrey J. Williamson          "	3
348	"Elinor W. Smith               "	3
*/

-- 10# O artista que possui a idade mais avançada dentre os demais

SELECT AR.nome_artista AS Nome,
	   AGE(CURRENT_DATE,AR.data_nasci) AS Idade
FROM ARTISTA AS AR
GROUP BY AR.nome_artista
ORDER BY idade desc
limit 1;

/*
"Miranda Cosgrove                        "	"75 years 6 mons 13 days"
*/

-- Atualizações

-- Atualização de músicas exclusivas, nova música exclusiva 'Metamorfose ambulante'
SET SEARCH_PATH TO STREAMING_PROJETO_bd1;

UPDATE MUSICA 
SET exclusivo = TRUE
WHERE MUSICA.titulo_musica = 'Metamorfose ambulante' 

SELECT MUSICA.titulo_musica, Musica.exclusivo FROM MUSICA
WHERE MUSICA.titulo_musica = 'Metamorfose ambulante'

/* 
"Metamorfose ambulante  "	true
*/

-- Atualização de endereço e e-mail de um usuario com o id 146

UPDATE PESSOA 
SET email = 'templeJ@yahoo.com.br',
	endereco = '5941 Kristin Cliff Apt. 740 - Joplin, RI 69194' 
WHERE PESSOA.id_user = 146;

SELECT PESSOA.id_user, PESSOA.email, PESSOA.endereco
FROM PESSOA
WHERE PESSOA.id_user = 146;
