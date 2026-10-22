-- Sistema de Gestión de Trabajos de Grado - UTS
-- Esquema de la base de datos (PostgreSQL)

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Roles de usuario
CREATE TABLE roles (
    id_rol  SERIAL PRIMARY KEY,
    nombre  VARCHAR(30) NOT NULL UNIQUE
);

-- Cuentas de usuario
CREATE TABLE usuarios (
    id_usuario      SERIAL PRIMARY KEY,
    id_rol          INT NOT NULL REFERENCES roles (id_rol),
    nombres         VARCHAR(100) NOT NULL,
    apellidos       VARCHAR(100) NOT NULL,
    identificacion  VARCHAR(20)  NOT NULL UNIQUE,
    correo          VARCHAR(150) NOT NULL UNIQUE,
    contrasena      VARCHAR(255) NOT NULL,
    activo          BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_registro  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Programas académicos
CREATE TABLE programas (
    id_programa  SERIAL PRIMARY KEY,
    nombre       VARCHAR(150) NOT NULL UNIQUE
);

-- Datos del estudiante e inscripción
CREATE TABLE estudiantes (
    id_estudiante            SERIAL PRIMARY KEY,
    id_usuario               INT NOT NULL UNIQUE REFERENCES usuarios (id_usuario),
    id_programa              INT NOT NULL REFERENCES programas (id_programa),
    semestre                 INT NOT NULL,
    estado_inscripcion       VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    observacion_inscripcion  TEXT,
    id_revisor               INT REFERENCES usuarios (id_usuario),
    fecha_revision           TIMESTAMP
);

-- Fases del trabajo de grado
CREATE TABLE fases (
    id_fase      INT PRIMARY KEY,
    nombre       VARCHAR(80) NOT NULL,
    descripcion  VARCHAR(300) NOT NULL
);

-- Banco de ideas
CREATE TABLE ideas (
    id_idea         SERIAL PRIMARY KEY,
    id_autor        INT NOT NULL REFERENCES usuarios (id_usuario),
    titulo          VARCHAR(250) NOT NULL,
    objetivo        TEXT NOT NULL,
    problematica    TEXT NOT NULL,
    estado          VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    observacion     TEXT,
    id_revisor      INT REFERENCES usuarios (id_usuario),
    fecha_registro  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_revision  TIMESTAMP
);

-- Proyectos de grado
CREATE TABLE proyectos (
    id_proyecto         SERIAL PRIMARY KEY,
    id_idea             INT NOT NULL REFERENCES ideas (id_idea),
    id_fase             INT NOT NULL DEFAULT 1 REFERENCES fases (id_fase),
    estado              VARCHAR(20) NOT NULL DEFAULT 'EN_CURSO',
    responsable_actual  VARCHAR(20) DEFAULT 'ESTUDIANTE',
    fecha_inicio        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin           TIMESTAMP,
    observacion_cierre  TEXT
);

-- Estudiantes de cada proyecto
CREATE TABLE proyecto_estudiantes (
    id_proyecto     INT NOT NULL REFERENCES proyectos (id_proyecto),
    id_estudiante   INT NOT NULL REFERENCES estudiantes (id_estudiante),
    es_responsable  BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id_proyecto, id_estudiante)
);

-- Director y evaluador de cada proyecto
CREATE TABLE asignaciones (
    id_asignacion     SERIAL PRIMARY KEY,
    id_proyecto       INT NOT NULL REFERENCES proyectos (id_proyecto),
    id_usuario        INT NOT NULL REFERENCES usuarios (id_usuario),
    funcion           VARCHAR(20) NOT NULL,
    fecha_asignacion  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (id_proyecto, funcion)
);

-- Historial de versiones de los documentos entregados
CREATE TABLE historial_versiones (
    id_version              SERIAL PRIMARY KEY,
    id_proyecto             INT NOT NULL REFERENCES proyectos (id_proyecto),
    tipo_documento          VARCHAR(20) NOT NULL,
    version                 INT NOT NULL DEFAULT 1,
    url                     VARCHAR(500) NOT NULL,
    id_usuario              INT NOT NULL REFERENCES usuarios (id_usuario),
    fecha_entrega           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_version_relacionada  INT REFERENCES historial_versiones (id_version),
    UNIQUE (id_proyecto, tipo_documento, version)
);

-- Revisiones de cada versión
CREATE TABLE revisiones (
    id_revision     SERIAL PRIMARY KEY,
    id_version      INT NOT NULL REFERENCES historial_versiones (id_version),
    id_usuario      INT REFERENCES usuarios (id_usuario),
    funcion         VARCHAR(20) NOT NULL,
    estado          VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE_REVISION',
    observaciones   TEXT,
    fecha_creacion  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_revision  TIMESTAMP
);

-- Base documental
CREATE TABLE documentos_institucionales (
    id_documento  SERIAL PRIMARY KEY,
    nombre        VARCHAR(150) NOT NULL,
    url           VARCHAR(500) NOT NULL,
    activo        BOOLEAN NOT NULL DEFAULT TRUE
);

-- Datos iniciales
INSERT INTO roles (nombre) VALUES
    ('ADMINISTRADOR'),
    ('COMITE'),
    ('DOCENTE'),
    ('ESTUDIANTE');

INSERT INTO fases (id_fase, nombre, descripcion) VALUES
    (1, 'Idea y pago',
        'Estudiante y comité: el estudiante registra el soporte de pago; el comité lo revisa y asigna director y evaluador.'),
    (2, 'Entrega del anteproyecto',
        'Estudiante y director: entrega y revisión del F-DC-124. Tiempo máximo de referencia: el director revisa en 5 días; el anteproyecto debe quedar aprobado hasta la semana 12 del periodo.'),
    (3, 'Evaluación del anteproyecto',
        'Evaluador y comité: evaluación del F-DC-124 aprobado por el director. Tiempo máximo de referencia: el evaluador revisa en 5 días.'),
    (4, 'Entrega del informe final',
        'Estudiante y director: entrega y revisión del F-DC-125. Tiempo de referencia: mínimo 3 meses y máximo 180 días desde la aprobación del anteproyecto; el director revisa en 5 días.'),
    (5, 'Evaluación del informe final',
        'Evaluador y comité: evaluación del F-DC-125 con la rejilla F-DC-129. Tiempo máximo de referencia: el evaluador revisa en 5 días.'),
    (6, 'Cierre',
        'Comité: verifica los requisitos externos (sustentación y entrega institucional) y cierra el proyecto.');

INSERT INTO programas (nombre) VALUES
    ('Tecnología en Desarrollo de Sistemas Informáticos'),
    ('Ingeniería de Sistemas');

