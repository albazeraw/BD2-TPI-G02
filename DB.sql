
create DATABASE BdCine

use BdCine

create table Usuarios(
    IDUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    IDPais BIGINT,
    IDIdioma bigint,
    IDSuscripcion BIGINT,
    IDTipoUsuario BIGINT,
    Nombre nvarchar(50),
    Mail nvarchar(100),
    Contrasena NVARCHAR(20),
    FechaInicio DATE
)
CREATE TABLE TipoUsuarios(
    IDTipoUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    TipoUsuario nvarchar(15)
)
CREATE TABLE HistorialReproduccion(
    IDHistorialReproduccion bigint IDENTITY (1,1)PRIMARY KEY,
    IDUsuario BIGINT,
    IDPelicula BIGINT,
    FechaReproduccion date
)
create table Paises(
    IDPais bigint IDENTITY (1,1) PRIMARY KEY,
    pais NVARCHAR(50)
)



create table Favoritos(
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaMarcado DATETIME NOT NULL DEFAULT GETDATE (),
    PRIMARY KEY (IDUsuario, IDPelicula),
    CONSTRAINT FK_Fav_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios (IDUsuario),
    CONSTRAINT FK_Fav_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas (IDPelicula),
)
create TABLE Watchlist (
    IDUsuario bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaAgregado DATETIME NOT NULL DEFAULT(),
    PRIMARY KEY (IDUsuario, IDPelicula),
    CONSTRAINT FK_WatchL_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios (IDUsuario),
    CONSTRAINT FK_WatchL_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas (IDPelicula),
)
create TABLE Listas (
    IDLista bigint NOT NULL IDENTITY (1,1) PRIMARY KEY,
    IDUsuario bigint NOT NULL,
    NombreLista nvarchar (100) NOT NULL,
    Descripcion NVARCHAR (500) NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE ()
    EsPublica bit NOT NULL default 1,
    CONSTRAINT FK_Listas_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
)
create TABLE PeliculasPorLista (
    IDLista bigint NOT NULL,
    IDPelicula bigint NOT NULL,
    FechaAgregado DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDListas, IDPelicula),
    CONSTRAINT FK_PPorL_Lista FOREIGN KEY (IDLista) REFERENCES Listas(IDLista),
    CONSTRAINT FK_PPorL_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas (IDPelicula),
)
create TABLE Comentarios (
    IDComentario bigint NOT NULL IDENTITY (1,1) PRIMARY KEY,
    IDUsuario bigint NOT NULL ,
    IDPelicula bigint NOT NULL,
    Comentario nvarchar NOT NULL,
    FechaComentario DATETIME NOT NULL DEFAULT GETDATE()
)
create TABLE Puntuaciones (
    IDUsuario bigint NOT NULL ,
    IDPelicula bigint NOT NULL ,
    Puntaje TINYINT NOT NULL,
    FechaPuntuacion DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (IDUsuario, IDPelicula),
    CONSTRAINT CHK__Puntaje CHECK (Puntaje BETWEEN 1 AND 10),
    CONSTRAINT FK_Punt_Usuario FOREIGN KEY (IDUsuario) REFERENCES Usuarios (IDUsuario),
    CONSTRAINT FK_Punt_Pelicula FOREIGN KEY (IDPelicula) REFERENCES Peliculas (IDPelicula),
)
