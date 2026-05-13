
create DATABASE BdCine
GO
use BdCine

create table usuarios(
    IDUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    IDPais BIGINT,
    IDIdioma bigint,
    IDSuscripcion BIGINT,
    IDTipoUsuario BIGINT,
    Nombre varchar(50),
    Mail varchar(100),
    Contrasena VARCHAR(20),
    FechaInicio DATE
)
CREATE TABLE TipoUsuarios(
    IDTipoUsuario bigint IDENTITY (1,1) PRIMARY KEY,
    TipoUsuario varchar(15)
)
CREATE TABLE HistorialReproduccion(
    IDHistorialReproduccion bigint IDENTITY (1,1)PRIMARY KEY,
    IDUsuario BIGINT,
    IDPelicula BIGINT,
    FechaReproduccion date
)
create table Paises(
    IDPais bigint IDENTITY (1,1) PRIMARY KEY,
    pais VARCHAR(50)
)