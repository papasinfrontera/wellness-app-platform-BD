# WELLNESS APP — Sprint 6.1: fundaciones

## Arquitectura
- Frontend: Next.js y TypeScript; migración gradual del demo publicado.
- Persistencia: PostgreSQL con autenticación y almacenamiento privado; aún sin conectar.
- IA: proveedor de modelo de lenguaje, recuperación RAG y herramientas de lectura autorizadas.
- Base científica: documentos, autores, versiones, estatus de aprobación, fragmentos y embeddings.
- Clinical Rules Engine: cálculos determinísticos separados de las respuestas del modelo.
- Gobernanza: el Consejo Médico-Científico aprueba fuentes antes de usarlas en recomendaciones clínicas.

## Flujos
- PDF → almacenamiento privado → extracción → normalización → revisión de usuario → historia longitudinal.
- WHOOP ZIP/CSV → lectura de ciclos y métricas → fechas y zona horaria → deduplicación → gráficos.
- Fuentes científicas → licencia y procedencia → revisión → indexación vectorial y textual → RAG.

## Separación de memorias
1. Datos personales longitudinales, protegidos por usuario.
2. Base de conocimiento científica validada y versionada.
3. Contexto conversacional autorizado, con políticas de retención.

## Seguridad
- Repositorio público: sólo código y datos sintéticos. No publicar información personal de salud.
- Claves de servicio exclusivamente del lado servidor, nunca en cliente ni en Git.
- Control de autorización por usuario, auditoría de cambios y manejo seguro de archivos.
- Validación normativa antes de comenzar a procesar datos de usuarios reales.

## Criterios de aceptación Sprint 6.1
1. Instalar dependencias, comprobar tipos y ejecutar build de Next.js.
2. Endpoint de estado declara las conexiones que no están activas.
3. Contratos de observaciones, evidencia y WHOOP definidos.
4. Esquema SQL revisado con datos ficticios; no desplegado automáticamente.
5. Demo actual de Vercel preservado sin cambios.

## Pendientes
- Pruebas de compilación y pipeline CI.
- Crear/configurar Supabase, conectar entornos privados y revisar permisos.
- Migrar componentes visuales sin publicar datos personales en GitHub.
- Importadores PDF y WHOOP y motores RAG y Clinical Rules: sprints posteriores.