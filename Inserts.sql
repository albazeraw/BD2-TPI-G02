use BdMovieRaiting
GO
insert into tipousuarios(TipoUsuario)
VALUES 
('Normal'),
('Premium'),
('Administrador');

insert INTO Paises(Pais)
VALUES
('Argentina'),
('Chile'),
('Peru'),
('Bolivia'),
('Venezuela'),
('Brasil'),
('Colombia'),
('Ecuador'),
('Paraguay'),
('Uruguay'),
('Costa Rica'),
('El salvador'),
('Guatemala'),
('Honduras'),
('Nicaragua'),
('Panama'),
('Cuba'),
('Mexico'),
('Republica Dominicana'),
('Haiti')

insert INTO ClasificacionPublico(Clasificacion,Descripcion)
VALUES
('ATP','Apta para todo publico'),
('+13','+13: Contiene escenas que pueden no ser adecuadas para menores de 13 años.'),
('+16','+16: Contiene violencia, lenguaje o contenido no recomendado para menores de 16 años.'),
('+18','+18: Contenido exclusivo para adultos mayores de 18 años.+18: Contenido exclusivo para adultos mayores de 18 años.')

insert into Generos(Genero)
VALUES
('Accion'),
('Comedia'),
('Drama'),
('Terror'),
('Ciencia ficcion'),
('Suspenso'),
('Policial'),
('Romance'),
('Animacion'),
('Aventura'),
('Fantasia'),
('Documental'),
('Musical'),
('Misterio'),
('Belica'),
('Crimen'),
('Thriller'),
('Familiar')

insert INTO Directores(Nombre,apellido,FechaNacimiento,Nacionalidad)
VALUES
('Christopher','Nolan','1970-07-30','Britanico'),
('Quentin','Tarantino','1963-03-27','Estadounidense'),
('Steven','Spielberg','1946-12-18','Estadounidense'),
('Martin','Scorsese','1942-11-17','Estadounidense'),
('James','Cameron','1954-08-16','Canadiense'),
('Ridley','Scott','1937-11-30','Britanico'),
('Tim','Burton','1958-08-25','Britanico'),
('Denis','Villeneuve','1967-10-03','Canadiense'),
('David','Fincher','1962-08-28','Estadounidense'),
('Guy','Ritchie','1968-09-10','Britanico')

insert into Actores(nombre,apellido,FechaNacimiento,Nacionalidad)
VALUES
('Leonardo','Dicaprio','1974-11-11','Estadounidense'),
('Brad','Pitt','1963-12-18','Estadounidense'),
('Keanu','Reeves','1964-09-02','Canadiense'),
('Robert','Downey','1965-04-04','Estadounidense'),
('Tom','Holland','1996-06-01','Britanico'),
('Margot','Robbie','1990-07-02','Australiana'),
('Jenna','Ortega','2002-09-27','Estadounidense'),
('Christian','Bale','1974-01-30','Britanico'),
('Scarlet','Johanson','1984-11-22','Estadounidense'),
('Morgan','Freeman','1980-06-01','Estadounidense'),
('Ryan','Gosling','1980-11-12','Canadiense'),
('Anne','Hathaway','1982-11-12','Estadounidense'),
('Tom','Hardy','1977-09-15','Britanico'),
('Johny','Depp','1963-06-09','Estadounidense'),
('Natalie','Portman','1981-06-09','Estadounidense'),
('Sam','Worthington','1976-08-02','Australiano'),  
('Timothe','Chalamet','1995-12-27','Estadounidense'), 
('Rusell','Crowe','1964-04-07','Neozelandes'), 
('Richard','Atenborough','1923-08-29','Britanico') 

insert into Peliculas(IDClasificacion,IDDirector,Titulo,anio,Duracion,Sinopsis,ImagenURL,TrailerURL,FechaAgregado)
VALUES
(2, 1, 'Inception', 2010, 148, 'Un grupo de especialistas ingresa en los sueños de las personas para manipular informacion.','https://m.media-amazon.com/images/M/MV5BZjhkNjM0ZTMtNGM5MC00ZTQ3LTk3YmYtZTkzYzdiNWE0ZTA2XkEyXkFqcGc@._V1_.jpg','https://www.youtube.com/watch?v=YoHD9XEInc0',GETDATE()),
(4, 2, 'Pulp Fiction', 1994, 154, 'Historias criminales entrelazadas en Los Angeles con humor negro y violencia.','https://es.web.img3.acsta.net/img/05/66/05663f00b8b5df58b003aaf5c46ef8ad.jpg','https://www.youtube.com/watch?v=s7EdQ4FqbhY',GETDATE()),
(2, 3, 'Jurassic Park', 1993, 127, 'Un parque tematico de dinosaurios clonados pierde el control.','https://m.media-amazon.com/images/M/MV5BMjM2MDgxMDg0Nl5BMl5BanBnXkFtZTgwNTM2OTM5NDE@._V1_.jpg','https://www.youtube.com/watch?v=RtBuQmT6bb4',GETDATE()),
(4, 4, 'The Wolf of Wall Street', 2013, 180, 'La historia de un corredor de bolsa y sus excesos financieros.','https://m.media-amazon.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_.jpg','https://www.youtube.com/watch?v=DEMZSa0esCU',GETDATE()),
(2, 5, 'Avatar', 2009, 162, 'Un exmarine llega a un planeta habitado por una civilizacion alienigena.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQun06pnV7nBiQGyoAZZuPDKrRWhMU6gO1hnFovukQ2ohepSmIRHiqXvV1K845x4u53OdtaUkcKuP8OSV_BKOnxXKiO3G5xKYXI6kaNqVNa&s=10','https://www.youtube.com/watch?v=AZS_d_hS2dM',GETDATE()),
(3, 6, 'Gladiator', 2000, 155, 'Un general romano busca vengar la muerte de su familia y emperador.','https://pics.filmaffinity.com/Gladiator-368149580-large.jpg','https://www.youtube.com/watch?v=P5ieIbInFpg',GETDATE()),
(2, 8, 'Dune', 2021, 155, 'Un joven noble debe proteger el recurso mas valioso del universo.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsdVL72BAawCztqiP5LvNmff3FprPY_SWZNasadhqoKKjbg7TSb0W-JJ0Lpw2aKhiZhkB46kMn2CzgqJja7gRUfXzbaohnwBqVZ_C6ea0&s=10','https://www.youtube.com/watch?v=6OmJF6VjKMA',GETDATE()),
(4, 9, 'Fight Club', 1999, 139, 'Un hombre crea un club secreto de peleas que termina fuera de control.','https://m.media-amazon.com/images/M/MV5BOTgyOGQ1NDItNGU3Ny00MjU3LTg2YWEtNmEyYjBiMjI1Y2M5XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg','https://www.youtube.com/watch?v=BdJKm16Co6M',GETDATE()),
(3, 10, 'Sherlock Holmes', 2009, 128, 'El famoso detective investiga una amenaza sobrenatural en Londres.','https://pics.filmaffinity.com/sherlock_holmes-617003864-mmed.jpg','https://www.youtube.com/watch?v=wMK4s3MTeIg',GETDATE())

insert into Usuarios(IDPais,IDTipoUsuario,nombre,Mail,Contrasena,FechaInicio)
VALUES
(1,1,'Raul','raulperez@hotmail.com','Contrasenia123',GETDATE()),
(2,2,'Jorge','jorgebritos@hotmail.com','Contrasenia123',GETDATE()),
(3,3,'lautaro','lautarorodriguez@hotmail.com','Contrasenia123',GETDATE())

insert into PeliculasGeneros(IDPelicula,IDGenero)
VALUES
--Inception
(1,1),
(1,5),
(1,6),
(1,17),
--Pulp Fiction
(2,3),
(2,6),
(2,16),
(2,17),
--Jurassic Park
(3,1),
(3,5),
(3,10),
--The Wolf of Wall Street
(4,3),
(4,16),
--Avatar
(5,1),
(5,5),
(5,10),
(5,11),
--Gladiator
(6,1),
(6,3),
(6,10),
(6,15),
--Dune
(7,1),
(7,5),
(7,10),
(7,11),
--Fight Club
(8,3),
(8,17),
-- Sherlock Holmes
(9,1),
(9,7),
(9,14),
(9,17)

insert into PeliculasActores(IDPelicula,IDActor,Personaje)
VALUES
-- Inception
(1,1,'Cobb'),
-- Jurassic Park
(3,19,'John Hammond'),
-- The Wolf of Wall Street
(4,1,'Jordan Belfort'),
(4,6,'Naomi Lapaglia'),
-- Avatar
(5,16,'Jake Sully'),
-- Gladiator
(6,18,'Maximus'),
-- Dune
(7,17,'Paul Atreides'),
-- Fight Club
(8,2,'Tyler Durden'),
-- Sherlock Holmes
(9,4,'Sherlock Holmes')


insert into HistorialReproduccion(IDUsuario,IDPelicula,FechaReproduccion)
VALUES
(1,1,GETDATE()),
(1,5,GETDATE()),
(2,8,GETDATE())

insert into Favoritos(IDUsuario,IDPelicula,FechaMarcado)
VALUES
(1,1,GETDATE()),
(1,5,GETDATE()),
(2,8,GETDATE())

insert into Watchlist(IDUsuario,IDPelicula,FechaAgregado)
VALUES
(1,7,GETDATE()),
(1,9,GETDATE()),
(2,5,GETDATE()),
(3,1,GETDATE())

insert into Listas(IDUsuario,NombreLista,Descripcion,FechaCreacion,EsPublica)
VALUES
(1,'favoritas','peliculas que mas me gustron',GETDATE(),1),
(1,'pendientes','peliculas que quiero ver despues',GETDATE(),0),
(2,'accion','peliculas de accion recomendadas',GETDATE(),1),
(3,'ciencia ficcion','peliculas de este genero que me gustaron',GETDATE(),1)

insert into PeliculasPorLista(IDLista,IDPelicula,FechaAgregado)
VALUES
(1,1,GETDATE()),
(1,8,GETDATE()),
(2,7,GETDATE()),
(2,9,GETDATE()),
(3,5,GETDATE()),
(3,6,GETDATE()),
(4,1,GETDATE()),
(4,7,GETDATE())

insert into Comentarios(IDUsuario,IDPelicula,Comentario,FechaComentario)
VALUES
(1,1,'muy buena peli, el final me volo la cabeza',GETDATE()),
(2,8,'de las mejores peliculas que vi',GETDATE()),
(3,5,'muy buenos efectos visuales',GETDATE()),
(1,7,'medio larga pero esta buena',GETDATE()),
(2,9,'muy entretenida la verdad',GETDATE()),
(3,4,'leonardo actua muy bien aca',GETDATE()),
(1,6,'las escenas de pelea estan tremendas',GETDATE())

insert into Puntuaciones(IDUsuario,IDPelicula,Puntaje,FechaPuntuacion)
VALUES
(1,1,10,GETDATE()),
(1,5,8,GETDATE()),
(2,8,9,GETDATE()),
(2,5,7,GETDATE()),
(3,1,9,GETDATE())