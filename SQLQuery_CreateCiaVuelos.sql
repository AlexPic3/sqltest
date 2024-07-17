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
IF (OBJECT_ID('dbo.Fk_CategoriaPersonaAuxiliar', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.PersonalAux DROP CONSTRAINT Fk_CategoriaPersonaAuxiliar
END
--ALTER TABLE PersonalAux DROP CONSTRAINT Fk_CategoriaPersonaAuxiliar
--2
IF (OBJECT_ID('dbo.Fk_VueloCoPilotoPiloto', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.Vuelo DROP CONSTRAINT Fk_VueloCoPilotoPiloto
END
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCoPilotoPiloto
--3
IF (OBJECT_ID('dbo.Fk_VueloCoPilotoCopiloto', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCoPilotoCopiloto
END
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCoPilotoCopiloto
--4
IF (OBJECT_ID('dbo.Fk_VueloAvion', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloAvion
END
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloAvion
--5
IF (OBJECT_ID('dbo.FK_VueloReserva', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT FK_VueloReserva
END
--ALTER TABLE Vuelo DROP CONSTRAINT FK_VueloReserva
--6
IF (OBJECT_ID('dbo.Fk_VueloCiudadAeroOrigen', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroOrigen
END
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroOrigen
--7
IF (OBJECT_ID('dbo.Fk_VueloCiudadAeroDestino', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroDestino
END
--ALTER TABLE Vuelo DROP CONSTRAINT Fk_VueloCiudadAeroDestino
--8
IF (OBJECT_ID('dbo.Fk_VueloPersonalAuxVuelo', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxVuelo
END
--ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxVuelo
--9
IF (OBJECT_ID('dbo.Fk_VueloPersonalAuxPersonalAux', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxPersonalAux
END
--ALTER TABLE VueloPersonalAux DROP CONSTRAINT Fk_VueloPersonalAuxPersonalAux
--10
IF (OBJECT_ID('dbo.Fk_VueloCategoriaAsientoVuelo', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT Fk_VueloCategoriaAsientoVuelo
END
--ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT Fk_VueloCategoriaAsientoVuelo
--11
IF (OBJECT_ID('dbo.FK_VueloCategoriaAsientoCategoria', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT FK_VueloCategoriaAsientoCategoria
END
--ALTER TABLE VueloCategoriaAsiento DROP CONSTRAINT FK_VueloCategoriaAsientoCategoria

-- DELETE ALL TABLES IF EXISTS

DROP TABLE IF EXISTS CoPiloto
DROP TABLE IF EXISTS CiudadAero
DROP TABLE IF EXISTS Vuelo
DROP TABLE IF EXISTS PersonalAux
DROP TABLE IF EXISTS Categoria
DROP TABLE IF EXISTS Avion
DROP TABLE IF EXISTS Reserva
DROP TABLE IF EXISTS CategoriaAsiento


CREATE TABLE CoPiloto (
	IdCoPiloto int IDENTITY (1,1) PRIMARY KEY,
	Nombre varchar(25) NOT NULL,
	Apellido1 varchar(30) NOT NULL,
	NIF nchar(10) NOT NULL,
	FechaIncorporacion date,
	Nacional bit,
	Continental bit,
	InterContinental bit
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
	CONSTRAINT Fk_CategoriaPersonaAuxiliar FOREIGN KEY (FkCategoria)
	REFERENCES Categoria(IdCategoria)
);
Go

CREATE TABLE Avion (
	IdAvion int NOT NULL IDENTITY (1,1),
	Nombre varchar(75) NOT NULL PRIMARY KEY,
	Modelo varchar(50),
	Capacidad smallint,
	AñoConstruccion date,
);
GO
CREATE TABLE Reserva (
	IdReserva int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	Nombre varchar(25),
	Apellido1 varchar(30),
	NifPassport nchar(15),
	FechaReserva date,
	PrecioAsiento money,
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
	CONSTRAINT Fk_VueloCoPilotoPiloto FOREIGN KEY (FkPiloto)
	REFERENCES CoPiloto(IdCoPiloto),
	-- Constraint 3
	CONSTRAINT Fk_VueloCoPilotoCopiloto FOREIGN KEY (FkCopiloto)
	REFERENCES CoPiloto(IdCoPiloto),
	FkAvion varchar(75),
	-- Constraint 4
	CONSTRAINT Fk_VueloAvion FOREIGN KEY (FkAvion)
	REFERENCES Avion(Nombre),
	FkReserva int,
	-- Constraint 5
	CONSTRAINT FK_VueloReserva FOREIGN KEY(FkReserva)
	REFERENCES Reserva(IdReserva),
	FkOrigen int,
	FkDestino int,
	-- Constraint 6
	CONSTRAINT Fk_VueloCiudadAeroOrigen FOREIGN KEY(FkOrigen)
	REFERENCES CiudadAero(IdCiudadAero),
	-- Constraint 7
	CONSTRAINT Fk_VueloCiudadAeroDestino FOREIGN KEY(FkDestino)
	REFERENCES CiudadAero(IdCiudadAero),
	
);
GO

CREATE TABLE VueloPersonalAux(
	IdVueloPersonalAux int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	-- FkVuelo int FOREIGN KEY REFERENCES Vuelo(IdVuelo),
	FkVuelo int,
	-- Constraint 8
	CONSTRAINT Fk_VueloPersonalAuxVuelo FOREIGN KEY (FkVuelo)
	REFERENCES Vuelo(IdVuelo),
	-- FkPersonalAux int FOREIGN KEY REFERENCES PersonalAux(IdPersonalAux)
	FkPersonalAux int,
	-- Constraint 9
	CONSTRAINT Fk_VueloPersonalAuxPersonalAux FOREIGN KEY (FkPersonalAux)
	REFERENCES PersonalAux(IdPersonalAux),
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
	CONSTRAINT Fk_VueloCategoriaAsientoVuelo FOREIGN KEY (FkVuelo)
	REFERENCES Vuelo(IdVuelo),
	-- Constraint 11
	CONSTRAINT FK_VueloCategoriaAsientoCategoria FOREIGN KEY (FkCategoria)
	REFERENCES CategoriaAsiento(IdCategoriaAsiento),
);
GO













