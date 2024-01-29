-- Insertar en la tabla USUARIO
Use aulavirtual;
INSERT INTO USUARIO (usuarioespol, nombre, apellido) VALUES
('usuario1@espol.edu.ec', 'Nombre1', 'Apellido1'),
('usuario2@espol.edu.ec', 'Nombre2', 'Apellido2');

-- Insertar en la tabla CURSO
INSERT INTO CURSO (idcurso, paralelo, materia, periodoacademico) VALUES
(1, 101, 'Matemáticas', '2022A'),
(2, 102, 'Historia', '2022A'),
(3, 103, 'Física', '2022A');

-- Insertar en la tabla CARRERA
INSERT INTO CARRERA (id_carrera, nombrecarrera) VALUES
(1, 'Ingeniería Informática'),
(2, 'Historia'),
(3, 'Física');

-- Insertar en la tabla ESTUDIANTE
INSERT INTO ESTUDIANTE (usuarioespol, nombre, apellido, matricula, carrera) VALUES
('usuario1@espol.edu.ec', 'Estudiante1', 'ApellidoEst1', 12345, 1);

-- Insertar en la tabla FACULTAD
INSERT INTO FACULTAD (id_facultad, nombre_facultad) VALUES
(1, 'Facultad de Ingeniería'),
(2, 'Facultad de Humanidades'),
(3, 'Facultad de Ciencias');

-- Insertar en la tabla PROFESOR
INSERT INTO PROFESOR (usuarioespol, nombre, apellido, facultad) VALUES
('usuario2@espol.edu.ec', 'Profesor1', 'ApellidoProf1', 1);

-- Insertar en la tabla FORO
INSERT INTO FORO (idforo, titulo, archivo, texto, fecha, tiempodisponibilidad, idcurso) VALUES
(1, 'Foro1', 'archivo1.pdf', 'Texto del foro 1', '2022-01-01 12:00:00', '2 horas', 1),
(2, 'Foro2', 'archivo2.pdf', 'Texto del foro 2', '2022-02-01 14:00:00', '1 hora', 2),
(3, 'Foro3', NULL, 'Texto del foro 3', '2022-03-01 16:00:00', '3 horas', 3);

-- Insertar en la tabla MODULO
INSERT INTO MODULO (idcurso, idmodulo, contenidodelcurso) VALUES
(1, 1, 'Contenido del módulo 1'),
(2, 2, 'Contenido del módulo 2'),
(3, 3, 'Contenido del módulo 3');

-- Insertar en la tabla PERTENECE
INSERT INTO PERTENECE (idcurso, usuarioespol) VALUES
(1, 'usuario1@espol.edu.ec'),
(2, 'usuario2@espol.edu.ec');


-- Insertar en la tabla COMENTARIO
INSERT INTO COMENTARIO (idcomentario, descripcion, foro) VALUES
(1, 'Comentario 1', 1),
(2, 'Comentario 2', 2),
(3, 'Comentario 3', 3);

-- Insertar en la tabla PERTENECEUF
INSERT INTO PERTENECEUF (usuarioespol, idforo) VALUES
('usuario1@espol.edu.ec', 1),
('usuario2@espol.edu.ec', 2);

-- Insertar en la tabla MENSAJE
INSERT INTO MENSAJE (idmensaje, texto, fechaenvio, destinatario, autor, user) VALUES
(1, 'Mensaje 1', '2022-01-01 10:00:00', 'destinatario1', 'autor1', 'usuario1@espol.edu.ec'),
(2, 'Mensaje 2', '2022-02-01 11:00:00', 'destinatario2', 'autor2', 'usuario2@espol.edu.ec');

-- Insertar en la tabla ENVIADO
INSERT INTO ENVIADO (idenviado, texto, fechaenvio, destinatario, autor) VALUES
(1, 'Enviado 1', '2022-01-01 10:00:00', 'destinatario1', 'autor1'),
(2, 'Enviado 2', '2022-02-01 11:00:00', 'destinatario2', 'autor2');