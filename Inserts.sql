use BdCine
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
VALUES('ATP','Apta para todo publico'),
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
VALUES('Christopher','Nolan','1970-07-30','Britanico'),
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
VALUES('Leonardo','Dicaprio','1974-11-11','Estadounidense'),
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
('Natalie','Portman','1981-06-09','Estadounidense')
