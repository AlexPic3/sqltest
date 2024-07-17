-- SCRIPT TO CREATE FIRST ALL TABLES WITHOUT CONSTRAINTS AND THEN UPDATE ALL CONSTRAINTS IN EACH NECESSARY TABLE.

/*
-- Primero desabilitar la integridad referencial 
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL' 
GO

EXEC sp_MSforeachtable @command1 = "DROP TABLE ?"

-- Ahora volver a habilitar la integridad referencial
EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL' 
GO
*/

/*IF (OBJECT_ID('dbo.FK_ConstraintName', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.TableName DROP CONSTRAINT FK_ConstraintName
END

C = CHECK constraint
D = DEFAULT (constraint or stand-alone)
F = FOREIGN KEY constraint
PK = PRIMARY KEY constraint
UQ = UNIQUE constraint

*/

USE AlexCiaVuelos;
GO


-- DELETE ALL CONSTRAINS IF EXISTS
--1
--ALTER TABLE PersonalAux DROP CONSTRAINT Fk_CategoriaPersonaAuxiliar
IF (OBJECT_ID('dbo.Fk_CategoriaPersonaAuxiliar', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.PersonalAux DROP CONSTRAINT Fk_CategoriaPersonaAuxiliar
END
GO
--2
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCoPilotoPiloto
IF (OBJECT_ID('dbo.Fk_VueloCoPilotoPiloto', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.Vuelo DROP CONSTRAINT Fk_VueloCoPilotoPiloto
END
GO
--3
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCoPilotoCopiloto
IF (OBJECT_ID('dbo.Fk_VueloCoPilotoCopiloto', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCoPilotoCopiloto
END
GO
--4
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloAvion
IF (OBJECT_ID('dbo.Fk_VueloAvion', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloAvion
END
GO
--5
--ALTER TABLE Vuelo DROP CONSTRAINT FK_VueloReserva
IF (OBJECT_ID('dbo.FK_VueloReserva', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT FK_VueloReserva
END
GO
--6
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroOrigen
IF (OBJECT_ID('dbo.Fk_VueloCiudadAeroOrigen', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroOrigen
END
GO
--7
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroDestino
IF (OBJECT_ID('dbo.Fk_VueloCiudadAeroDestino', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroDestino
END
GO
--8
--ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxVuelo
IF (OBJECT_ID('dbo.Fk_VueloPersonalAuxVuelo', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxVuelo
END
GO
--9
--ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxPersonalAux
IF (OBJECT_ID('dbo.Fk_VueloPersonalAuxPersonalAux', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxPersonalAux
END
GO
--10
--ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT Fk_VueloCategoriaAsientoVuelo
IF (OBJECT_ID('dbo.Fk_VueloCategoriaAsientoVuelo', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT Fk_VueloCategoriaAsientoVuelo
END
GO
--11
--ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT FK_VueloCategoriaAsientoCategoria
IF (OBJECT_ID('dbo.FK_VueloCategoriaAsientoCategoria', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT FK_VueloCategoriaAsientoCategoria
END
GO
--12
--ALTER TABLE Reserva DROP CONSTRAINT FK_ReservaVuelo
IF (OBJECT_ID('dbo.FK_ReservaVuelo', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Reserva DROP CONSTRAINT FK_ReservaVuelo
END
GO
--Constrain CHECK Ck_Servicio
--No es necesari borra la constrain ja que solament afecta a una taula
/*IF (OBJECT_ID('dbo.Ck_Servicio', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE CoPiloto DROP CONSTRAINT Ck_Servicio
END
GO*/




-- DELETE ALL TABLES IF EXISTS

DROP TABLE IF EXISTS CoPiloto
DROP TABLE IF EXISTS CiudadAero
DROP TABLE IF EXISTS Vuelo
DROP TABLE IF EXISTS PersonalAux
DROP TABLE IF EXISTS Categoria
DROP TABLE IF EXISTS Avion
DROP TABLE IF EXISTS Reserva
DROP TABLE IF EXISTS CategoriaAsiento
DROP TABLE IF EXISTS VueloPersonalAux
DROP TABLE IF EXISTS VueloCategoriaAsiento


CREATE TABLE CoPiloto (
	IdCoPiloto int IDENTITY (1,1) PRIMARY KEY,
	Nombre varchar(25) NOT NULL,
	Apellido1 varchar(30) NOT NULL,
	NIF nchar(10) NOT NULL,
	FechaIncorporacion date,
	Nacional bit NULL,
	Continental bit NULL,
	InterContinental bit NULL,
	--CONSTRAINT Ck_Servicio CHECK (Nacional = 1 OR Continental = 1 OR InterContinental = 1)
);
GO


CREATE TABLE CiudadAero (
	IdCiudadAero int IDENTITY(1,1) PRIMARY KEY,
	Ciudad varchar(50)
);
GO

CREATE TABLE Categoria (
	IdCategoria int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TipoCategoria varchar (75)
);
GO
CREATE TABLE PersonalAux (
	IdPersonalAux int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nombre varchar(25) NOT NUll,
	Apellido1 varchar(30) NOT NULL,
	NIF nchar(10) NOT NULL,
	-- Constraint 1
	FkCategoria int,
);
Go

CREATE TABLE Avion (
	IdAvion int NOT NULL IDENTITY (1,1),
	Nombre varchar(75) NOT NULL PRIMARY KEY,
	Modelo varchar(50),
	Capacidad smallint,
	AnyoConstruccion date,
);
GO


CREATE TABLE CategoriaAsiento (
	IdCategoriaAsiento int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	TipoCategoria varchar (50),
);
GO

CREATE TABLE Vuelo (
	IdVuelo int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	CodigoVuelo nchar(10),
	FechaVuelo date,
	Duracion float(4),
	FkPiloto int,
	FkCopiloto int,
	-- Constraint 2
	-- Constraint 3
	FkAvion varchar(75),
	-- Constraint 4
	--FkReserva int,
	-- Constraint 5
	FkOrigen int,
	FkDestino int,
	-- Constraint 6
	-- Constraint 7
);
GO

CREATE TABLE Reserva (
	IdReserva int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	Nombre varchar(25),
	Apellido1 varchar(30),
	NifPassport nchar(15),
	FechaReserva date,
	PrecioAsiento money,
	NumeroAsiento tinyint,
	LetraAsiento nchar(1),
	--Constrain 12
	FkVuelo int,
);
GO



CREATE TABLE VueloPersonalAux(
	IdVueloPersonalAux int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	-- FkVuelo int FOREIGN KEY REFERENCES Vuelo(IdVuelo),
	FkVuelo int,
	-- Constraint 8
	-- FkPersonalAux int FOREIGN KEY REFERENCES PersonalAux(IdPersonalAux)
	FkPersonalAux int,
	-- Constraint 9
);
GO

CREATE TABLE VueloCategoriaAsiento (
	IdVueloCategoriaAsiento int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	CosteCategoria money,
	RangoFilaInicial tinyint,
	RangoFilaFinal tinyint,
	FkVuelo int,
	FkCategoria int,
	-- Constraint 10
	-- Constraint 11
);
GO

ALTER TABLE PersonalAux
ADD CONSTRAINT Fk_CategoriaPersonaAuxiliar FOREIGN KEY (FkCategoria)
REFERENCES Categoria(IdCategoria);
GO

ALTER TABLE Vuelo
ADD CONSTRAINT Fk_VueloCoPilotoPiloto FOREIGN KEY (FkPiloto)
REFERENCES CoPiloto(IdCoPiloto);
GO

ALTER TABLE Vuelo
ADD CONSTRAINT Fk_VueloCoPilotoCopiloto FOREIGN KEY (FkCopiloto)
REFERENCES CoPiloto(IdCoPiloto);
GO
-- Constraint 4
ALTER TABLE Vuelo
ADD CONSTRAINT Fk_VueloAvion FOREIGN KEY (FkAvion)
REFERENCES Avion(Nombre);
GO
-- Constraint 5
/*ALTER TABLE Vuelo
ADD CONSTRAINT FK_VueloReserva FOREIGN KEY(FkReserva)
REFERENCES Reserva(IdReserva);
GO*/

ALTER TABLE Vuelo
ADD CONSTRAINT Fk_VueloCiudadAeroOrigen FOREIGN KEY(FkOrigen)
REFERENCES CiudadAero(IdCiudadAero);
GO
	
ALTER TABLE Vuelo
ADD CONSTRAINT Fk_VueloCiudadAeroDestino FOREIGN KEY(FkDestino)
REFERENCES CiudadAero(IdCiudadAero);
GO

ALTER TABLE VueloPersonalAux
ADD CONSTRAINT Fk_VueloPersonalAuxVuelo FOREIGN KEY (FkVuelo)
REFERENCES Vuelo(IdVuelo);
GO

ALTER TABLE VueloPersonalAux
ADD CONSTRAINT Fk_VueloPersonalAuxPersonalAux FOREIGN KEY (FkPersonalAux)
REFERENCES PersonalAux(IdPersonalAux);
GO

ALTER TABLE VueloCategoriaAsiento
ADD CONSTRAINT Fk_VueloCategoriaAsientoVuelo FOREIGN KEY (FkVuelo)
REFERENCES Vuelo(IdVuelo);
GO

ALTER TABLE VueloCategoriaAsiento
ADD CONSTRAINT FK_VueloCategoriaAsientoCategoria FOREIGN KEY (FkCategoria)
REFERENCES CategoriaAsiento(IdCategoriaAsiento);
GO
-- Contrain 12
ALTER TABLE Reserva
ADD CONSTRAINT FK_ReservaVuelo FOREIGN KEY (FkVuelo)
REFERENCES Vuelo(IdVuelo);
GO

--Contrain CHECK en CoPiloto
ALTER TABLE CoPiloto
ADD CONSTRAINT Ck_Servicio CHECk (Nacional = 1 OR Continental = 1 OR InterContinental = 1)
GO

INSERT INTO CoPiloto
	VALUES ('Jhon', 'Smith', '56533225G', '2010-12-03', 1, 0, 1),
	('Jim', 'Tailor', '53894512L', '2012-09-03', 1, 1, 1),
	('David', 'Fernandez', '23568954H', '2005-05-03', 0, 0, 1),
	('Emilio', 'Martinez', '651235654T', '2000-03-02', 1, 0, 1),
	('Tom', 'Jordan', '65985124D', '2015-09-01', 1, 0, 0),
	('David', 'SinServicio', '45532895D', '2019-09-01', 0, 1, 0)

INSERT INTO CiudadAero
		VALUES ('Barcelona'),('Valencia'),('Sevilla'),('Moscu'),('New York'),('Bruselas'),
		('Londres'), ('Lisboa'),('Nairobi'),('Cairo'), ('Madrid')

INSERT INTO Categoria
	VALUES ('Asistente cabina Primera'),
	('Asistente cabina Bussines'),
	('Azafata'),
	('Seguridad');

INSERT INTO PersonalAux
	VALUES ('Maria','Sanchez','35654894K', 3),
	('Alberto','Perez','45652125F', 2),
	('Pedro','Gonzalez','56212458U', 2),
	('Silvia','Carnizero','564256145T', 3),
	('Santos','Olivera','45236154Y', 4);

INSERT INTO Avion
	VALUES ('Halcon','Airbus255',300, '2019-01-01'),
	('Aguila','Airbus300',500, '2019-01-01'),
	('Paloma','Airbus255',250, '2019-01-01'),
	('Cacatuqa','DouglasA1',100, '2019-01-01'),
	('Flamingo','DouglasT5',350, '2019-01-01'),
	('Buitre','BoingSS1',450, '2019-01-01');



INSERT INTO CategoriaAsiento
	VALUES ('Primera'), ('Bussines'), ('Bussines Special'), ('Turista');
	
INSERT INTO Vuelo (CodigoVuelo, FechaVuelo, Duracion, FkPiloto, FkCopiloto, FkAvion, FkOrigen, FkDestino)
	VALUES ('Vuelo01', '2024-01-01', 7, 1,2,'Paloma',1,9),
	('Vuelo02', '2024-01-02', 5, 2,3,'Cacatuqa',1,7),
	('Vuelo03', '2024-01-03', 3, 1,2,'Aguila',1,3),
	('Vuelo04', '2024-01-04', 6, 3,1,'Halcon',1,8),
	('Vuelo05', '2024-01-05', 4, 2,3,'Aguila',1,5),
	('Vuelo06', '2024-01-06', 4, 2,3,'Aguila',5,1);


INSERT INTO Reserva
	VALUES ('Alex','Smith','66544124A', '2024-01-01', 500, 19,'A',1),
	('Monica','Sanchez','53315325G', '2024-11-01', 850, 5,'C',1),
	('Jose','Garcia','56221325A', '2024-05-01', 150, 40,'A',2),
	('Gabriel','Lopez','562115487V', '2024-08-01', 351, 21,'D',1),
	('Marta','Torrente','43450126G', '2024-05-12', 1125, 3, 'B',3),
	('Xela','Thomas','43489124A','2024-01-01', 500, 31,'B',4),
	('Martin','Nonename','56214589I', '2024-01-01', 500, 37,'C',5),
	('Ramon','Herrero','62215487T', '2024-02-03', 600, 22,'B',1),
	('Santiago','Cerrado','56345243G', '2024-04-19', 750, 16,'C',1);
	 
INSERT INTO VueloPersonalAux
	VALUES (1, 2),(1, 3),(1, 4), (2, 1),(2, 2),(2, 3), (3, 1),(3, 2),(3, 3),
	(4, 1),(4, 2),(4, 3);

INSERT INTO VueloCategoriaAsiento
	VALUES (1000, 1, 12, 1, 1),
	(800, 13, 22, 1, 2),
	(400, 23, 40, 1, 3),
	(3000, 1, 22, 2, 1),
	(1800 ,23, 40, 2, 2),
	(4000 ,1, 23, 3, 1),
	(2000 ,24, 39, 3, 2),
	(1200 ,40, 50, 3, 3),
	(5000,1, 23, 4, 1),
	(3500 ,24, 39, 4, 2),
	(2000 ,40, 50, 4, 3);
