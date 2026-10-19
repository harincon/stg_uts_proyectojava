-- Datos de prueba: usuarios de todos los roles e ideas y proyectos en varias fases.
-- Contraseña de todos los usuarios de prueba: Clave123

-- Usuarios
INSERT INTO usuarios (id_rol, nombres, apellidos, identificacion, correo, contrasena, activo) VALUES
    (2, 'Ana María', 'Rueda',      '1001', 'comite1@uts.edu.co',  crypt('Clave123', gen_salt('bf')), TRUE),
    (2, 'Jorge',     'Pinzón',     '1002', 'comite2@uts.edu.co',  crypt('Clave123', gen_salt('bf')), TRUE),
    (3, 'Carlos',    'Méndez',     '2001', 'docente1@uts.edu.co', crypt('Clave123', gen_salt('bf')), TRUE),
    (3, 'Marta',     'Villamizar', '2002', 'docente2@uts.edu.co', crypt('Clave123', gen_salt('bf')), TRUE),
    (3, 'Luis',      'Ardila',     '2003', 'docente3@uts.edu.co', crypt('Clave123', gen_salt('bf')), TRUE),
    (3, 'Sandra',    'Ortiz',      '2004', 'docente4@uts.edu.co', crypt('Clave123', gen_salt('bf')), TRUE),
    (3, 'Pedro',     'Salazar',    '2005', 'docente5@uts.edu.co', crypt('Clave123', gen_salt('bf')), FALSE),
    (4, 'Laura',     'Pérez',      '3001', 'est1@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Diego',     'Gómez',      '3002', 'est2@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Valentina', 'Cruz',       '3003', 'est3@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Andrés',    'Rojas',      '3004', 'est4@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Camila',    'Torres',     '3005', 'est5@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Santiago',  'Díaz',       '3006', 'est6@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Natalia',   'Suárez',     '3007', 'est7@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Felipe',    'Castro',     '3008', 'est8@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE),
    (4, 'Juliana',   'Herrera',    '3009', 'est9@uts.edu.co',     crypt('Clave123', gen_salt('bf')), TRUE);

-- Estudiantes
INSERT INTO estudiantes (id_usuario, id_programa, semestre, estado_inscripcion, observacion_inscripcion, id_revisor, fecha_revision)
SELECT u.id_usuario, d.id_programa, d.semestre, d.estado, d.observacion,
       CASE WHEN d.estado = 'PENDIENTE' THEN NULL
            ELSE (SELECT id_usuario FROM usuarios WHERE correo = 'comite1@uts.edu.co') END,
       CASE WHEN d.estado = 'PENDIENTE' THEN NULL ELSE CURRENT_TIMESTAMP - INTERVAL '60 days' END
FROM (VALUES
    ('est1@uts.edu.co', 1, 6, 'APROBADO',  NULL),
    ('est2@uts.edu.co', 1, 6, 'APROBADO',  NULL),
    ('est3@uts.edu.co', 2, 9, 'PENDIENTE', NULL),
    ('est4@uts.edu.co', 2, 4, 'RECHAZADO', 'Programa o semestre no corresponde; verifique sus datos.'),
    ('est5@uts.edu.co', 1, 6, 'APROBADO',  NULL),
    ('est6@uts.edu.co', 1, 6, 'APROBADO',  NULL),
    ('est7@uts.edu.co', 2, 9, 'APROBADO',  NULL),
    ('est8@uts.edu.co', 2, 10, 'APROBADO', NULL),
    ('est9@uts.edu.co', 1, 5, 'APROBADO',  NULL)
) AS d (correo, id_programa, semestre, estado, observacion)
JOIN usuarios u ON u.correo = d.correo;

-- Ideas
INSERT INTO ideas (id_autor, titulo, objetivo, problematica, estado, observacion, id_revisor, fecha_registro, fecha_revision)
SELECT u.id_usuario, d.titulo, d.objetivo, d.problematica, d.estado, d.observacion,
       CASE WHEN d.estado = 'PENDIENTE' THEN NULL
            ELSE (SELECT id_usuario FROM usuarios WHERE correo = 'comite1@uts.edu.co') END,
       CURRENT_TIMESTAMP - INTERVAL '90 days',
       CASE WHEN d.estado = 'PENDIENTE' THEN NULL ELSE CURRENT_TIMESTAMP - INTERVAL '85 days' END
FROM (VALUES
    ('docente1@uts.edu.co', 'Sistema de reservas de laboratorios',
     'Desarrollar un sistema web para reservar los laboratorios de la institución.',
     'Las reservas se hacen en papel y se presentan cruces de horarios.', 'APROBADO', NULL),
    ('docente1@uts.edu.co', 'App móvil de seguimiento de semilleros',
     'Construir una aplicación móvil para registrar las actividades de los semilleros de investigación.',
     'No existe un registro centralizado de las actividades de los semilleros.', 'APROBADO', NULL),
    ('docente2@uts.edu.co', 'Tablero de indicadores académicos',
     'Diseñar un tablero que muestre los indicadores académicos de cada programa.',
     'Los indicadores se calculan a mano en hojas de cálculo.', 'APROBADO', NULL),
    ('docente3@uts.edu.co', 'Chatbot de orientación estudiantil',
     'Implementar un asistente conversacional que resuelva las preguntas frecuentes de los estudiantes.',
     'Las oficinas reciben las mismas preguntas una y otra vez.', 'PENDIENTE', NULL),
    ('est7@uts.edu.co', 'Control de inventario para tiendas de barrio',
     'Desarrollar una aplicación web de inventario para pequeños comercios.',
     'Las tiendas de barrio no controlan sus existencias y pierden ventas.', 'APROBADO', NULL),
    ('est1@uts.edu.co', 'Red social de tutorías',
     'Crear una plataforma para que los estudiantes ofrezcan y soliciten tutorías.',
     'Los estudiantes no encuentran fácilmente compañeros que les expliquen.', 'PENDIENTE', NULL),
    ('docente2@uts.edu.co', 'Portal de egresados',
     'Crear un portal para los egresados.',
     'No hay contacto con los egresados.', 'RECHAZADO', 'Idea muy general; precise el alcance.'),
    ('docente3@uts.edu.co', 'Gestor de prácticas empresariales',
     'Desarrollar un sistema para gestionar las prácticas empresariales de los estudiantes.',
     'El seguimiento de las prácticas se lleva en correos y documentos sueltos.', 'APROBADO', NULL),
    ('docente4@uts.edu.co', 'Sistema de turnos para cafetería',
     'Desarrollar un sistema de turnos para la cafetería de la institución.',
     'En las horas de mayor demanda se forman filas muy largas.', 'APROBADO', NULL)
) AS d (correo, titulo, objetivo, problematica, estado, observacion)
JOIN usuarios u ON u.correo = d.correo;

-- Proyectos: A (fase 2), B (fase 5), C (finalizado), D (fase 1)
INSERT INTO proyectos (id_idea, id_fase, estado, responsable_actual, fecha_inicio, fecha_fin, observacion_cierre)
SELECT i.id_idea, d.id_fase, d.estado, d.responsable, CURRENT_TIMESTAMP - d.inicio, d.fin, d.observacion
FROM (VALUES
    ('Sistema de reservas de laboratorios',          2, 'EN_CURSO',   'DIRECTOR',  INTERVAL '40 days',  NULL::TIMESTAMP, NULL),
    ('Control de inventario para tiendas de barrio', 5, 'EN_CURSO',   'EVALUADOR', INTERVAL '200 days', NULL::TIMESTAMP, NULL),
    ('Gestor de prácticas empresariales',            6, 'FINALIZADO', NULL,        INTERVAL '300 days', CURRENT_TIMESTAMP - INTERVAL '10 days',
     'Sustentación aprobada y entrega en biblioteca.'),
    ('Sistema de turnos para cafetería',             1, 'EN_CURSO',   'COMITE',    INTERVAL '5 days',   NULL::TIMESTAMP, NULL)
) AS d (titulo, id_fase, estado, responsable, inicio, fin, observacion)
JOIN ideas i ON i.titulo = d.titulo;

-- Integrantes de cada proyecto
INSERT INTO proyecto_estudiantes (id_proyecto, id_estudiante, es_responsable)
SELECT p.id_proyecto, e.id_estudiante, d.responsable
FROM (VALUES
    ('Sistema de reservas de laboratorios',          'est5@uts.edu.co', TRUE),
    ('Sistema de reservas de laboratorios',          'est6@uts.edu.co', FALSE),
    ('Control de inventario para tiendas de barrio', 'est7@uts.edu.co', TRUE),
    ('Gestor de prácticas empresariales',            'est8@uts.edu.co', TRUE),
    ('Sistema de turnos para cafetería',             'est9@uts.edu.co', TRUE)
) AS d (titulo, correo, responsable)
JOIN ideas i ON i.titulo = d.titulo
JOIN proyectos p ON p.id_idea = i.id_idea
JOIN usuarios u ON u.correo = d.correo
JOIN estudiantes e ON e.id_usuario = u.id_usuario;

-- Director y evaluador
INSERT INTO asignaciones (id_proyecto, id_usuario, funcion)
SELECT p.id_proyecto, u.id_usuario, d.funcion
FROM (VALUES
    ('Sistema de reservas de laboratorios',          'docente1@uts.edu.co', 'DIRECTOR'),
    ('Sistema de reservas de laboratorios',          'docente2@uts.edu.co', 'EVALUADOR'),
    ('Control de inventario para tiendas de barrio', 'docente2@uts.edu.co', 'DIRECTOR'),
    ('Control de inventario para tiendas de barrio', 'docente3@uts.edu.co', 'EVALUADOR'),
    ('Gestor de prácticas empresariales',            'docente3@uts.edu.co', 'DIRECTOR'),
    ('Gestor de prácticas empresariales',            'docente1@uts.edu.co', 'EVALUADOR')
) AS d (titulo, correo, funcion)
JOIN ideas i ON i.titulo = d.titulo
JOIN proyectos p ON p.id_idea = i.id_idea
JOIN usuarios u ON u.correo = d.correo;

-- Historial de versiones
INSERT INTO historial_versiones (id_proyecto, tipo_documento, version, url, id_usuario, fecha_entrega)
SELECT p.id_proyecto, d.tipo, 1, d.url, u.id_usuario, CURRENT_TIMESTAMP - d.hace
FROM (VALUES
    ('Sistema de reservas de laboratorios',          'SOPORTE_PAGO', 'https://drive.google.com/file/d/pago-reservas',      'est5@uts.edu.co', INTERVAL '38 days'),
    ('Sistema de reservas de laboratorios',          'F-DC-124',     'https://drive.google.com/file/d/anteproyecto-reservas', 'est5@uts.edu.co', INTERVAL '2 days'),
    ('Control de inventario para tiendas de barrio', 'SOPORTE_PAGO', 'https://drive.google.com/file/d/pago-inventario',     'est7@uts.edu.co', INTERVAL '198 days'),
    ('Control de inventario para tiendas de barrio', 'F-DC-124',     'https://drive.google.com/file/d/anteproyecto-inventario', 'est7@uts.edu.co', INTERVAL '180 days'),
    ('Control de inventario para tiendas de barrio', 'F-DC-125',     'https://drive.google.com/file/d/informe-inventario',  'est7@uts.edu.co', INTERVAL '6 days'),
    ('Gestor de prácticas empresariales',            'SOPORTE_PAGO', 'https://drive.google.com/file/d/pago-practicas',      'est8@uts.edu.co', INTERVAL '298 days'),
    ('Gestor de prácticas empresariales',            'F-DC-124',     'https://drive.google.com/file/d/anteproyecto-practicas', 'est8@uts.edu.co', INTERVAL '280 days'),
    ('Gestor de prácticas empresariales',            'F-DC-125',     'https://drive.google.com/file/d/informe-practicas',   'est8@uts.edu.co', INTERVAL '60 days'),
    ('Gestor de prácticas empresariales',            'F-DC-129',     'https://drive.google.com/file/d/rejilla-practicas',   'docente1@uts.edu.co', INTERVAL '50 days'),
    ('Sistema de turnos para cafetería',             'SOPORTE_PAGO', 'https://drive.google.com/file/d/pago-turnos',         'est9@uts.edu.co', INTERVAL '4 days')
) AS d (titulo, tipo, url, correo, hace)
JOIN ideas i ON i.titulo = d.titulo
JOIN proyectos p ON p.id_idea = i.id_idea
JOIN usuarios u ON u.correo = d.correo;

-- La rejilla F-DC-129 del proyecto C apunta al informe final que evaluó
UPDATE historial_versiones r
SET id_version_relacionada = (
    SELECT h.id_version FROM historial_versiones h
    WHERE h.id_proyecto = r.id_proyecto AND h.tipo_documento = 'F-DC-125' AND h.version = 1)
WHERE r.tipo_documento = 'F-DC-129';

-- Revisiones
INSERT INTO revisiones (id_version, id_usuario, funcion, estado, observaciones, fecha_creacion, fecha_revision)
SELECT h.id_version, u.id_usuario, d.funcion, d.estado, d.observaciones,
       h.fecha_entrega,
       CASE WHEN d.estado = 'PENDIENTE_REVISION' THEN NULL ELSE h.fecha_entrega + d.demora END
FROM (VALUES
    ('Sistema de reservas de laboratorios',          'SOPORTE_PAGO', 'COMITE',    'comite1@uts.edu.co',  'APROBADO',           NULL, INTERVAL '1 day'),
    ('Sistema de reservas de laboratorios',          'F-DC-124',     'DIRECTOR',  'docente1@uts.edu.co', 'PENDIENTE_REVISION', NULL, NULL),
    ('Control de inventario para tiendas de barrio', 'SOPORTE_PAGO', 'COMITE',    'comite1@uts.edu.co',  'APROBADO',           NULL, INTERVAL '1 day'),
    ('Control de inventario para tiendas de barrio', 'F-DC-124',     'DIRECTOR',  'docente2@uts.edu.co', 'APROBADO',           NULL, INTERVAL '3 days'),
    ('Control de inventario para tiendas de barrio', 'F-DC-124',     'EVALUADOR', 'docente3@uts.edu.co', 'APROBADO',           NULL, INTERVAL '6 days'),
    ('Control de inventario para tiendas de barrio', 'F-DC-124',     'COMITE',    'comite2@uts.edu.co',  'APROBADO',           NULL, INTERVAL '8 days'),
    ('Control de inventario para tiendas de barrio', 'F-DC-125',     'DIRECTOR',  'docente2@uts.edu.co', 'APROBADO',           NULL, INTERVAL '2 days'),
    ('Control de inventario para tiendas de barrio', 'F-DC-125',     'EVALUADOR', 'docente3@uts.edu.co', 'PENDIENTE_REVISION', NULL, NULL),
    ('Gestor de prácticas empresariales',            'SOPORTE_PAGO', 'COMITE',    'comite1@uts.edu.co',  'APROBADO',           NULL, INTERVAL '1 day'),
    ('Gestor de prácticas empresariales',            'F-DC-124',     'DIRECTOR',  'docente3@uts.edu.co', 'APROBADO',           NULL, INTERVAL '3 days'),
    ('Gestor de prácticas empresariales',            'F-DC-124',     'EVALUADOR', 'docente1@uts.edu.co', 'APROBADO',           NULL, INTERVAL '5 days'),
    ('Gestor de prácticas empresariales',            'F-DC-124',     'COMITE',    'comite1@uts.edu.co',  'APROBADO',           NULL, INTERVAL '7 days'),
    ('Gestor de prácticas empresariales',            'F-DC-125',     'DIRECTOR',  'docente3@uts.edu.co', 'APROBADO',           NULL, INTERVAL '4 days'),
    ('Gestor de prácticas empresariales',            'F-DC-125',     'EVALUADOR', 'docente1@uts.edu.co', 'APROBADO',           NULL, INTERVAL '10 days'),
    ('Gestor de prácticas empresariales',            'F-DC-125',     'COMITE',    'comite2@uts.edu.co',  'APROBADO',           NULL, INTERVAL '12 days'),
    ('Sistema de turnos para cafetería',             'SOPORTE_PAGO', 'COMITE',    NULL,                  'PENDIENTE_REVISION', NULL, NULL)
) AS d (titulo, tipo, funcion, correo, estado, observaciones, demora)
JOIN ideas i ON i.titulo = d.titulo
JOIN proyectos p ON p.id_idea = i.id_idea
JOIN historial_versiones h ON h.id_proyecto = p.id_proyecto AND h.tipo_documento = d.tipo AND h.version = 1
LEFT JOIN usuarios u ON u.correo = d.correo;

-- Base documental (reemplazar las URL por las oficiales)
INSERT INTO documentos_institucionales (nombre, url) VALUES
    ('Calendario académico', 'https://www.uts.edu.co/sitio/'),
    ('Plantilla F-DC-124 (anteproyecto)', 'https://www.uts.edu.co/sitio/'),
    ('Plantilla F-DC-125 (informe final)', 'https://www.uts.edu.co/sitio/'),
    ('Plantilla F-DC-129 (rejilla de evaluación)', 'https://www.uts.edu.co/sitio/');
