-- Prueba de entorno. No consulta ningún dato: solo verifica que dbt
-- pueda autenticarse contra tu proyecto y crear una tabla en él.

select
    current_timestamp() as corrido_en,
    'Si ves esta tabla en BigQuery, tu entorno funciona.' as mensaje
