use BdMovieRaiting; 
go 
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

--Vista peliculas mas comentadas
create view vw_PeliculasMasComentadas as
select p.titulo, d.nombre+' '+d.apellido as director, count(C.IDComentario) AS cantidadComentarios from Peliculas p
INNER JOIN Directores D on D.IDDirector=P.IDDirector
LEFT JOIN  Comentarios C ON C.IDPelicula=P.IDPelicula
GROUP BY P.Titulo,D.Nombre,D.Apellido;
GO
--vista usuarios mas activos
create view vw_UsuariosMasActivos AS
select U.IDUsuario,U.Nombre,Count(distinct HR.IDPelicula) as CantidadPeliculasVistas,COUNT(distinct F.IDPelicula) AS CantidadFavoritos,COUNT(distinct C.IDComentario) as cantidadComentarios from Usuarios U
LEFT JOIN HistorialReproduccion HR ON HR.IDUsuario=U.IDUsuario
LEFT JOIN Favoritos F ON F.IDUsuario=U.IDUsuario
LEFT JOIN Comentarios C ON C.IDUsuario=U.IDUsuario
GROUP BY U.IDUsuario,U.Nombre;
GO

