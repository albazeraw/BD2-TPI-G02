use BdMovieRaiting;
GO

CREATE OR ALTER VIEW vw_TopPeliculas AS
SELECT
    p.IDPelicula, p.Titulo, p.Anio, p.Duracion,
    d.Nombre + ' ' + d.Apellido AS Director,
    c.Clasificacion,
    CAST(AVG(CAST(pu.Puntaje AS FLOAT)) AS DECIMAL(4,2)) AS PuntajePromedio,
    COUNT(pu.IDUsuario) AS CantidadVotos
FROM Peliculas p
INNER JOIN Directores d ON p.IDDirector = d.IDDirector
INNER JOIN ClasificacionPublico c ON p.IDClasificacion = c.IDClasificacion
LEFT JOIN Puntuaciones pu ON p.IDPelicula = pu.IDPelicula
GROUP BY p.IDPelicula, p.Titulo, p.Anio, p.Duracion,
    d.Nombre, d.Apellido, c.Clasificacion
GO

CREATE OR ALTER VIEW vw_PeliculasMasComentadas AS
SELECT p.Titulo, d.Nombre+' '+d.Apellido AS Director,
    COUNT(C.IDComentario) AS CantidadComentarios
FROM Peliculas p
INNER JOIN Directores D ON D.IDDirector = P.IDDirector
LEFT JOIN Comentarios C ON C.IDPelicula = P.IDPelicula
GROUP BY P.Titulo, D.Nombre, D.Apellido
GO

CREATE OR ALTER VIEW vw_UsuariosMasActivos AS
SELECT U.IDUsuario, U.Nombre,
    COUNT(DISTINCT HR.IDPelicula) AS CantidadPeliculasVistas,
    COUNT(DISTINCT F.IDPelicula) AS CantidadFavoritos,
    COUNT(DISTINCT C.IDComentario) AS CantidadComentarios
FROM Usuarios U
LEFT JOIN HistorialReproduccion HR ON HR.IDUsuario = U.IDUsuario
LEFT JOIN Favoritos F ON F.IDUsuario = U.IDUsuario
LEFT JOIN Comentarios C ON C.IDUsuario = U.IDUsuario
GROUP BY U.IDUsuario, U.Nombre
GO

CREATE OR ALTER VIEW vw_PeliculasSinPuntuar AS
SELECT p.IDPelicula, p.Titulo, p.Anio, p.Duracion,
    d.Nombre + ' ' + d.Apellido AS Director,
    c.Clasificacion
FROM Peliculas p
INNER JOIN Directores d ON p.IDDirector = d.IDDirector
INNER JOIN ClasificacionPublico c ON p.IDClasificacion = c.IDClasificacion
WHERE NOT EXISTS (
    SELECT 1 FROM Puntuaciones pu
    WHERE pu.IDPelicula = p.IDPelicula
)

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
--vista de Usuarios que comentan VS los que puntúan
CREATE VIEW vw_UsuariosComentanVsPuntuan AS
SELECT u.IDUsuario, u.Nombre,
COUNT (DISTINCT c.IDComentario) AS TotalComentarios,
COUNT (DISTINCT pu.IDPelicula) AS PeliculasPuntuadas,
AVG (pu.Puntaje) AS PromedioPuntaje,
    CASE 
        WHEN COUNT (DISTINCT c.IDComentario) > 10 THEN "Muy activo"
        WHEN COUNT (DISTINCT pu.IDPelicula) > 5 THEN "Activo"
        ELSE "Ocasional"
    END as NivelParticipación
FROM Usuarios U
LEFT JOIN Comentarios c on u.IDUsuario = pu.IDUsuario
LEFT join Puntuaciones pu on u.IDUsuario = pu.IDUsuario
GROUP BY u.IDUsuario, u.Nombre ORDER BY TotalComentarios DESC;

GO

--Tiempo total de vista por usuarios
CREATE VIEW vw_TiempoVistoPorUsuario AS
SELECT TOP 20
     u.IDUsuario, u.Nombre,
COUNT (h.IDPeliculas) as PeliculasVistas,
SUM (p.Duracion) as MinutosTotVistos,
ROUND (sum (p.Duracion) / 60.0, 2) as HorasTotVistas,
round (sum (p.Duracion) / 60.0 / 24.0, 1) as DiasTotVistas
FROM Usuarios U 
INNER JOIN HistorialReproduccion h on u.IDUsuario = h.IDUsuario
INNER join Peliculas p on h.IDPelicula = p.IDPelicua
GROUP BY u.IDUsuario, u.Nombre
order by HorasTotVistas DESC

GO