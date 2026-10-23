# Sistema de Gestión de Trabajos de Grado — UTS

Aplicación web para gestionar y hacer seguimiento a los trabajos de grado de las Unidades Tecnológicas de Santander. El proceso va desde la inscripción del estudiante y la elección de una idea del banco de ideas hasta el cierre del proyecto. Pasa por seis fases: idea y pago, anteproyecto (entrega y evaluación) e informe final (entrega y evaluación), y conserva el historial de versiones de cada documento entregado.

## Roles

- **Administrador:** gestiona usuarios, programas y la base documental.
- **Comité:** aprueba inscripciones, ideas y pagos; asigna director y evaluador; aprueba y cierra los proyectos.
- **Docente:** propone ideas y revisa los proyectos donde fue asignado como director o como evaluador.
- **Estudiante:** se inscribe, elige o propone una idea, registra su proyecto (individual o en pareja) y entrega sus documentos.

## Arquitectura

Patrón **MVC** construido solo con **JSP y JSTL 1.2**, sin servlets propios, sin scriptlets, sin Maven y sin capa DAO:

- **Modelo** (`WEB-INF/modelo/`): consultas a la base de datos con las etiquetas `<sql:*>` de JSTL, agrupadas por tabla.
- **Vista** (`WEB-INF/vista/`): páginas que solo muestran la información con HTML y JSTL.
- **Controlador** (`controlador/`): recibe cada petición, controla el acceso por rol, usa el modelo y envía a la vista.
- Dentro de `controlador/` y `WEB-INF/vista/` hay una carpeta por rol (`administrador/`, `comite/`, `docente/`, `estudiante/`) y una carpeta `comun/`.
- Los documentos se registran como **URL**; no se cargan archivos al servidor.

## Tecnologías

- Java y Apache Tomcat
- JSP y JSTL 1.2
- PostgreSQL
- Bootstrap 5 y JavaScript (solo en el navegador)
- Docker (despliegue en Render)
