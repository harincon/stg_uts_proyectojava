# Sistema de Gestión de Trabajos de Grado — UTS

Aplicación web para gestionar y hacer seguimiento a los trabajos de grado de las Unidades Tecnológicas de Santander. El proceso va desde la inscripción del estudiante y la elección de una idea del banco de ideas hasta el cierre del proyecto. Pasa por seis fases: idea y pago, anteproyecto (entrega y evaluación) e informe final (entrega y evaluación), y conserva el historial de versiones de cada documento entregado.

## Roles

- **Administrador:** gestiona usuarios, programas y la base documental.
- **Comité:** aprueba inscripciones, ideas y pagos; asigna director y evaluador; aprueba y cierra los proyectos.
- **Docente:** propone ideas y revisa los proyectos donde fue asignado como director o como evaluador.
- **Estudiante:** se inscribe, elige o propone una idea, registra su proyecto (individual o en pareja) y entrega sus documentos.

## Arquitectura

- Páginas **JSP con JSTL 1.2**. El acceso a datos se hace con las etiquetas `<sql:*>` de JSTL.
- Sin servlets propios, sin scriptlets, sin Maven y sin capa DAO.
- Una carpeta por rol (`administrador/`, `comite/`, `docente/`, `estudiante/`) y una carpeta `comun/` para las páginas compartidas.
- Fragmentos `.jspf` reutilizables para el control de acceso, el encabezado, el menú y los mensajes.
- Los documentos se registran como **URL**; no se cargan archivos al servidor.

## Tecnologías

- Java y Apache Tomcat
- JSP y JSTL 1.2
- PostgreSQL
- Bootstrap 5 y JavaScript (solo en el navegador)
