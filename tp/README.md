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

## Entrega

El TP se construye por partes a lo largo del curso y se entrega una sola vez, el miércoles 4 de noviembre hasta las 23:59. Todas las partes se trabajan sobre el mismo repositorio. Por eso, desde esta primera parte, cada uno crea un repositorio git propio para el TP y guarda ahí lo que vaya produciendo.

Lo que produce esta parte son los dos schemas, en una carpeta `schemas/` en la raíz de ese repositorio:

```
schemas/
├── viajes.json
└── clima.json
```

Los schemas no se entregan ahora. Quedan en el repositorio y se entregan junto con el resto del TP.

La entrega final es un archivo zip con el repositorio completo, que se envía por mail a [google@thelabtech.com.ar](mailto:google@thelabtech.com.ar).

---

**Fuentes de los datos.** Viajes: [NYC Taxi & Limousine Commission](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page), muestra de septiembre y octubre de 2025 con las fechas corridas un año. Clima: [Open-Meteo](https://open-meteo.com/), datos históricos por hora. Los dos archivos fueron modificados para el curso.
