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

USE AlexCiaTenis;
GO


-- DELETE ALL CONSTRAINS IF EXISTS
--1
--ALTER TABLE Curso DROP CONSTRAINT Fk_CursoPista
IF (OBJECT_ID('dbo.Fk_CursoPista', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.Curso DROP CONSTRAINT Fk_CursoPista
END
GO

--2
--ALTER TABLE Curso DROP CONSTRAINT Fk_VueloCoPilotoPiloto
IF (OBJECT_ID('dbo.Fk_CursoProfesor', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE dbo.Curso DROP CONSTRAINT Fk_CursoProfesor
END
GO

--3
--ALTER TABLE DiaSemanaCurso DROP CONSTRAINT Fk_DiaSemanaCursoDia
IF (OBJECT_ID('dbo.Fk_DiaSemanaCursoDia', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE DiaSemanaCurso DROP CONSTRAINT Fk_DiaSemanaCursoDia
END
GO

--4
--ALTER TABLE DiaSemanaCurso DROP CONSTRAINT Fk_DiaSemanaCursoCurso
IF (OBJECT_ID('dbo.Fk_DiaSemanaCursoCurso', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE DiaSemanaCurso DROP CONSTRAINT Fk_DiaSemanaCursoCurso
END
GO

--5
--ALTER TABLE DiaSemanaCurso DROP CONSTRAINT Fk_DiaSemanaCursoFranjaHoraria
IF (OBJECT_ID('dbo.Fk_DiaSemanaCursoFranjaHoraria', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE DiaSemanaCurso DROP CONSTRAINT Fk_DiaSemanaCursoFranjaHoraria
END
GO

--6
--ALTER TABLE  Reserva DROP CONSTRAINT Fk_ReservaPista
IF (OBJECT_ID('dbo.Fk_ReservaPista', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE  Reserva DROP CONSTRAINT Fk_ReservaPista
END
GO

--7
--ALTER TABLE ReservaSocio DROP CONSTRAINT Fk_ReservaSocioReserva
IF (OBJECT_ID('dbo.Fk_ReservaSocioReserva', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE ReservaSocio DROP CONSTRAINT Fk_ReservaSocioReserva
END
GO

--8
--ALTER TABLE ReservaSocio DROP CONSTRAINT Fk_ReservaSocioSocio
IF (OBJECT_ID('dbo.Fk_ReservaSocioSocio', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE ReservaSocio DROP CONSTRAINT Fk_ReservaSocioSocio
END
GO

--9
--ALTER TABLE SocioCurso DROP CONSTRAINT Fk_SocioCursoSocio
IF (OBJECT_ID('dbo.Fk_SocioCursoSocio', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE SocioCurso DROP CONSTRAINT Fk_SocioCursoSocio
END
GO

--10
--ALTER TABLE SocioCurso DROP CONSTRAINT Fk_SocioCursoCurso
IF (OBJECT_ID('dbo.Fk_SocioCursoCurso', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE SocioCurso DROP CONSTRAINT Fk_SocioCursoCurso
END
GO

--11
--ALTER TABLE ReciboMes DROP CONSTRAINT Fk_ReciboMesRecibo
IF (OBJECT_ID('dbo.Fk_ReciboMesRecibo', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE ReciboMes DROP CONSTRAINT Fk_ReciboMesRecibo
END
GO

--12
--ALTER TABLE ReciboMes DROP CONSTRAINT Fk_ReciboMesMes
IF (OBJECT_ID('dbo.Fk_ReciboMesMes', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE ReciboMes DROP CONSTRAINT Fk_ReciboMesMes
END
GO

--13
--ALTER TABLE ReciboMes DROP CONSTRAINT Fk_ReciboMesSocioCurso
IF (OBJECT_ID('dbo.Fk_ReciboMesSocioCurso', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE ReciboMes DROP CONSTRAINT Fk_ReciboMesSocioCurso
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


DROP TABLE IF EXISTS Profesor
DROP TABLE IF EXISTS FranjaHoraria
DROP TABLE IF EXISTS DiaSemana
DROP TABLE IF EXISTS Pista
DROP TABLE IF EXISTS Curso
DROP TABLE IF EXISTS DiaSemanaCurso
DROP TABLE IF EXISTS Reserva
DROP TABLE IF EXISTS Socio
DROP TABLE IF EXISTS ReservaSocio
DROP TABLE IF EXISTS SocioCurso
DROP TABLE IF EXISTS Mes
DROP TABLE IF EXISTS Recibo
DROP TABLE IF EXISTS ReciboMes


-- CREACIO DE TOTES LES TAULES

CREATE TABLE Profesor (
	IdProfesor int IDENTITY (1,1) PRIMARY KEY,
	NIF nchar(10) NOT NULL,
	NumeroFederacion nchar(15) NOT NULL,
	Nombre varchar(25) NOT NULL,
	Apellido1 varchar(30) NOT NULL,
	Apellido2 varchar(30) NOT NULL,
	Direccion varchar(100) NOT NULL,
	Telefono nchar(10),
);
GO

CREATE TABLE FranjaHoraria (
	IdFranjaHoraria int IDENTITY (1,1) PRIMARY KEY,
	HoraInicio time NOT NULL,
	HoraFinal time NOT NULL,
);
GO

CREATE TABLE DiaSemana (
	IdDiaSemana int IDENTITY (1,1) PRIMARY KEY,
	Dia nchar(10) NOT NULL,
);
GO

CREATE TABLE Pista (
	IdPista int IDENTITY (1,1),
	Identificador nchar(10) PRIMARY KEY,
	Descripcion nchar(20),
	DisponeGradas bit NULL,
	Homologada bit NULL,
);
GO

CREATE TABLE Curso (
	IdCurso int IDENTITY (1,1),
	Identificador nchar(4) PRIMARY KEY,
	Nombre nchar(10),
	NumeroMaxAlumnos smallint,
	-- Constraint 1
	FkPista nchar(10),
	-- FkPista int FOREIGN KEY REFERENCES Pista(Identificador)
	--Constraint 2
	FkProfesor int,
	-- FkProfesor int FOREIGN KEY REFERENCES Profesor(IdProfesor)
);
GO

CREATE TABLE DiaSemanaCurso (
	IdDiaSemanaCurso int IDENTITY (1,1) PRIMARY KEY,
	-- Constraint 3
	FkDiaSemana int,
	-- FkDiaSemana int FOREIGN KEY REFERENCES DiaSemana(IdDiaSemana)
	-- Constraint 4
	FkCurso nchar(4),
	-- FkCurso int FOREIGN KEY REFERENCES Curso(Identificador)
	-- Constraint 5
	FkFranjaHoraria int,
	-- FkFranjaHoraria int FOREIGN KEY REFERENCES FranjaHoraria(IdFranjaHoraria)
);
GO

CREATE TABLE Reserva (
	IdReserva int IDENTITY (1,1) PRIMARY KEY,
	FechaReserva date NOT NULL,
	HoraEntrada time NOT NULL,
	HoraSalida time NOT NULL,
	Pagada bit NOT NULL,
	Iluminacion bit NOT NULL,
	--Constraint 6
	FkPista nchar(10),
	-- FkPista int FOREIGN KEY REFERENCES Pista(Identificador)
);
GO

CREATE TABLE Socio (
	IdSocio int IDENTITY (1,1),
	NumeroSocio int PRIMARY KEY,
	NIF nchar(10) NOT NULL,
	Nombre varchar(25) NOT NULL,
	Apellido1 varchar(30) NOT NULL,
	Apellido2 varchar(30) NOT NULL,
	Direccion varchar(100) NOT NULL,
	Telefono nchar(10) NOT NULL,
	NumeroCuenta nchar(20) NOT NULL,
	EsSocio bit NOT NULL,

);
GO

CREATE TABLE ReservaSocio (
	IdReservaSocio int IDENTITY (1,1) PRIMARY KEY,
	-- Constraint 7
	FkReserva int,
	-- FkReserva int FOREIGN KEY REFERENCES Reserva(IdReserva)
	-- Constraint 8
	FkSocio int,
	-- FkSocio int FOREIGN KEY REFERENCES Socio(NumeroSocio)
);
GO

CREATE TABLE SocioCurso (
	IdSocioCurso int IDENTITY (1,1) PRIMARY KEY,
	-- Constraint 9
	FkSocio int,
	-- FkSocio int FOREIGN KEY REFERENCES Socio(NumeroSocio)
	-- Constraint 10
	FkCurso nchar(4),
	-- FkCurso int FOREIGN KEY REFERENCES Curso(Identificador)
);
GO

CREATE TABLE Mes (
	IdMes int IDENTITY (1,1) PRIMARY KEY,
	Mes varchar(15) NOT NULL,
);
GO

CREATE TABLE Recibo (
	IdRecibo int IDENTITY (1,1) PRIMARY KEY,
	Importe money NOT NULL,
	Pagado bit NULL,	
);
GO

CREATE TABLE ReciboMes (
	IdReciboMes int IDENTITY (1,1) PRIMARY KEY,
	Anyo smallint,
	-- Constraint 11
	FkRecibo int,
	-- FkRecibo int FOREIGN KEY REFERENCES Recibo(IdRecibo)
	-- Constraint 12
	FkMes int,
	-- FkMes int FOREIGN KEY REFERENCES Mes(IdMes)
	-- Constraint 13
	FkSocioCurso int,
	-- FkSocioCurso int FOREIGN KEY REFERENCES SocioCurso(IdSocioCurso)
);
GO


-- CREACIO DE LES CONSTRAINTS DINS DE LES TAULES

-- Constraint 1
-- FkPista int FOREIGN KEY REFERENCES Pista(Identificador)
ALTER TABLE Curso
ADD CONSTRAINT Fk_CursoPista FOREIGN KEY (FkPista)
REFERENCES Pista(Identificador);
GO

-- Constraint 2
-- FkCurso int FOREIGN KEY REFERENCES Curso(Identificador)
ALTER TABLE Curso
ADD CONSTRAINT Fk_CursoProfesor FOREIGN KEY (FkProfesor)
REFERENCES Profesor(IdProfesor);
GO

-- Constraint 3
ALTER TABLE DiaSemanaCurso
ADD CONSTRAINT Fk_DiaSemanaCursoDia FOREIGN KEY (FkDiaSemana)
REFERENCES DiaSemana(IdDiaSemana);
GO

-- Constraint 4
ALTER TABLE DiaSemanaCurso
ADD CONSTRAINT Fk_DiaSemanaCursoCurso FOREIGN KEY (FkCurso)
REFERENCES Curso(Identificador);
GO

-- Constraint 5
ALTER TABLE DiaSemanaCurso
ADD CONSTRAINT Fk_DiaSemanaCursoFranjaHoraria FOREIGN KEY (FkFranjaHoraria)
REFERENCES FranjaHoraria(IdFranjaHoraria);
GO

--Constraint 6
ALTER TABLE Reserva
ADD CONSTRAINT Fk_ReservaPista FOREIGN KEY (FkPista)
REFERENCES Pista(Identificador);
GO

-- Constraint 7
ALTER TABLE ReservaSocio
ADD CONSTRAINT Fk_ReservaSocioReserva FOREIGN KEY (FkReserva)
REFERENCES Reserva(IdReserva);
GO

-- Constraint 8
ALTER TABLE ReservaSocio
ADD CONSTRAINT Fk_ReservaSocioSocio FOREIGN KEY (FkSocio)
REFERENCES Socio(NumeroSocio);
GO

-- Constraint 9
ALTER TABLE SocioCurso
ADD CONSTRAINT Fk_SocioCursoSocio FOREIGN KEY (FkSocio)
REFERENCES Socio(NumeroSocio);
GO

-- Constraint 10
ALTER TABLE SocioCurso
ADD CONSTRAINT Fk_SocioCursoCurso FOREIGN KEY (FkCurso)
REFERENCES Curso(Identificador);
GO

-- Constraint 11
ALTER TABLE ReciboMes
ADD CONSTRAINT Fk_ReciboMesRecibo FOREIGN KEY (FkRecibo)
REFERENCES Recibo(IdRecibo);
GO

-- Constraint 12
ALTER TABLE ReciboMes
ADD CONSTRAINT Fk_ReciboMesMes FOREIGN KEY (FkMes)
REFERENCES Mes(IdMes);
GO

-- Constraint 13
ALTER TABLE ReciboMes
ADD CONSTRAINT Fk_ReciboMesSocioCurso FOREIGN KEY (FkSocioCurso)
REFERENCES SocioCurso(IdSocioCurso);
GO




-- CREATE ALL DB DATA


INSERT INTO Profesor (NIF, NumeroFederacion, Nombre, Apellido1, Apellido2, Direccion, Telefono)
VALUES('12345678A', 'FED1234567890', 'Juan', 'Pérez', 'García', 'Calle Falsa 123', '600123456'),
		('23456789B', 'FED1234567891', 'Ana', 'Martínez', 'López', 'Avenida Siempre Viva 456', '600123457'),
		('34567890C', 'FED1234567892', 'Luis', 'González', 'Hernández', 'Boulevard Central 789', '600123458'),
		('45678901D', 'FED1234567893', 'María', 'Rodríguez', 'Fernández', 'Pasaje del Sol 101', NULL),
		('56789012E', 'FED1234567894', 'Carlos', 'Sánchez', 'Ruiz', 'Calle Luna 202', '600123460'),
		('67890123F', 'FED1234567895', 'Laura', 'Ramírez', 'Torres', 'Avenida del Mar 303', '600123461'),
		('78901234G', 'FED1234567896', 'Pedro', 'Flores', 'Jiménez', 'Calle Olmo 404', '600123462'),
		('89012345H', 'FED1234567897', 'Elena', 'Gutiérrez', 'Moreno', 'Camino Real 505', NULL),
		('90123456I', 'FED1234567898', 'Jorge', 'Díaz', 'Navarro', 'Avenida de los Pinos 606', '600123464'),
		('01234567J', 'FED1234567899', 'Sofía', 'Fernández', 'Molina', 'Calle del Río 707', '600123465'),
		('12345678K', 'FED1234567900', 'Andrés', 'López', 'Ortiz', 'Paseo de las Flores 808', '600123466'),
		('23456789L', 'FED1234567901', 'Lucía', 'Ruiz', 'Castro', 'Calle del Sol 909', NULL),
		('34567890M', 'FED1234567902', 'Ricardo', 'Hernández', 'Vega', 'Avenida de la Luz 100', '600123468'),
		('45678901N', 'FED1234567903', 'Marta', 'Mendoza', 'Campos', 'Camino del Parque 111', '600123469'),
		('56789012O', 'FED1234567904', 'David', 'Castro', 'Ramos', 'Calle Principal 222', '600123470');
GO

INSERT INTO FranjaHoraria (HoraInicio, HoraFinal)
VALUES ('09:00:00', '11:00:00'),
		('11:00:00', '13:00:00'),
		('13:00:00', '15:00:00'),
		('15:00:00', '17:00:00'),
		('17:00:00', '19:00:00'),
		('19:00:00', '21:00:00');
GO

INSERT INTO DiaSemana (Dia)
VALUES ('Lunes'),
		('Martes'),
		('Miércoles'),
		('Jueves'),
		('Viernes'),
		('Sábado'),
		('Domingo');
GO

INSERT INTO Pista (Identificador, Descripcion, DisponeGradas, Homologada)
VALUES ('Pista001', 'Pista Central', 1, 1),
		('Pista002', 'Pista Norte', 0, 1),
		('Pista003', 'Pista Sur', 1, 0),
		('Pista004', 'Pista Este', 1, 1),
		('Pista005', 'Pista Oeste', 0, 0),
		('Pista006', 'Pista A', 1, 1),
		('Pista007', 'Pista B', 0, 1),
		('Pista008', 'Pista C', 1, 0),
		('Pista009', 'Pista D', 1, 1),
		('Pista010', 'Pista E', 0, 0),
		('Pista011', 'Pista F', 1, 1),
		('Pista012', 'Pista G', 0, 1),
		('Pista013', 'Pista H', 1, 0),
		('Pista014', 'Pista I', 1, 1),
		('Pista015', 'Pista J', 0, 0);
GO

INSERT INTO Curso (Identificador, Nombre, NumeroMaxAlumnos, FkPista, FkProfesor)
VALUES ('C001', 'Curso1', 6, 'Pista001', 1),
		('C002', 'Curso2', 6, 'Pista001', 1),  -- Profesor 1 imparte dos cursos
		('C003', 'Curso3', 6, 'Pista001', 2),
		('C004', 'Curso4', 6, 'Pista004', 2),  -- Profesor 2 imparte dos cursos
		('C005', 'Curso5', 6, 'Pista002', 3),
		('C006', 'Curso6', 6, 'Pista002', 3),  -- Profesor 3 imparte dos cursos
		('C007', 'Curso7', 6, 'Pista007', 4),
		('C008', 'Curso8', 6, 'Pista003', 4),  -- Profesor 4 imparte dos cursos
		('C009', 'Curso9', 6, 'Pista005', 5),
		('C010', 'Curso10', 6, 'Pista010', 5), -- Profesor 5 imparte dos cursos
		('C011', 'Curso11', 6, 'Pista011', 6),
		('C012', 'Curso12', 6, 'Pista012', 7),
		('C013', 'Curso13', 6, 'Pista013', 8),
		('C014', 'Curso14', 6, 'Pista014', 9),
		('C015', 'Curso15', 6, 'Pista015', 10);  -- Profesor 10 imparte un curso
GO

INSERT INTO DiaSemanaCurso (FkDiaSemana, FkCurso, FkFranjaHoraria)
	VALUES (1, 'C001',1),  -- Lunes
		(2, 'C002',1),  -- Martes
		(3, 'C003',1),  -- Miércoles
		(4, 'C004',1),  -- Jueves
		(5, 'C005',3),  -- Viernes
		(6, 'C006',2),  -- Sábado
		(7, 'C007',2),  -- Domingo
		(1, 'C008',2),  -- Lunes
		(2, 'C009',3),  -- Martes
		(3, 'C010',4),  -- Miércoles
		(4, 'C011',4),  -- Jueves
		(5, 'C012',5),  -- Viernes
		(6, 'C013',5),  -- Sábado
		(7, 'C014',5),  -- Domingo
		(1, 'C015',1),  -- Lunes
		(2, 'C001',6),  -- Martes
		(3, 'C002',6),  -- Miércoles
		(4, 'C003',6),  -- Jueves
		(5, 'C004',6),  -- Viernes
		(6, 'C005',5),  -- Sábado
		(7, 'C006',5),  -- Domingo
		(1, 'C007',2),  -- Lunes
		(2, 'C008',2),  -- Martes
		(3, 'C009',2),  -- Miércoles
		(4, 'C010',2),  -- Jueves
		(5, 'C011',1),  -- Viernes
		(6, 'C012',2),  -- Sábado
		(7, 'C013',5),  -- Domingo
		(1, 'C014',5),  -- Lunes
		(2, 'C015',6),  -- Martes
		(3, 'C001',2),  -- Miércoles
		(4, 'C002',2);  -- Jueves
GO

INSERT Reserva (FechaReserva, HoraEntrada, HoraSalida, Pagada, Iluminacion, FkPista)
	VALUES (CAST(N'2023-04-12' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1, 1, N'Pista007  '),
			(CAST(N'2023-02-24' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 1, 1, N'Pista015  '),
			(CAST(N'2023-05-24' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 0, 0, N'Pista009  '),
			(CAST(N'2023-07-06' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 0, 0, N'Pista011  '),
			(CAST(N'2023-07-03' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1, 0, N'Pista012  '),
			(CAST(N'2023-05-09' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 0, 1, N'Pista006  '),
			(CAST(N'2023-10-25' AS Date), CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 1, 0, N'Pista014  '),
			(CAST(N'2023-07-20' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1, 1, N'Pista009  '),
			(CAST(N'2023-05-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 0, 1, N'Pista012  '),
			(CAST(N'2023-07-26' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 1, 1, N'Pista006  '),
			(CAST(N'2023-10-02' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 0, 1, N'Pista010  '),
			(CAST(N'2023-05-19' AS Date), CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 0, 1, N'Pista009  '),
			(CAST(N'2023-11-20' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 0, 1, N'Pista014  '),
			(CAST(N'2023-08-27' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 0, 0, N'Pista008  '),
			(CAST(N'2023-01-16' AS Date), CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 0, 0, N'Pista014  '),
			(CAST(N'2023-04-02' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 1, 0, N'Pista014  '),
			(CAST(N'2023-07-03' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 1, 1, N'Pista009  '),
			(CAST(N'2023-10-25' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 0, 0, N'Pista008  '),
			(CAST(N'2023-08-22' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 0, 1, N'Pista015  '),
			(CAST(N'2023-08-28' AS Date), CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 1, 0, N'Pista006  '),
			(CAST(N'2023-10-29' AS Date), CAST(N'19:00:00' AS Time), CAST(N'21:00:00' AS Time), 1, 0, N'Pista014  '),
			(CAST(N'2023-11-01' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 1, 0, N'Pista009  '),
			(CAST(N'2023-09-16' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 1, 0, N'Pista011  '),
			(CAST(N'2023-08-28' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 1, 1, N'Pista007  '),
			(CAST(N'2023-11-15' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 0, 0, N'Pista011  '),
			(CAST(N'2023-09-21' AS Date), CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 0, 1, N'Pista009  '),
			(CAST(N'2023-07-11' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 1, 0, N'Pista009  '),
			(CAST(N'2023-09-01' AS Date), CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 0, 1, N'Pista011  '),
			(CAST(N'2023-01-14' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 0, 0, N'Pista008  '),
			(CAST(N'2023-01-30' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 0, 1, N'Pista009  '),
			(CAST(N'2023-04-29' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 1, 1, N'Pista006  '),
			(CAST(N'2023-11-23' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 1, 1, N'Pista015  '),
			(CAST(N'2023-02-01' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 1, 0, N'Pista013  '),
			(CAST(N'2023-05-24' AS Date), CAST(N'19:00:00' AS Time), CAST(N'21:00:00' AS Time), 0, 0, N'Pista009  '),
			(CAST(N'2023-07-03' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 0, 0, N'Pista009  '),
			(CAST(N'2023-10-10' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 0, 1, N'Pista015  '),
			(CAST(N'2023-05-19' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 0, 0, N'Pista010  '),
			(CAST(N'2023-06-25' AS Date), CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 1, 1, N'Pista006  '),
			(CAST(N'2023-11-13' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 1, 0, N'Pista007  '),
			(CAST(N'2023-11-29' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 1, 0, N'Pista007  '),
			(CAST(N'2023-02-07' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 0, 0, N'Pista007  '),
			(CAST(N'2023-11-05' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 1, 0, N'Pista011  '),
			(CAST(N'2023-11-11' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 0, 0, N'Pista015  '),
			(CAST(N'2023-11-20' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 0, 1, N'Pista013  '),
			(CAST(N'2023-12-18' AS Date), CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 0, 0, N'Pista014  '),
			(CAST(N'2023-11-21' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 0, 0, N'Pista015  '),
			(CAST(N'2023-09-17' AS Date), CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 0, 1, N'Pista008  '),
			(CAST(N'2023-01-30' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 0, 1, N'Pista013  '),
			(CAST(N'2023-02-05' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 1, 1, N'Pista008  '),
			(CAST(N'2023-08-09' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 0, 1, N'Pista011  ');
GO


INSERT INTO Socio (NumeroSocio, NIF, Nombre, Apellido1, Apellido2, Direccion, Telefono, NumeroCuenta, EsSocio)
	VALUES (1000, N'97214983F', N'Ana', N'Sanchez', N'Lopez', N'Calle 53, 4A', N'6908585127', N'758660181', 1),
			(1001, N'93003145Y', N'Luis', N'Lopez', N'Ramirez', N'Calle 65, 16A', N'6310412424', N'1256869684', 0),
			(1002, N'65165723Y', N'Luis', N'Garcia', N'Torres', N'Calle 95, 2A', N'6645603753', N'827575980', 0),
			(1003, N'19019934G', N'Jose', N'Fernandez', N'Perez', N'Calle 91, 18A', N'6043175925', N'180979117', 1),
			(1004, N'23444877K', N'Sara', N'Fernandez', N'Gonzalez', N'Calle 34, 43A', N'6358497677', N'956954310', 1),
			(1005, N'97800979Y', N'Luis', N'Torres', N'Martinez', N'Calle 33, 10A', N'6094336360', N'1805213681', 0),
			(1006, N'39701243U', N'Miguel', N'Gonzalez', N'Perez', N'Calle 59, 47A', N'6840060132', N'289443296', 0),
			(1007, N'95674319Y', N'Luis', N'Ramirez', N'Torres', N'Calle 20, 11A', N'6095144177', N'224227190', 0),
			(1008, N'70794700X', N'Lucia', N'Lopez', N'Perez', N'Calle 68, 38A', N'6863567627', N'435444245', 1),
			(1009, N'58618082U', N'Sara', N'Garcia', N'Gonzalez', N'Calle 58, 26A', N'6377847114', N'1546959589', 0),
			(1010, N'66521080O', N'Laura', N'Perez', N'Ramirez', N'Calle 9, 31A', N'6125347453', N'581113815', 1),
			(1011, N'66422430O', N'Laura', N'Garcia', N'Gonzalez', N'Calle 3, 6A', N'6599758254', N'1069000950', 0),
			(1012, N'95392577C', N'Sara', N'Ramirez', N'Garcia', N'Calle 45, 44A', N'6893703036', N'1328915963', 1),
			(1013, N'5073994A', N'Miguel', N'Gonzalez', N'Fernandez', N'Calle 87, 15A', N'6706126598', N'1588933009', 1),
			(1014, N'7090839P', N'Luis', N'Garcia', N'Torres', N'Calle 2, 18A', N'6047455637', N'954369016', 1),
			(1015, N'15745711F', N'Sara', N'Garcia', N'Garcia', N'Calle 86, 0A', N'6774964609', N'71854413', 0),
			(1016, N'99156060J', N'Juan', N'Rodriguez', N'Garcia', N'Calle 49, 7A', N'6348740499', N'1908506273', 1),
			(1017, N'81983906A', N'Maria', N'Lopez', N'Sanchez', N'Calle 17, 9A', N'6191853578', N'409120949', 0),
			(1018, N'99125128O', N'Carlos', N'Martinez', N'Ramirez', N'Calle 76, 40A', N'6015793476', N'670851797', 1),
			(1019, N'39469721N', N'Ana', N'Garcia', N'Lopez', N'Calle 1, 22A', N'6429212422', N'674212553', 1),
			(1020, N'34431248M', N'Ana', N'Garcia', N'Garcia', N'Calle 4, 27A', N'6306265571', N'1609520041', 0),
			(1021, N'76703480K', N'Ana', N'Ramirez', N'Torres', N'Calle 90, 31A', N'6039130351', N'822421991', 1),
			(1022, N'33830420C', N'Carlos', N'Martinez', N'Sanchez', N'Calle 91, 43A', N'6792015092', N'1315768098', 1),
			(1023, N'4971376U', N'Miguel', N'Lopez', N'Rodriguez', N'Calle 90, 0A', N'6704690373', N'82034627', 0),
			(1024, N'61867345G', N'Lucia', N'Gonzalez', N'Sanchez', N'Calle 64, 16A', N'6691623692', N'931194882', 1),
			(1025, N'82262536N', N'Luis', N'Perez', N'Ramirez', N'Calle 63, 1A', N'6243812732', N'279655228', 1),
			(1026, N'98520804C', N'Laura', N'Martinez', N'Rodriguez', N'Calle 55, 47A', N'6218314664', N'1287777461', 1),
			(1027, N'66895871K', N'Lucia', N'Gonzalez', N'Lopez', N'Calle 30, 13A', N'6389539834', N'1638966850', 0),
			(1028, N'61352507P', N'Lucia', N'Rodriguez', N'Perez', N'Calle 91, 18A', N'6208261316', N'1088159339', 1),
			(1029, N'73885797H', N'Carlos', N'Gonzalez', N'Garcia', N'Calle 8, 4A', N'6119795692', N'1946388668', 1),
			(1030, N'52491614A', N'Maria', N'Sanchez', N'Fernandez', N'Calle 96, 8A', N'6299734504', N'572479880', 0),
			(1031, N'91887428E', N'Jose', N'Rodriguez', N'Sanchez', N'Calle 75, 14A', N'6618073826', N'383943399', 0),
			(1032, N'62719793Y', N'Jose', N'Rodriguez', N'Fernandez', N'Calle 78, 17A', N'6725098058', N'1643470342', 1),
			(1033, N'8600013R', N'Ana', N'Torres', N'Sanchez', N'Calle 49, 31A', N'6968528164', N'2098548558', 1),
			(1034, N'63834896Z', N'Ana', N'Martinez', N'Rodriguez', N'Calle 34, 47A', N'6387181591', N'174214548', 1),
			(1035, N'50522016I', N'Miguel', N'Garcia', N'Fernandez', N'Calle 34, 47A', N'6122279714', N'798946356', 1),
			(1036, N'46499819S', N'Carlos', N'Martinez', N'Fernandez', N'Calle 20, 19A', N'6115279714', N'798910356', 0),
			(1037, N'68582500Q ', N'Laura', N'Garcia', N'Rodriguez', N'Calle 74, 39A', N'6248439609', N'474180900', 0),
			(1038, N'92063525C ', N'Maria', N'Perez', N'Rodriguez', N'Calle 15, 35A', N'6538133056', N'792938993', 1),
			(1039, N'79748857G ', N'Sara', N'Fernandez', N'Garcia', N'Calle 46, 30A', N'6905871769', N'1976703211', 0),
			(1040, N'40830837V ', N'Miguel', N'Fernandez', N'Perez', N'Calle 37, 48A', N'6857895884', N'43354265', 1),
			(1041, N'14260363A ', N'Lucia', N'Fernandez', N'Garcia', N'Calle 27, 25A', N'6970346261', N'1088577618', 0),
			(1042, N'77770841P ', N'Laura', N'Rodriguez', N'Lopez', N'Calle 89, 39A', N'6645603586', N'1506143346', 1),
			(1043, N'92770257H ', N'Luis', N'Garcia', N'Sanchez', N'Calle 97, 28A', N'6732755040', N'945200301', 1),
			(1044, N'94837531Y ', N'Laura', N'Torres', N'Fernandez', N'Calle 33, 29A', N'6515040252', N'134164760', 0),
			(1045, N'91216128A ', N'Lucia', N'Fernandez', N'Torres', N'Calle 46, 45A', N'6802321782', N'113272431', 1),
			(1046, N'99567842N ', N'Laura', N'Torres', N'Martinez', N'Calle 38, 49A', N'6499727924', N'790117713', 0),
			(1047, N'74234129Y ', N'Jose', N'Fernandez', N'Perez', N'Calle 16, 3A', N'6395320823', N'1851507271', 0),
			(1048, N'38812224K ', N'Maria', N'Perez', N'Ramirez', N'Calle 87, 33A', N'6694539882', N'2055996429', 1),
			(1049, N'1733215 H ', N'Jose', N'Sanchez', N'Lopez', N'Calle 99, 20A', N'6487311470', N'883256017', 0),
			(1050, N'15243488W ', N'Luis', N'Torres', N'Gonzalez', N'Calle 6, 43A', N'6554930446', N'1198415240', 0),
			(1051, N'85684348Q ', N'Maria', N'Lopez', N'Gonzalez', N'Calle 24, 9A', N'6419886844', N'1387791327', 0),
			(1052, N'72345481N ', N'Carlos', N'Ramirez', N'Gonzalez', N'Calle 27, 24A', N'6132078078', N'26058868', 0),
			(1053, N'4433537 O ', N'Jose', N'Ramirez', N'Martinez', N'Calle 18, 0A', N'6880439151', N'328013293', 0),
			(1054, N'49258636C ', N'Miguel', N'Martinez', N'Sanchez', N'Calle 38, 21A', N'6974216594', N'2001584587', 0),
			(1055, N'89026399E ', N'Juan', N'Gonzalez', N'Fernandez', N'Calle 6, 14A', N'6386820899', N'1548706954', 1);
GO

INSERT ReservaSocio (FkReserva, FkSocio) 
	VALUES (9, 1036),
			(4, 1049),
			(12, 1025),
			(32, 1051),
			(39, 1030),
			(22, 1026),
			(48, 1052),
			(40, 1028),
			(32, 1041),
			(47, 1002),
			(50, 1000),
			(26, 1036),
			(22, 1043),
			(19, 1021),
			(19, 1027),
			(31, 1007),
			(47, 1000),
			(41, 1010),
			(38, 1020),
			(41, 1040),
			(1, 1026),
			(8, 1013),
			(18, 1049),
			(20, 1011),
			(32, 1004),
			(23, 1012),
			(49, 1043),
			(21, 1018),
			(14, 1000),
			(39, 1024),
			(39, 1023),
			(9, 1039),
			(22, 1039),
			(24, 1021),
			(20, 1005),
			(6, 1039),
			(5, 1048),
			(24, 1043),
			(28, 1002),
			(4, 1001),
			(18, 1024),
			(21, 1037),
			(14, 1035),
			(39, 1002),
			(49, 1002),
			(39, 1034),
			(32, 1029),
			(30, 1021),
			(13, 1031),
			(18, 1019),
			(20, 1013),
			(48, 1045),
			(26, 1031),
			(6, 1011),
			(10, 1031),
			(12, 1049),
			(33, 1039),
			(9, 1026),
			(30, 1018),
			(24, 1032),
			(14, 1032),
			(21, 1029),
			(17, 1042),
			(9, 1054),
			(23, 1005),
			(11, 1001),
			(7, 1026),
			(50, 1022),
			(39, 1038),
			(27, 1049);
GO

INSERT SocioCurso (FkSocio, FkCurso) 
	VALUES (1001, 'C001'),
	(1002, 'C001'),
	(1005, 'C001'),
	(1007, 'C001'),
	(1011, 'C001'),
	(1006, 'C001'),
	(1023, 'C002'),
	(1032, 'C002'),
	(1009, 'C003'),
	(1043, 'C003'),
	(1026, 'C003'),
	(1013, 'C003'),
	(1016, 'C003'),
	(1019, 'C003'),
	(1004, 'C003');
GO

INSERT INTO Mes (Mes)
VALUES ('Enero'),
		('Febrero'),
		('Marzo'),
		('Abril'),
		('Mayo'),
		('Junio'),
		('Julio'),
		('Agosto'),
		('Septiembre'),
		('Octubre'),
		('Noviembre'),
		('Diciembre');
GO

INSERT Recibo (Importe, Pagado) 
	VALUES (157.8900, 1),
			(802.4300, 0),
			(153.4000, 0),
			(921.6300, 0),
			(281.5800, 1),
			(913.8100, 1),
			(337.4500, 1),
			(607.6200, 1),
			(894.3000, 0),
			(944.5000, 0),
			(482.1300, 1),
			(907.2000, 1),
			(527.7100, 1),
			(62.5100, 0),
			(854.5300, 1);
GO

INSERT ReservaSocio(FkReserva, FkSocio)
	VALUES (9, 1036),
			(4, 1049),
			(12, 1025),
			(32, 1051),
			(39, 1030),
			(22, 1026),
			(48, 1052),
			(40, 1028),
			(32, 1041),
			(47, 1002),
			(50, 1000),
			(26, 1036),
			(22, 1043),
			(19, 1021),
			(19, 1027),
			(31, 1007),
			(47, 1000),
			(41, 1010),
			(38, 1020),
			(41, 1040),
			(1, 1026),
			(8, 1013),
			(18, 1049),
			(20, 1011),
			(32, 1004),
			(23, 1012),
			(49, 1043),
			(21, 1018),
			(14, 1000),
			(39, 1024),
			(39, 1023),
			(9, 1039),
			(22, 1039),
			(24, 1021),
			(20, 1005),
			(6, 1039),
			(5, 1048),
			(24, 1043),
			(28, 1002),
			(4, 1001),
			(18, 1024),
			(21, 1037),
			(14, 1035),
			(39, 1002),
			(49, 1002),
			(39, 1034),
			(32, 1029),
			(30, 1021),
			(13, 1031),
			(18, 1019),
			(20, 1013),
			(48, 1045);
GO

INSERT ReciboMes (Anyo, FkRecibo, FkMes, FkSocioCurso) 
	VALUES (2023, 1, 1, 1),
			(2023, 2, 2, 2),
			(2023, 3, 3, 3),
			(2023, 4, 4, 4),
			(2023, 5, 5, 5),
			(2023, 6, 6, 6),
			(2023, 7, 7, 7),
			(2023, 8, 8, 8),
			(2023, 9, 9, 9),
			(2023, 10, 10, 10),
			(2023, 11, 11, 11),
			(2023, 12, 12, 12),
			(2023, 13, 1, 13),
			(2023, 14, 2, 14),
			(2023, 15, 3, 15);
		
GO
