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