# Clase 0 — Preparación del entorno

**Ingeniería y Análisis de Datos en Google Cloud**
UTN Facultad Regional Rosario x TheLab Technology · Octubre – Noviembre 2026

Antes de la primera clase es necesario dejar el entorno de trabajo funcionando. Lleva alrededor de 40 minutos.

Conviene completarlo con anticipación. Los problemas de instalación se resuelven por el [canal de consultas](https://github.com/juanmantegazza/ingenieria-datos-gcp/discussions); resolverlos durante la clase consume tiempo de cursada.

No se requieren conocimientos previos de Google Cloud.

> **No se necesita tarjeta de crédito.** El curso se desarrolla íntegramente dentro del entorno gratuito de Google Cloud.

---

## Conocimientos previos

El curso no exige experiencia en datos ni en la nube, pero sí asume:

- **Terminal** — navegar entre directorios y ejecutar comandos
- **SQL básico** — consultas, filtros, agrupaciones
- **Git** — uso básico

---

## Paso 1 — Proyecto en Google Cloud

1. Ingresar a [console.cloud.google.com](https://console.cloud.google.com) con una cuenta de Google.
2. Aceptar los términos del servicio.
3. Crear un proyecto nuevo, por ejemplo `curso-datos-utn`.
4. Abrir **BigQuery** desde el buscador de la consola.
5. Activar el **sandbox** cuando la consola lo ofrezca.

**Verificación:** la consola de BigQuery indica que el proyecto opera en modo sandbox.

**Anotar el ID del proyecto.** No es el nombre asignado al crearlo: Google genera un ID aparte, que suele ser ese nombre más unos dígitos (por ejemplo, `curso-datos-utn-481207`). Figura en la consola, junto al selector de proyecto. Los pasos 2 y 5 lo requieren.

Dos características del sandbox: las tablas expiran a los 60 días, y algunas funciones están deshabilitadas. Ninguna de las dos afecta al curso.

---

## Paso 2 — Google Cloud CLI

Instalar `gcloud` según la guía oficial correspondiente al sistema operativo: [cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)

Luego, en una terminal:

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project TU-ID-DE-PROYECTO
```

El segundo comando genera las credenciales que utiliza dbt. Es obligatorio y no reemplaza al primero.

**Verificación:**

```bash
gcloud config list
```

La salida debe mostrar la cuenta y el proyecto configurados.

---

## Paso 3 — Entorno de Python

El curso usa **uv** para administrar Python y las dependencias. Evita los conflictos con el Python del sistema, que en macOS y en Linux recientes impide instalar paquetes directamente.

**Instalar uv**

macOS y Linux:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Windows, en PowerShell:

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Cerrar y reabrir la terminal al terminar.

**Verificación:**

```bash
uv --version
```

---

## Paso 4 — dbt

Crear un directorio de trabajo para el curso y ubicarse en él:

```bash
mkdir datos-gcp
cd datos-gcp
```

Crear dentro el entorno virtual:

```bash
uv venv --python 3.13
```

Activarlo. macOS y Linux:

```bash
source .venv/bin/activate
```

Windows:

```powershell
.venv\Scripts\activate
```

Instalar dbt dentro del entorno:

```bash
uv pip install dbt-bigquery
```

Esto instala también `dbt-core`, del que depende.

**Verificación:**

```bash
dbt --version
```

La salida debe listar una versión de `Core` y una del plugin `bigquery`.

> El entorno virtual se activa por terminal: al abrir una nueva hay que volver a ejecutar el comando de activación desde ese mismo directorio. Si `dbt` deja de encontrarse, esa es casi siempre la causa.

---

## Paso 5 — Conexión entre dbt y BigQuery

Este es el paso que importa: comprueba que dbt puede autenticarse contra el proyecto de Google Cloud.

Con el entorno activado:

```bash
dbt init analytics
```

El comando hace una serie de preguntas. Las tres primeras se responden con un **número**, no con el texto de la opción:

| Pregunta | Respuesta |
|---|---|
| Which database would you like to use? | `1` |
| Desired authentication method option | `1` |
| project (GCP project id) | el ID anotado en el paso 1 |
| dataset (the name of your dbt dataset) | `dev` |
| threads (1 or more) | `4` |
| job_execution_timeout_seconds | `300` |
| Desired location option | `1` |

Al terminar, `dbt init` ejecuta `dbt debug` automáticamente y muestra el resultado de la conexión.

Para volver a ejecutarlo en cualquier momento:

```bash
cd analytics
dbt debug
```

**Verificación final:** todas las comprobaciones devuelven **OK**, incluida `Connection test`.

Al llegar a este punto, pegar la salida completa de `dbt debug` en el [canal de consultas](https://github.com/juanmantegazza/ingenieria-datos-gcp/discussions). Sirve para confirmar antes de la primera clase que el entorno quedó operativo.

---

## Errores frecuentes

**`Connection test: ERROR` con un mensaje poco descriptivo**

Casi siempre significa que falta ejecutar `gcloud auth application-default login`. Es un comando distinto de `gcloud auth login` y ambos son necesarios.

**`Project not found` o `Access Denied`**

El valor ingresado como *GCP project id* es el nombre del proyecto y no su ID. Verificar el ID en la consola, junto al selector de proyecto, y corregirlo en `~/.dbt/profiles.yml`.

**`dbt: command not found`**

El entorno virtual no está activado en esa terminal. Volver al directorio de trabajo y ejecutar el comando de activación del paso 4.

---

## Problemas durante la instalación

Reportarlos en el [canal de consultas](https://github.com/juanmantegazza/ingenieria-datos-gcp/discussions) —la pestaña **Discussions** de este repositorio— indicando **el comando ejecutado y el mensaje de error completo**, sin resumir. El texto exacto es lo que permite identificar la causa.

---

## Advertencias

- No instalar componentes adicionales a los indicados.
- No habilitar la facturación en Google Cloud, aunque la consola lo sugiera.
- No se requiere lectura previa. La clase 1 parte desde los fundamentos.

---

## Primera clase

**Martes 6 de octubre, 19:00.**

Contenidos: el trabajo de un equipo de datos, la organización de una plataforma de datos en la nube, y la primera consulta sobre datos reales.
