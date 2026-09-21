# Clase 0 — Preparación del entorno

**Ingeniería y Análisis de Datos en Google Cloud** · UTN Facultad Regional Rosario
Curso de extensión · Octubre – Noviembre 2026

Antes de la primera clase es necesario dejar el entorno de trabajo funcionando. Lleva alrededor de 40 minutos.

Conviene completarlo con anticipación. Los problemas de instalación se resuelven por el canal de consultas; resolverlos durante la clase consume tiempo de cursada.

No se requieren conocimientos previos de Google Cloud.

> **No se necesita tarjeta de crédito.** El curso se desarrolla íntegramente dentro del entorno gratuito de Google Cloud.

---

## Conocimientos previos

El curso no exige experiencia en datos ni en la nube, pero sí asume:

- **SQL básico** — consultas, filtros, agrupaciones
- **Terminal** — navegar entre directorios y ejecutar comandos
- **Git** — clonar un repositorio

---

## Paso 1 — Proyecto en Google Cloud

1. Ingresar a [console.cloud.google.com](https://console.cloud.google.com) con una cuenta de Google.
2. Aceptar los términos del servicio.
3. Crear un proyecto nuevo, por ejemplo `curso-datos-utn`.
4. Abrir **BigQuery** desde el buscador de la consola.
5. Activar el **sandbox** cuando la consola lo ofrezca.

**Verificación:** la consola de BigQuery indica que el proyecto opera en modo sandbox.

Dos características del sandbox:

- Las tablas expiran a los 60 días. No afecta al curso: todos los modelos se reconstruyen con un comando.
- Algunas funciones están deshabilitadas. Ninguna de las que usa el curso.

Registrar el **ID del proyecto**, que no coincide con el nombre asignado. Figura en la consola, junto al selector de proyecto. Se utiliza en el paso 5.

---

## Paso 2 — Interfaz de línea de comandos

Instalar `gcloud` según la guía oficial correspondiente al sistema operativo: [cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)

Luego, en una terminal:

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project TU-ID-DE-PROYECTO
```

El segundo comando genera las credenciales que utiliza dbt para conectarse. Es obligatorio.

**Verificación:**

```bash
gcloud config list
```

La salida debe mostrar la cuenta y el proyecto configurados.

---

## Paso 3 — Python y dbt

El curso utiliza **uv** para administrar el entorno de Python. Instalarlo desde [docs.astral.sh/uv](https://docs.astral.sh/uv/getting-started/installation/).

**Verificación:**

```bash
uv --version
```

---

## Paso 4 — Clonar el repositorio

```bash
git clone https://github.com/juanmantegazza/ingenieria-datos-gcp.git
cd ingenieria-datos-gcp
uv sync
```

`uv sync` instala `dbt-core` y `dbt-bigquery` en un entorno aislado del proyecto, sin modificar la instalación de Python del sistema.

---

## Paso 5 — Prueba de entorno

**1. Configurar el proyecto.** Abrir `profiles.yml` y reemplazar `TU-ID-DE-PROYECTO` por el ID registrado en el paso 1.

**2. Verificar la conexión:**

```bash
uv run dbt debug --profiles-dir .
```

Todas las comprobaciones deben devolver **OK**.

**3. Ejecutar el modelo de prueba:**

```bash
uv run dbt run --profiles-dir .
```

Esto crea el dataset `curso_dbt` en el proyecto, con una tabla. El modelo no consulta datos externos: solo comprueba que dbt puede autenticarse y escribir en BigQuery.

**4. Confirmar en la consola.** Abrir BigQuery, localizar el dataset `curso_dbt` y la tabla `smoke_test`.

**Verificación final:** `dbt debug` sin errores y la tabla `smoke_test` visible en el proyecto.

---

## Problemas durante la instalación

Reportarlos por el canal de consultas, indicando **el comando ejecutado y el mensaje de error completo**, sin resumir. El texto exacto es lo que permite identificar la causa.

---

## Encuesta previa

Completar antes del inicio del curso: **[LINK]**

Toma dos minutos y se utiliza para calibrar el ritmo de las clases. No incide en la certificación.

---

## Advertencias

- No instalar componentes adicionales a los indicados.
- No habilitar la facturación en Google Cloud, aunque la consola lo sugiera.
- No se requiere lectura previa. La clase 1 parte desde los fundamentos.

---

## Primera clase

**Martes 6 de octubre, 19:00.**

Contenidos: el trabajo de un equipo de datos, la organización de una plataforma de datos en la nube, y la primera consulta sobre datos reales.
