CREATE VIEW vista1 AS
SELECT idforo, titulo, texto
FROM FORO;

CREATE VIEW vista2 AS
SELECT idcurso, materia, periodoacademico
FROM CURSO;
-- Trigger 1: Validación de Fechas en la Tabla ENVIADO

DELIMITER //

CREATE TRIGGER valida_fecha_enviado
BEFORE INSERT ON ENVIADO
FOR EACH ROW
BEGIN
    IF NEW.fechaenvio > NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de envío no puede ser en el futuro';
    END IF;
END //

DELIMITER ;

-- Trigger 2: Actualización de Fechas en la Tabla ENTREGA

DELIMITER //

CREATE TRIGGER actualiza_fecha_entrega
BEFORE UPDATE ON ENTREGA
FOR EACH ROW
BEGIN
    SET NEW.fechaentrega = NOW();
END //

DELIMITER ;

-- REPORTES
-- Reporte 1: Estudiantes y sus Cursos
SELECT ESTUDIANTE.usuarioespol, ESTUDIANTE.nombre, ESTUDIANTE.apellido, CURSO.materia
FROM ESTUDIANTE
JOIN PERTENECE ON ESTUDIANTE.usuarioespol = PERTENECE.usuarioespol
JOIN CURSO ON PERTENECE.idcurso = CURSO.idcurso;

-- Reporte 2: Evaluaciones y Calificaciones
SELECT EVALUACION.titulo, EVALUACION.calificacion, PROFESOR.nombre AS nombre_profesor
FROM EVALUACION
JOIN PROFESOR ON EVALUACION.profesor = PROFESOR.usuarioespol;

-- Reporte 3: Foros y Comentarios
SELECT FORO.idforo, FORO.titulo, COUNT(COMENTARIO.idcomentario) AS num_comentarios
FROM FORO
LEFT JOIN COMENTARIO ON FORO.idforo = COMENTARIO.foro
GROUP BY FORO.idforo, FORO.titulo;


-- Reporte 4: Mensajes Enviados
SELECT MENSAJE.texto, MENSAJE.fechaenvio, USUARIO.nombre AS autor, ENVIADO.destinatario
FROM MENSAJE
JOIN ENVIADO ON MENSAJE.idmensaje = ENVIADO.idenviado
JOIN USUARIO ON MENSAJE.user = USUARIO.usuarioespol;

-- STORED PROCEDURES
-- SP Inserción de Estudiante:
DELIMITER //

CREATE PROCEDURE insertar_estudiante(
    IN p_usuarioespol VARCHAR(255),
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_matricula INT,
    IN p_carrera INT
)
BEGIN
    INSERT INTO ESTUDIANTE (usuarioespol, nombre, apellido, matricula, carrera)
    VALUES (p_usuarioespol, p_nombre, p_apellido, p_matricula, p_carrera);
END //

DELIMITER ;


-- SP Actualización de Evaluación:
DELIMITER //

CREATE PROCEDURE actualizar_evaluacion(
    IN p_idevaluacion INT,
    IN p_comentario VARCHAR(255),
    IN p_calificacion FLOAT
)
BEGIN
    UPDATE EVALUACION
    SET comentario = p_comentario, calificacion = p_calificacion
    WHERE idevaluacion = p_idevaluacion;
END //

DELIMITER ;


-- SP Eliminación de Comentario:
DELIMITER //

CREATE PROCEDURE eliminar_comentario(
    IN p_idcomentario INT
)
BEGIN
    DELETE FROM COMENTARIO WHERE idcomentario = p_idcomentario;
END //

DELIMITER ;

### Índices:

-- 1. Índice en la columna `usuarioespol` de la tabla `USUARIO` para acelerar búsquedas por este campo.
-- ```sql
CREATE INDEX idx_usuario_usuarioespol ON USUARIO(usuarioespol);


-- 2 Índice en la columna idcurso de la tabla PERTENECE para mejorar la eficiencia en la búsqueda de cursos para un estudiante.
CREATE INDEX idx_pertenece_idcurso ON PERTENECE(idcurso);

-- 3 Índice en la columna idforo de la tabla PERTENECEUF para acelerar las consultas relacionadas con usuarios y foros.
CREATE INDEX idx_perteneceuf_idforo ON PERTENECEUF(idforo);

-- 4 Índice en la columna profesor de la tabla ANUNCIO para optimizar búsquedas relacionadas con anuncios de un profesor.
CREATE INDEX idx_anuncio_profesor ON ANUNCIO(profesor);

-- 5 Índice compuesto en las columnas usuarioespol e idforo de la tabla PERTENECEUF para mejorar la eficiencia en consultas específicas.
CREATE INDEX idx_perteneceuf_usuarioespol_idforo ON PERTENECEUF(usuarioespol, idforo);



-- Usuarios y permisos
-- Usuario con permisos para ejecutar el SP insertar_estudiante:
CREATE USER 'usuario_estudiante'@'localhost' IDENTIFIED BY 'password';
GRANT EXECUTE ON PROCEDURE aulavirtual.insertar_estudiante TO 'usuario_estudiante'@'localhost';

-- Usuario 1 con permisos para ejecutar el SP actualizar_evaluacion y eliminar_comentario:
CREATE USER 'usuario_admin'@'localhost' IDENTIFIED BY 'password';
GRANT EXECUTE ON PROCEDURE aulavirtual.actualizar_evaluacion TO 'usuario_admin'@'localhost';
GRANT EXECUTE ON PROCEDURE aulavirtual.eliminar_comentario TO 'usuario_admin'@'localhost';

-- Crear Vistas


-- Usuario 2 Permisos para SELECT en vistas específicas:
GRANT SELECT ON aulavirtual.vista1 TO 'usuario1'@'localhost';
GRANT SELECT ON aulavirtual.vista2 TO 'usuario2'@'localhost';

-- Usuario 3 con permisos para ejecutar el SP
CREATE USER 'usuario_sp'@'localhost' IDENTIFIED BY 'password';
GRANT EXECUTE ON PROCEDURE aulavirtual.nombre_del_sp TO 'usuario_sp'@'localhost';

-- Usuario 4 con permisos para SELECT en vistas
CREATE USER 'usuario_vistas'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON aulavirtual.vista1 TO 'usuario_vistas'@'localhost';
GRANT SELECT ON aulavirtual.vista2 TO 'usuario_vistas'@'localhost';


-- Usuario 5 con permisos para SP y vistas
CREATE USER 'usuario_sp_vistas'@'localhost' IDENTIFIED BY 'password';
GRANT EXECUTE ON PROCEDURE aulavirtual.nombre_del_sp TO 'usuario_sp_vistas'@'localhost';
GRANT SELECT ON aulavirtual.vista1 TO 'usuario_sp_vistas'@'localhost';
GRANT SELECT ON aulavirtual.vista2 TO 'usuario_sp_vistas'@'localhost';


-- Conexión del Programa con SP:
-- PENDIENTE










