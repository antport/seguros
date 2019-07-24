-- creación de la base de datos
DROP DATABASE IF EXISTS seguros;
CREATE DATABASE seguros 
  CHARACTER SET utf8
  COLLATE utf8_spanish_ci;

USE seguros;


-- creacion de entidades

DROP DATABASE IF EXISTS aseguradoras;
CREATE TABLE aseguradoras (
idaseguradora int AUTO_INCREMENT PRIMARY KEY,
  aseguradora varchar(127),
  UNIQUE (aseguradora)

); 

DROP DATABASE IF EXISTS corredurias;
CREATE TABLE corredurias (
idcorreduria int AUTO_INCREMENT PRIMARY KEY,
  correduria varchar(127),
  tlf varchar(15),
  email varchar(127),
  UNIQUE (correduria)
); 


DROP DATABASE IF EXISTS polizas;
CREATE TABLE polizas (
  idpoliza int AUTO_INCREMENT PRIMARY KEY,
  poliza varchar (255),
  UNIQUE(poliza),
  precio float,
  idtipo int,
  ini date,
  fin date,
  contacto varchar(255),
  idaseguradora int,
  fecha date,
  idcorreduria int
  );


DROP DATABASE IF EXISTS tipos;
CREATE TABLE tipos (
  idtipo int AUTO_INCREMENT PRIMARY KEY,
  tipo varchar (255),
  UNIQUE(tipo)  
  ); 

DROP DATABASE IF EXISTS coberturas;
CREATE TABLE coberturas (
  idcobertura int AUTO_INCREMENT PRIMARY KEY,
  cobertura varchar (255),
  UNIQUE(cobertura)  
  ); 


DROP DATABASE IF EXISTS exclusiones;
CREATE TABLE exclusiones (
  idexclusion int AUTO_INCREMENT PRIMARY KEY,
  exclusion varchar (255),
  UNIQUE(exclusion)  
  ); 

-- creación de entidades relación

DROP DATABASE IF EXISTS representan;
CREATE TABLE representan (
  idaseguradora int,
  idcorreduria int,
  PRIMARY KEY (idaseguradora, idcorreduria)
  );



DROP DATABASE IF EXISTS cubren;
CREATE TABLE cubren (
  idpoliza int,
  idcobertura int,
  PRIMARY KEY (idpoliza, idcobertura),
  importe_max float
  );


DROP DATABASE IF EXISTS h_cubren;
CREATE TABLE h_cubren (
  idcobertura int,
  idtipo int,
  PRIMARY KEY ( idcobertura,idtipo)
    );

DROP DATABASE IF EXISTS h_excluyen;
CREATE TABLE h_excluyen (
  idtipo int,
  idexclusion int,
  PRIMARY KEY ( idtipo,idexclusion)
    );

DROP DATABASE IF EXISTS excluyen;
CREATE TABLE excluyen (
  idpoliza int,
  idexclusion int,
  PRIMARY KEY ( idpoliza,idexclusion)
    );





-- relación de claves foraneas

ALTER TABLE excluyen
ADD CONSTRAINT fkpolizasexcluyen FOREIGN KEY (idpoliza)
REFERENCES polizas (idpoliza),
ADD CONSTRAINT fkexclusionesexcluyen FOREIGN KEY (idexclusion)
  REFERENCES exclusiones (idexclusion);


ALTER TABLE h_excluyen
ADD CONSTRAINT fktiposh_excluyen FOREIGN KEY (idtipo)
REFERENCES tipos (idtipo),
ADD CONSTRAINT fkexclusionesh_excluyen FOREIGN KEY (idexclusion)
  REFERENCES exclusiones (idexclusion);



ALTER TABLE polizas
ADD CONSTRAINT fktipospolizas FOREIGN KEY (idtipo)
REFERENCES tipos (idtipo),
ADD CONSTRAINT fkaseguradoraspolizas FOREIGN KEY (idaseguradora)
REFERENCES aseguradoras (idaseguradora),
ADD CONSTRAINT fkcorreduriaspolizas FOREIGN KEY (idcorreduria)
REFERENCES corredurias (idcorreduria);






ALTER TABLE h_cubren
ADD CONSTRAINT fkcoberturah_cubren FOREIGN KEY (idcobertura)
REFERENCES coberturas (idcobertura),

ADD CONSTRAINT fktipos_cubren FOREIGN KEY (idtipo)
  REFERENCES tipos (idtipo);



ALTER TABLE cubren
ADD CONSTRAINT fkpolizascobren FOREIGN KEY (idpoliza)
  REFERENCES polizas (idpoliza),
ADD CONSTRAINT fkcoberturacubren FOREIGN KEY (idcobertura)
REFERENCES coberturas (idcobertura);

  







ALTER TABLE representan
ADD CONSTRAINT fkaseguradorasreprentan FOREIGN KEY (idaseguradora)
  REFERENCES aseguradoras (idaseguradora),
ADD CONSTRAINT fkcorreduriasreprensentan FOREIGN KEY (idcorreduria)
REFERENCES corredurias (idcorreduria);


