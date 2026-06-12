use BdMovieRaiting; 
go 

create PROCEDURE sp_AgregarPeliculaALista
    @IDLista BIGINT,
    @IDPelicula BIGINT,
    @FechaAgregado DATETIME
--validamos que exista el id de lista recibido
as BEGIN 
IF NOT EXISTS(
    select L.IDLista FROM Listas L
    WHERE L.IDLista=@IDLista
)
BEGIN
PRINT 'El IDLista recibido no corresponde a niguna lista existente'
RETURN
END
--validamos que exista el id de pelicula recibido
IF NOT EXISTS(
    SELECT P.IDPelicula FROM Peliculas P
    WHERE P.IDPelicula=@IDPelicula
)
BEGIN
PRINT 'El IDPelicula recibido no corresponde a niguna pelicula existente'
RETURN
END
-- verificamos que la pelicula no se encuentre presente en la lista
IF EXISTS(
    select PL.IDPelicula,PL.IDLista FROM PeliculasPorLista PL
    WHERE @IDPelicula=PL.IDPelicula AND pl.IDLista=@IDLista

)
BEGIN
PRINT 'El ID de pelicula recibido ya existe en la lista'
RETURN
END

INSERT INTO PeliculasPorLista(IDLista,IDPelicula,FechaAgregado)
VALUES(@IDLista,@IDPelicula,@FechaAgregado)
print 'Se agrego la pelicula a la lista correctamente'
end;
GO

CREATE PROCEDURE sp_MoverDeWatchlistAFavoritos
    @IDUsuario bigint
    @IDPelicula bigint
AS BEGIN
    BEGIN TRY
    --validar que el usuario existe y está activo
        if NOT EXISTS (select 1 from Usuarios WHERE IDUsuario = @IDUsuario AND Activo = 1)
        BEGIN
            RAISERROR ('El usuario está inactivo', 16, 1);
            RETURN;
        END
        --validar que la pelicula existe
        if not EXISTS ( SELECT 1 from Peliculas WHERE IDPelicula = @IDPelicula AND Activo =1)
        BEGIN
            RAISERROR ('La película no existe', 16, 1);
            RETURN;
        END
        --validar que la pelicula está en Whatchlist
        if not EXISTS (SELECT 1 from Watchlist WHERE IDUsuario = @IDUsuario and IDPelicula = @IDPelicula)
        BEGIN
            RAISERROR ( 'La pelicula no está en Watchlist', 16, 1);
            RETURN;
        END
        --validar que la pelicula no está todavia en favoritos
        IF EXISTS (SELECT 1 FROM Favoritos WHERE IDUsuario = @IDUsuario AND IDPelicula = @IDPelicula)
        BEGIN
            RAISERROR('La película ya está en Favoritos', 16, 1);
            RETURN;
        END

        --Transacción para que se ejecuten las dos opéraciones, se elimine de watchlist y se inserte en Favoritos
        BEGIN TRANSACTION
        DELETE from Watchlist WHERE IDUsuario = @IDUsuario and IDPelicula = @IDPelicula

        INSERT INTO Favoritos (IDUsuario, IDPelicula, FechaMarcado)
        VALUES (@IDUsuario, @IDPelicula, GETDATE());
        COMMIT TRANSACTION
    
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        RAISERROR ('No se pudo concretar el cambio de lista', 16, 1)
    END CATCH
END