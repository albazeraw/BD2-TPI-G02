USE master;
GO
DROP DATABASE IF EXISTS BdCine;
GO
CREATE DATABASE BdCine
GO
USE BdCine
GO


-- TABLAS SIN DEPENDENCIAS (van primero)


CREATE TABLE TipoUsuarios(
    IDTipoUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    TipoUsuario nvarchar(15)
)

CREATE TABLE Paises(
    IDPais bigint IDENTITY (1,1) PRIMARY KEY,
    Pais NVARCHAR(50)
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

-------------------------------------
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
-------------------------------------------------
-- USUARIOS (depende de Paises y TipoUsuarios)


CREATE TABLE Usuarios(
    IDUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    IDPais BIGINT,
    IDTipoUsuario BIGINT,
    Nombre nvarchar(50),
    Mail nvarchar(100),
    Contrasena NVARCHAR(20),
    FechaInicio DATE,
    CONSTRAINT FK_Usu_Pais FOREIGN KEY (IDPais) REFERENCES Paises(IDPais),
    CONSTRAINT FK_Usu_TipoUsuario FOREIGN KEY (IDTipoUsuario) REFERENCES TipoUsuarios(IDTipoUsuario)
)

-- =============================================
-- TABLAS INTERMEDIAS Y DEPENDIENTES
-- =============================================

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
    IDUsuario BIGINT,
    IDPelicula BIGINT,
    FechaReproduccion date,
    CONSTRAINT FK_Hist_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    CONSTRAINT FK_Hist_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas(IDPelicula)
)

CREATE TABLE Favoritos(
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaMarcado DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDUsuario, IDPelicula),
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
    NombreLista nvarchar(100) NOT NULL,
    Descripcion NVARCHAR(500) NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    EsPublica bit NOT NULL DEFAULT 1,
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