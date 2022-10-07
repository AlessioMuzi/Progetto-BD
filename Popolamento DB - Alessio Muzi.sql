#Creazione database

CREATE SCHEMA NegozioVideogiochi;

#Creazione tabelle

CREATE TABLE cliente(
 	IdCliente	  int         AUTO_INCREMENT PRIMARY KEY,           
 	Nome          varchar(20) NOT NULL,   
 	Cognome       varchar(15) NOT NULL,  
 	TipoCliente   varchar(10) NOT NULL,   
 	CodFiscale    varchar(16) NOT NULL,    
 	Email         varchar(40) NULL,    
 	DataNascita   date        NULL,          
 	Indirizzo     varchar(40) NULL   
);


CREATE TABLE prodotto(
 	CodProd   	   varchar(10) PRIMARY KEY,
    CodSH          int         NULL REFERENCES softwareHouse(codSH),
    IdCliente      int         NULL REFERENCES cliente(IdCliente),
 	Integrità      int         NOT NULL CHECK (Integrità > 3),   
 	Prezzo         double      NOT NULL CHECK (Prezzo > 0),  
 	TipoProd       varchar(25) NOT NULL,   
 	Piattaforma    varchar(15) NULL,     
 	TipoGadget     varchar(25) NULL,          
 	Modello        varchar(25) NULL,
    Produttore     varchar(50) NULL,
    Genere         varchar(20) NULL,
    DataUscita     date        NULL,    
    AnnoProduzione date        NULL
);


CREATE TABLE documentoFiscale(
 	CodTransizione	  int    AUTO_INCREMENT PRIMARY KEY,           
 	Data              date   NOT NULL,   
 	Importo           double NOT NULL CHECK (Importo > 0) 
);


CREATE TABLE amministrazione(
 	CodFiscale	  varchar(16) PRIMARY KEY,           
 	Nome          varchar(20) NOT NULL,   
 	Cognome       varchar(15) NOT NULL,  
 	Incarico      varchar(20) NOT NULL,    
 	Email         varchar(25) NOT NULL     
);


CREATE TABLE softwareHouse(
 	CodSH    	  int         AUTO_INCREMENT PRIMARY KEY,           
 	Nazionalità   varchar(20) NULL,   
 	Via           varchar(30) NULL,  
 	Cap           varchar(5)  NULL,    
 	NumeroCivico  varchar(3)  NULL     
);


CREATE TABLE tesseraFedeltà(
 	IdTessera      int         AUTO_INCREMENT PRIMARY KEY,           
 	IdCliente       int        REFERENCES cliente(IdCliente),   
 	DataCreazione  date        NOT NULL,  
 	DataScadenza   date        NOT NULL,    
 	Livello        int         NOT NULL CHECK (Livello <= 4)     
);


CREATE TABLE evento(
 	IdEvento      int         AUTO_INCREMENT PRIMARY KEY,           
 	CodFiscale    varchar(16) NOT NULL REFERENCES amministrazione(CodFiscale),
 	Vip           varchar(50) NULL,   
 	Genere        varchar(25) NULL,
	Data          date        NOT NULL      
);


CREATE TABLE offerta(
 	CodOfferta       int         AUTO_INCREMENT PRIMARY KEY,           
 	CodFiscale       varchar(16) NOT NULL REFERENCES amministrazione(CodFiscale),
    IdTessera        int         REFERENCES tesseraFedeltà(IdTessera),   
 	DataCreazione    date        NOT NULL,  
 	DataInizio       date        NOT NULL,    
 	DataFine         date        NOT NULL,
    DataAssegnazione date        NOT NULL,
    Tipo             varchar(20) NOT NULL
);


CREATE TABLE prenota(
 	IdCliente   	  int         REFERENCES cliente(IdCliente),           
 	CodProd           varchar(10) NOT NULL REFERENCES prodotto(codProd),   
 	Quantità          int         NOT NULL,  
 	DataPrenotazione  date        NOT NULL,    
 	DataArrivo        date        NOT NULL,
    PRIMARY KEY(IdCliente, CodProd)     
);


CREATE TABLE acquista(
 	IdCliente   	  int         REFERENCES cliente(IdCliente),           
 	CodProd           varchar(10) REFERENCES prodotto(CodProd),   
 	CodTransizione    int         REFERENCES documentoFiscale(CodTransazione),  
 	Data              date NOT NULL,
	PRIMARY KEY(IdCliente, CodProd, CodTransizione)    
);


CREATE TABLE partecipa(
 	IdCliente   	  int  REFERENCES cliente(IdCliente),           
 	IdEvento          int  REFERENCES evento(IdEvento), 
     PRIMARY KEY(IdCliente, IdEvento)  
);



#Esempio di popolamento del DB

#Clienti

INSERT INTO cliente(Nome, Cognome, TipoCliente, CodFiscale, Email, DataNascita, Indirizzo) 
VALUES ("Alessio", "Muzi", "Registrato", "MZULSS00C12H211V", "muzi.ale@gmail.com", 12/03/2000, "Via Pascoli 32");
INSERT INTO cliente(Nome, Cognome, TipoCliente, CodFiscale, Email, DataNascita, Indirizzo) 
VALUES ("Francesco", "Rossi", "Generico", "SFIJVB44M60C442K", "fran1red@gmail.com", 31/12/1990, "Via D'Annunzio 20");
INSERT INTO cliente(Nome, Cognome, TipoCliente, CodFiscale, Email, DataNascita, Indirizzo) 
VALUES ("Mario", "Verdi", "Registrato", "DZCMFD47H43I984Z", "mariobro@gmail.com", 10/11/2002, "Via Tak dei Tali");
INSERT INTO cliente(Nome, Cognome, TipoCliente, CodFiscale, Email, DataNascita, Indirizzo) 
VALUES ("Mario", "Giallo", "Generico", "TCSXYO55D58C992T", "mario12@outlook.com", 21/06/2005, "Corso Largo");
INSERT INTO cliente(Nome, Cognome, TipoCliente, CodFiscale, Email, DataNascita, Indirizzo) 
VALUES ("Luigi", "Franchi", "Registrato", "HFBCQF95B07I415F", "luisfren@gmail.com", 06/02/1995, "Parco della Vittoria");
INSERT INTO cliente(Nome, Cognome, TipoCliente, CodFiscale, Email, DataNascita, Indirizzo) 
VALUES ("Giuseppe", "Bianchi", "Generico", "WYYDSK99D30C987C", "mrwhite@gmail.com", 11/04/2010, "Via Pascoli 31");

#Prodotti - Videogiochi

INSERT INTO prodotto(CodProd, CodSH, Integrità, Prezzo, TipoProd, Piattaforma, Genere, DataUscita)
VALUES("CH11JA50PQ", 1, 10, 79.90, "Videogioco", "XBox", "Sparatutto", 02/08/2022);
INSERT INTO prodotto(CodProd, CodSH, Integrità, Prezzo, TipoProd, Piattaforma, Genere, DataUscita)
VALUES("AL17TY19QZ", 2, 8, 69.90, "Videogioco", "PC", "Strategico", 11/11/2022);
INSERT INTO prodotto(CodProd, CodSH, Integrità, Prezzo, TipoProd, Piattaforma, Genere, DataUscita)
VALUES("QP11MB67LT", 3, 10, 25.99, "Videogioco", "Playstation", "GDR", 08/06/2023);

#Prodotti - Console

INSERT INTO prodotto(CodProd, Integrità, Prezzo, TipoProd, Modello, Produttore, AnnoProduzione)
VALUES("AA00GG45RT", 10, 500, "Console", "XBox Series X", "Microsoft", 01/01/2020);
INSERT INTO prodotto(CodProd, Integrità, Prezzo, TipoProd, Modello, Produttore, AnnoProduzione)
VALUES("BB01DG45SY", 10, 500, "Console", "Playstation 5", "Sony", 01/01/2020);
INSERT INTO prodotto(CodProd, Integrità, Prezzo, TipoProd, Modello, Produttore, AnnoProduzione)
VALUES("CC00GG45RZ", 5, 200, "Console", "XBox Series S", "Microsoft", 01/01/2020);

#Prodotti - Gadget

INSERT INTO prodotto(CodProd, Integrità, Prezzo, TipoProd, TipoGadget)
VALUES("AA00GG45RT", 10, 10, "Gadget", "Luce USB");
INSERT INTO prodotto(CodProd, Integrità, Prezzo, TipoProd, TipoGadget)
VALUES("AA11GG45RT", 10, 15, "Gadget", "Mouse Logitech G1");
INSERT INTO prodotto(CodProd, Integrità, Prezzo, TipoProd, TipoGadget)
VALUES("AA22GG45RT", 10, 25, "Gadget", "Cuffie Turtle Beach");

#Documenti fiscali

INSERT INTO documentoFiscale(Data, Importo)
VALUES(03/08/2022, 10);
INSERT INTO documentoFiscale(Data, Importo)
VALUES(03/10/2022, 15);
INSERT INTO documentoFiscale(Data, Importo)
VALUES(12/11/2022, 25);
INSERT INTO documentoFiscale(Data, Importo)
VALUES(03/08/2021, 69.90);
INSERT INTO documentoFiscale(Data, Importo)
VALUES(11/09/2022, 10.50);

#Amministrazione

INSERT INTO amministrazione(CodFiscale, Nome, Cognome, Incarico, Email)
VALUES("DFLBWJ67P69D133J", "Michele", "Innocente", "Commesso", "mik1998@gmail.com");
INSERT INTO amministrazione(CodFiscale, Nome, Cognome, Incarico, Email)
VALUES("STFKHH59B58A854B", "Paolo", "Innocente", "Magazziniere", "pinnocente@gmail.com");
INSERT INTO amministrazione(CodFiscale, Nome, Cognome, Incarico, Email)
VALUES("GNLCQZ79B50L605G", "Francesco", "Viola", "Proprietario", "franco.viola@gmail.com");
INSERT INTO amministrazione(CodFiscale, Nome, Cognome, Incarico, Email)
VALUES("MRKTSQ82B63C079T", "Paolo", "Montero", "Security", "mik1998@gmail.com");

#Software House
INSERT INTO softwareHouse(Nazionalità, Via, Cap, NumeroCivico)
VALUES("Francese", "Via Verga", "62012", "115");
INSERT INTO softwareHouse(Nazionalità, Via, Cap, NumeroCivico)
VALUES("Statunitense", "Via Washington", "89812", "35");
INSERT INTO softwareHouse(Nazionalità, Via, Cap, NumeroCivico)
VALUES("Giapponese", "Via Tokyo", "12467", "1");
INSERT INTO softwareHouse(Nazionalità, Via, Cap, NumeroCivico)
VALUES("Tedesca", "Parco della Vittoria", "62012", "115");
INSERT INTO softwareHouse(Nazionalità, Via, Cap, NumeroCivico)
VALUES("Italiana", "Via Verga", "11111", "56");
INSERT INTO softwareHouse(Nazionalità, Via, Cap, NumeroCivico)
VALUES("Statunitense", "Corso Umberto I", "67178", "478");

#Tessere fedeltà

INSERT INTO tesseraFedeltà(IdCliente, DataCreazione, DataScadenza, Livello)
VALUES(1, 12/11/2022, 12/11/2027, "4");
INSERT INTO tesseraFedeltà(IdCliente, DataCreazione, DataScadenza, Livello)
VALUES(3, 12/11/2022, 12/11/2027, "2");
INSERT INTO tesseraFedeltà(IdCliente, DataCreazione, DataScadenza, Livello)
VALUES(5, 12/11/2022, 12/11/2027, "0");

#Evento
INSERT INTO evento(CodFiscale, Vip, Genere, Data)
VALUES("DFLBWJ67P69D133J", "Cliff Blezisnky", "Torneo", 11/11/2022);
INSERT INTO evento(CodFiscale, Vip, Genere, Data)
VALUES("STFKHH59B58A854B2", "Hideo Kojima", "Conferenza", 08/09/2022);

#Offerta
INSERT INTO offerta(CodFiscale, IdTessera, DataCreazione, DataInizio, DataFine, DataAssegnazione, Tipo)
VALUES("GNLCQZ79B50L605G", 1, 11/11/2022, 15/11/2022, 25/11/2022, 14/11/2022, "3x2 sui gadget");
INSERT INTO offerta(CodFiscale, IdTessera, DataCreazione, DataInizio, DataFine, DataAssegnazione, Tipo)
VALUES("GNLCQZ79B50L605G", 2, 11/11/2022, 15/11/2022, 25/11/2022, 14/11/2022, "-20% su console");

#Prenota
INSERT INTO prenota(IdCliente, CodProd, Quantità, DataPrenotazione, DataArrivo)
VALUES(1, "CH11JA50PQ", 2, 02/01/2022, 01/08/2022);

#Acquista
INSERT INTO acquista(IdCliente, CodProd, CodTransizione, Data)
VALUES(1, "CH11JA50PQ", 1, 15/11/2022);
INSERT INTO acquista(IdCliente, CodProd, CodTransizione, Data)
VALUES(2, "AL17TY19QZ", 2, 15/11/2022);
INSERT INTO acquista(IdCliente, CodProd, CodTransizione, Data)
VALUES(3, "CC00GG45RZ", 3, 15/11/2022);

#Partecipa
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(1, 1);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(2, 1);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(3, 1);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(4, 1);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(1, 2);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(2, 2);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(3, 2);
INSERT INTO partecipa(IdCliente, IdEvento)
VALUES(6, 2);