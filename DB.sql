USE master;
GO
DROP DATABASE IF EXISTS BdMovieRaiting;
GO
CREATE DATABASE BdMovieRaiting
GO
USE BdMovieRaiting
GO

-- TABLAS SIN DEPENDENCIAS (van primero)

CREATE TABLE TipoUsuarios(
    IDTipoUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    TipoUsuario nvarchar(15) NOT NULL
)

CREATE TABLE Paises(
    IDPais bigint IDENTITY (1,1) PRIMARY KEY,
    Pais NVARCHAR(50) NOT NULL
)

CREATE TABLE ClasificacionPublico (
    IDClasificacion bigint IDENTITY(1,1) PRIMARY KEY,
    Clasificacion nvarchar(20) NOT NULL,
    Descripcion nvarchar(200) NULL
)

CREATE TABLE Generos (
    IDGenero bigint IDENTITY(1,1) PRIMARY KEY,
    Genero nvarchar(50) NOT NULL
)

CREATE TABLE Directores (
    IDDirector bigint IDENTITY(1,1) PRIMARY KEY,
    Nombre nvarchar(50) NOT NULL,
    Apellido nvarchar(50) NOT NULL,
    FechaNacimiento DATE NULL,
    Nacionalidad nvarchar(50) NULL
)

CREATE TABLE Actores (
    IDActor bigint IDENTITY(1,1) PRIMARY KEY,
    Nombre nvarchar(50) NOT NULL,
    Apellido nvarchar(50) NOT NULL,
    FechaNacimiento DATE NULL,
    Nacionalidad nvarchar(50) NULL
)

-- PELICULAS (depende de Clasificacion y Directores)


CREATE TABLE Peliculas (
    IDPelicula bigint IDENTITY(1,1) PRIMARY KEY,
    IDClasificacion bigint NOT NULL,
    IDDirector bigint NOT NULL,
    Titulo nvarchar(200) NOT NULL,
    Anio int NOT NULL,
    Duracion int NOT NULL,
    Sinopsis nvarchar(1000) NULL,
    ImagenURL nvarchar(500) NULL,
    TrailerURL nvarchar(500) NULL,
    FechaAgregado DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Pel_Clasificacion FOREIGN KEY (IDClasificacion) REFERENCES ClasificacionPublico(IDClasificacion),
    CONSTRAINT FK_Pel_Director FOREIGN KEY (IDDirector) REFERENCES Directores(IDDirector)
)

-- USUARIOS (depende de Paises y TipoUsuarios)


CREATE TABLE Usuarios(
    IDUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    IDPais BIGINT NOT NULL,
    IDTipoUsuario BIGINT NOT NULL,
    Nombre nvarchar(50) NOT NULL,
    Mail nvarchar(100) NOT NULL,
    Contrasena NVARCHAR(50) NOT NULL,
    FechaInicio DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Usu_Pais FOREIGN KEY (IDPais) REFERENCES Paises(IDPais),
    CONSTRAINT FK_Usu_TipoUsuario FOREIGN KEY (IDTipoUsuario) REFERENCES TipoUsuarios(IDTipoUsuario)
)

-- TABLAS INTERMEDIAS Y DEPENDIENTES


CREATE TABLE PeliculasGeneros (
    IDPelicula bigint NOT NULL,
    IDGenero bigint NOT NULL,
    PRIMARY KEY (IDPelicula, IDGenero),
    CONSTRAINT FK_PelGen_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula),
    CONSTRAINT FK_PelGen_Genero FOREIGN KEY (IDGenero) REFERENCES Generos(IDGenero)
)

CREATE TABLE PeliculasActores (
    IDPelicula bigint NOT NULL,
    IDActor bigint NOT NULL,
    Personaje nvarchar(100) NULL,
    PRIMARY KEY (IDPelicula, IDActor),
    CONSTRAINT FK_PelAct_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula),
    CONSTRAINT FK_PelAct_Actor FOREIGN KEY (IDActor) REFERENCES Actores(IDActor)
)

CREATE TABLE HistorialReproduccion(
    IDHistorialReproduccion bigint IDENTITY (1,1) PRIMARY KEY,
    IDUsuario BIGINT NOT NULL,
    IDPelicula BIGINT NOT NULL,
    FechaReproduccion date NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Hist_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    CONSTRAINT FK_Hist_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

create table Favoritos(
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaMarcado DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Favoritos PRIMARY KEY (IDUsuario, IDPelicula),
    CONSTRAINT FK_Fav_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    CONSTRAINT FK_Fav_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

CREATE TABLE Watchlist (
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaAgregado DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDUsuario, IDPelicula),
    CONSTRAINT FK_WatchL_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    CONSTRAINT FK_WatchL_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

CREATE TABLE Listas (
    IDLista bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
    IDUsuario bigint NOT NULL,
    NombreLista nvarchar (100) NOT NULL,
    Descripcion NVARCHAR (500) NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    EsPublica BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Listas_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
)

CREATE TABLE PeliculasPorLista (
    IDLista bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaAgregado DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDLista, IDPelicula),
    CONSTRAINT FK_PPorL_Lista FOREIGN KEY (IDLista) REFERENCES Listas(IDLista),
    CONSTRAINT FK_PPorL_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

CREATE TABLE Comentarios (
    IDComentario bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    Comentario nvarchar(1000) NOT NULL,
    FechaComentario DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT UQ_Com_Usuario_Pelicula UNIQUE (IDUsuario, IDPelicula),
    CONSTRAINT FK_Com_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    CONSTRAINT FK_Com_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

CREATE TABLE Puntuaciones (
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    Puntaje TINYINT NOT NULL,
    FechaPuntuacion DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDUsuario, IDPelicula),
    CONSTRAINT CHK_Puntaje CHECK (Puntaje BETWEEN 1 AND 10),
    CONSTRAINT FK_Punt_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    CONSTRAINT FK_Punt_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

GO

-- =============================================
-- VISTA de top de mejores pelis :)
-- =============================================

CREATE VIEW vw_TopPeliculas AS
SELECT
    p.IDPelicula,
    p.Titulo,
    p.Anio,
    p.Duracion,
    d.Nombre + ' ' + d.Apellido AS Director,
    c.Clasificacion,
    CAST(AVG(CAST(pu.Puntaje AS FLOAT)) AS DECIMAL(4,2)) AS PuntajePromedio,
    COUNT(pu.IDUsuario) AS CantidadVotos
FROM Peliculas p
    INNER JOIN Directores d       ON p.IDDirector     = d.IDDirector
    INNER JOIN ClasificacionPublico c ON p.IDClasificacion = c.IDClasificacion
    LEFT JOIN  Puntuaciones pu    ON p.IDPelicula      = pu.IDPelicula
GROUP BY
    p.IDPelicula,
    p.Titulo,
    p.Anio,
    p.Duracion,
    d.Nombre,
    d.Apellido,
    c.Clasificacion

GO

-- =============================================
-- TRIGGER de historial de reproducción para evitar duplicados diarios por usuario y película
-- =============================================

CREATE TRIGGER trg_HistorialReproduccion_NoDuplicadoDiario
ON HistorialReproduccion
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM HistorialReproduccion hr
        INNER JOIN inserted i
            ON hr.IDUsuario          = i.IDUsuario
            AND hr.IDPelicula        = i.IDPelicula
            AND hr.FechaReproduccion = i.FechaReproduccion
    )
    BEGIN
        RAISERROR('El usuario ya registró esta película en el historial para la fecha indicada.', 16, 1);
        RETURN;
    END

    INSERT INTO HistorialReproduccion (IDUsuario, IDPelicula, FechaReproduccion)
    SELECT IDUsuario, IDPelicula, FechaReproduccion
    FROM inserted;
END

GO
