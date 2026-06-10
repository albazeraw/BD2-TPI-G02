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