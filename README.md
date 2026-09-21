# Clase 0 — Preparar tu entorno

**Ingeniería y Análisis de Datos en Google Cloud** · UTN Facultad Regional Rosario
Curso de extensión · Octubre – Noviembre 2026

Antes de la primera clase necesitás dejar tu computadora lista. Son unos **40 minutos**, y conviene hacerlo esta semana y no el lunes a la noche: si algo falla, quiero enterarme antes de la clase y no durante.

No hace falta saber nada de Google Cloud todavía. Solo seguir los pasos.

> **No se necesita tarjeta de crédito y no genera ningún costo.** Todo el curso corre dentro del entorno gratuito de Google Cloud.

---

## Qué doy por sabido

No hace falta experiencia en datos ni en la nube. Sí espero que llegues con:

- **SQL básico** — consultas, filtros, agrupaciones. Si hace mucho que no lo usás, un repaso de media hora alcanza.
- **Terminal** — abrir una, moverte entre carpetas, correr un comando.
- **Git** — clonar un repositorio.

Si alguna de las tres te queda lejos, avisame por el canal antes de empezar y vemos.

---

## Paso 1 — Cuenta y proyecto en Google Cloud

1. Entrá a [console.cloud.google.com](https://console.cloud.google.com) con una cuenta de Google. Podés usar la personal.
2. Aceptá los términos.
3. Creá un proyecto nuevo. Ponele un nombre que reconozcas, por ejemplo `curso-datos-utn`.
4. Entrá a **BigQuery** desde el buscador de arriba.
5. Cuando te ofrezca activar el **sandbox**, aceptá. No pide tarjeta.

**Cómo sabés que salió bien:** ves la consola de BigQuery con un cartel que indica que estás en modo sandbox.

> **Dos cosas del sandbox.** Las tablas que crees se borran solas a los 60 días — no es un problema, porque todo lo que vamos a construir se reconstruye con un comando. Y algunas funciones están deshabilitadas; las que necesitamos, no.

Anotate el **ID del proyecto**. No es el nombre que le pusiste: lo ves en la consola, al lado del selector de proyecto. Lo vas a necesitar en el paso 5.

---

## Paso 2 — La herramienta de línea de comandos

Instalá `gcloud` siguiendo la guía oficial para tu sistema: [cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)

Después, en una terminal:

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project TU-ID-DE-PROYECTO
```

El segundo comando es el que usa dbt para conectarse. No lo saltees.

**Cómo sabés que salió bien:**

```bash
gcloud config list
```

Tiene que mostrar tu cuenta y tu proyecto.

---

## Paso 3 — Python y dbt

Vamos a usar **uv** para manejar el entorno de Python. Es más rápido y da menos problemas que las alternativas.

Instalalo desde [docs.astral.sh/uv](https://docs.astral.sh/uv/getting-started/installation/).

**Cómo sabés que salió bien:**

```bash
uv --version
```

---

## Paso 4 — Clonar este repositorio

```bash
git clone https://github.com/juanmantegazza/ingenieria-datos-gcp.git
cd ingenieria-datos-gcp
uv sync
```

`uv sync` instala `dbt-core` y `dbt-bigquery` en un entorno propio del proyecto. No toca tu Python del sistema.

---

## Paso 5 — La prueba de que todo funciona

Este es el paso que importa. Si este anda, estás listo.

**1. Configurá tu proyecto.** Abrí `profiles.yml` y reemplazá `TU-ID-DE-PROYECTO` por el ID que anotaste en el paso 1.

**2. Verificá la conexión:**

```bash
uv run dbt debug --profiles-dir .
```

Todas las líneas tienen que dar **OK**. Si alguna da error, copiala tal cual y mandala al canal.

**3. Creá la tabla de prueba:**

```bash
uv run dbt run --profiles-dir .
```

Esto crea un dataset llamado `curso_dbt` en tu proyecto, con una tabla adentro. No consulta ningún dato: solo comprueba que dbt puede autenticarse y escribir en tu BigQuery.

**4. Miralo en la consola.** Entrá a BigQuery, buscá el dataset `curso_dbt` y abrí la tabla `smoke_test`. Tiene que decirte que tu entorno funciona.

**Cómo sabés que terminaste:** `dbt debug` todo en OK, y la tabla `smoke_test` visible en tu proyecto.

---

## Si algo falla

Escribí en el canal del curso pegando **el comando que corriste y el error completo**. No lo resumas: el texto exacto es lo que permite resolverlo rápido.

Voy a estar respondiendo hasta el día de la primera clase. Resolverlo el martes en vivo nos come tiempo de clase, así que no lo dejes para último momento.

---

## Encuesta

Antes de empezar, completá esta encuesta de dos minutos: **[LINK]**

Me sirve para calibrar el ritmo de las clases. No hay respuestas buenas ni malas y no afecta tu certificado.

---

## Qué NO hace falta hacer

- No instales nada más de lo que dice acá.
- No actives la facturación en Google Cloud, aunque la consola te lo insista.
- No hace falta que leas nada previo. La clase 1 arranca desde cero.

---

## Nos vemos

**Martes 6 de octubre, 19:00.**

En la primera clase vamos a ver qué hace un equipo de datos, cómo se organiza una plataforma en la nube, y vas a correr tu primera consulta sobre datos reales.
