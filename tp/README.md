# Trabajo práctico integrador

**Ingeniería y Análisis de Datos en Google Cloud** · UTN Facultad Regional Rosario x TheLab Technology

| Instancia | Fecha |
|---|---|
| Entrega | miércoles 4 de noviembre, hasta las 23:59 |
| Resultado y devolución | lunes 9 de noviembre |

No hay reentrega. Las consultas van al [canal de consultas](https://github.com/juanmantegazza/ingenieria-datos-gcp/discussions).

---

## Parte 1 · La capa raw

Incorporar al proyecto propio los dos archivos de la carpeta `datos/`. Cada archivo se carga con su schema declarado.

## Los datos

| Archivo | Qué tiene |
|---|---|
| `datos/viajes.csv` | Muestra de viajes de taxi amarillo en Nueva York entre el 14 de septiembre y el 11 de octubre de 2026 |
| `datos/clima.csv` | Una medición por hora en Nueva York para el mismo período |

Las horas de los dos archivos están en hora local de Nueva York.

### Viajes

| Columna | Contenido |
|---|---|
| `vendor_id` | Empresa que registró el viaje |
| `pickup_datetime`, `dropoff_datetime` | Fecha y hora de subida y de bajada |
| `passenger_count` | Cantidad de pasajeros informada por el conductor |
| `trip_distance` | Distancia en millas |
| `pickup_location_id`, `dropoff_location_id` | Zona de subida y de bajada |
| `payment_type` | Código numérico del medio de pago |
| `fare_amount`, `tip_amount`, `total_amount` | Tarifa, propina y total en dólares |

### Clima

| Columna | Contenido |
|---|---|
| `fecha_hora` | Hora de la medición |
| `temperatura_c` | Temperatura en grados Celsius |
| `precipitacion_mm` | Precipitación de esa hora, en milímetros |
| `viento_kmh` | Velocidad del viento en km/h |
| `codigo_clima` | Código de condición meteorológica (WMO) |

---

## Qué hacer

### 1. Escribir los schemas

Un archivo JSON por tabla, `viajes.json` y `clima.json`, con un objeto por columna: nombre, tipo y modo.

### 2. Crear el dataset

Crear un dataset `tp_raw` en la ubicación US.

### 3. Cargar cada archivo

Cargar `viajes.csv` en la tabla `tp_raw.viajes` y `clima.csv` en `tp_raw.clima`. Cada carga usa su schema.

Para verificar la carga: `viajes` tiene que quedar con 399.634 filas y `clima` con 676.

### 4. Mirar qué trajeron

Recorrer las dos tablas con SQL antes de seguir. Ninguno de los dos archivos está limpio.

---

## Parte 2 · Staging y marts

Transformar con dbt las tablas de `tp_raw` hasta responder cuatro preguntas sobre los viajes.

### La tabla de zonas

Las zonas de subida y de bajada de cada viaje son un número. El nombre y el distrito (`borough`) de cada zona están en la tabla pública `bigquery-public-data.new_york_taxi_trips.taxi_zone_geom`. Se lee directamente desde ahí y es la tercera fuente del TP. Como está en otro proyecto, se declara como source indicando ese proyecto.

En esa tabla, `zone_id` es de tipo texto y algunas zonas aparecen más de una vez.

### Qué es un viaje válido

Un viaje es válido si cumple todas estas condiciones:

- La subida es entre el 14 de septiembre y el 11 de octubre de 2026, los dos días incluidos.
- La bajada es posterior a la subida.
- La tarifa (`fare_amount`) es mayor que cero.
- La distancia es mayor que cero.
- La zona de subida existe en la tabla de zonas.

Cada viaje se cuenta una sola vez. Dos filas son el mismo viaje si coinciden en todas sus columnas. Para verificar: sin las filas repetidas, `viajes` queda con 398.001 filas.

Las fechas y las horas se usan tal como vienen en los archivos, sin convertir de zona horaria.

### Las preguntas

| # | Pregunta |
|---|---|
| 1 | ¿Cuántos viajes válidos hay? |
| 2 | ¿Cuánto suma el `total_amount` de los viajes válidos cuya zona de subida está en Manhattan? Con dos decimales. |
| 3 | ¿Qué zona de subida tuvo más viajes válidos el sábado 26 de septiembre de 2026? Con el número de la zona. |
| 4 | ¿Cuántos viajes válidos empezaron en una hora con lluvia? Se toma la hora de la subida: un viaje que sube a las 14:35 toma la medición de las 14:00. Una hora tiene lluvia si su precipitación es mayor que cero. |

## Qué hacer

### 1. Armar el proyecto dbt

Un proyecto dbt en una carpeta `dbt/` del repositorio del TP, que declara las tres fuentes.

`dbt` no es un nombre de proyecto válido. El proyecto se crea con otro nombre y después se renombra la carpeta:

```bash
dbt init tp --skip-profile-setup
mv tp dbt
rm -rf dbt/models/example
```

En `dbt_project.yml` se usa el profile `analytics` de la clase 0. El bloque `models:` del final se reemplaza por las capas staging y marts, como en la demo de la clase 4.

### 2. Construir staging y marts

Los modelos se organizan en las capas vistas en la clase 3. Cada respuesta sale de un modelo de marts, y ningún modelo de marts lee directamente de una fuente.

### 3. Declarar el diseño físico

Al menos un modelo de marts se materializa como `table` con partición y clustering declarados en su `config()`. La partición es por día, sobre una fecha de los viajes. En el sandbox, las primeras particiones vencen a mediados de noviembre.

### 4. Responder

Las cuatro respuestas van en un archivo `RESPUESTAS.md` en la raíz del repositorio. Una por línea, sin separador de miles y con punto decimal:

```
1. 1234
2. 98.76
3. 7
4. 123456
```

### 5. Escribir las decisiones

El `README.md` del repositorio explica dos cosas. La primera, dónde se declararon la partición y el clustering, y por qué. La segunda, una decisión de diseño propia, la alternativa que se descartó y el motivo.

---

## Parte 3 · Tests

Verificar con tests de dbt que los datos cumplen lo que se espera de ellos.

## Qué hacer

### 1. Declarar tests genéricos

En los `.yml` de los modelos, sobre las columnas que corresponda.

### 2. Escribir un test singular

Un archivo `.sql` en `dbt/tests/` con una regla propia, que devuelva las filas que no la cumplen.

### 3. Correr el proyecto completo

El proyecto tiene que terminar `dbt build` sin errores.

En total, el proyecto lleva al menos tres tests, y al menos uno de ellos es singular.

---

## Entrega

El TP se construye por partes a lo largo del curso y se entrega una sola vez, el miércoles 4 de noviembre hasta las 23:59. Todas las partes se trabajan sobre el mismo repositorio. Por eso, desde la parte 1, cada uno crea un repositorio git propio para el TP y guarda ahí lo que vaya produciendo.

Con las tres partes, el repositorio queda así:

```
├── README.md
├── RESPUESTAS.md
├── schemas/
│   ├── viajes.json
│   └── clima.json
└── dbt/
    ├── dbt_project.yml
    ├── models/
    │   ├── staging/
    │   └── marts/
    └── tests/
```

El repositorio no lleva el `profiles.yml` ni ninguna credencial.

La entrega final es un archivo zip con el repositorio completo, sin `.venv/`, `target/` ni `logs/`, que se envía por mail a [google@thelabtech.com.ar](mailto:google@thelabtech.com.ar).

---

## Cómo se corrige

Cada criterio se cumple o no se cumple. El TP se aprueba si cumple los seis.

| # | Criterio | Se cumple si |
|---|---|---|
| 1 | Estructura | Están todos los archivos de la entrega |
| 2 | Capas | Ningún modelo de marts lee directamente de una fuente |
| 3 | Tests | Hay al menos tres tests, y al menos uno es singular |
| 4 | Diseño físico | La partición y el clustering están declarados en el `config()` de un modelo de marts, con partición por día sobre una fecha de los viajes, y justificados en el README |
| 5 | Respuestas | Las cuatro respuestas de `RESPUESTAS.md` son correctas |
| 6 | Justificación | El README explica una decisión de diseño, la alternativa descartada y el motivo |

---

**Fuentes de los datos.** Viajes: [NYC Taxi & Limousine Commission](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page), muestra de septiembre y octubre de 2025 con las fechas corridas un año. Clima: [Open-Meteo](https://open-meteo.com/), datos históricos por hora. Los dos archivos fueron modificados para el curso.
