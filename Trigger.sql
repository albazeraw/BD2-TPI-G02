USE BdMovieRaiting
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

-- =============================================
-- TRIGGER que valida que el usuario haya visto
-- la película antes de poder puntuarla :)
-- =============================================
CREATE TRIGGER trg_Puntuaciones_UsuarioDebeHaberVistoPelicula
ON Puntuaciones
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificamos si el usuario tiene la película en su historial
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1
            FROM HistorialReproduccion hr
            WHERE hr.IDUsuario  = i.IDUsuario
              AND hr.IDPelicula = i.IDPelicula
        )
    )
    BEGIN
        RAISERROR('No podés puntuar una película que no hayas visto. Agregala primero a tu historial.', 16, 1);
        RETURN;
    END

    -- Si la validación pasa, insertamos normalmente
    INSERT INTO Puntuaciones (IDUsuario, IDPelicula, Puntaje, FechaPuntuacion)
    SELECT IDUsuario, IDPelicula, Puntaje, FechaPuntuacion
    FROM inserted;
END
GO

create TRIGGER Tr_ValidarNombreLista
on Listas 
instead of INSERT
as 
BEGIN
if EXISTS(
    select 1 
    from inserted
    where LTRIM(RTRIM(NombreLista))=''
    )
    BEGIN 
    RAISERROR('No podes ingresar un nombre de lista vacio',16,1)
    RETURN;
END 

insert INTO Listas(IDUsuario,NombreLista,descripcion,FechaCreacion,EsPublica)
select IDUsuario,NombreLista,descripcion,FechaCreacion,EsPublica
from inserted;
end
GO

create TRIGGER Tr_ValidarComentariosVacios
on comentarios
instead of INSERT
AS
BEGIN
if EXISTS(
    select 1 
    from inserted
    where LTRIM(RTRIM(comentario))=''
)
BEGIN 
RAISERROR('No podes ingresar un comentario vacio',16,1)
RETURN;
END
INSERT INTO comentarios(IDUsuario,IDPelicula,comentario,FechaComentario)
select IDUsuario,IDPelicula,comentario,FechaComentario
from inserted;
END 
go