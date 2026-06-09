use BdMovieRaiting;
go
create FUNCTION FN_duracionTotalLista(@IdLista BIGINT)
RETURNS VARCHAR(50)
AS BEGIN
DECLARE @horas INT;
DECLARE @minutos int;
DECLARE @DuracionTotal int;
SELECT @DuracionTotal= SUM(P.Duracion)
FROM Peliculas P
INNER JOIN PeliculasPorLista PL ON PL.IDPelicula=P.IDPelicula
 where pl.IDLista=@IdLista
set @DuracionTotal=ISNULL(@DuracionTotal,0)
set @minutos=@DuracionTotal%60
set @horas=@DuracionTotal/60
RETURN CAST(@horas as VARCHAR(25))+' horas y '+CAST(@minutos as VARCHAR(25))+' Minutos';
END;
GO

