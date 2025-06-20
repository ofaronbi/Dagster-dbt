WITH circuits_stg AS (
    SELECT 
        CAST(circuitID AS UNSIGNED) AS circuitID,
        CAST(circuitRef AS CHAR(100)) AS circuitRef,
        CAST(name AS CHAR(100)) AS circuit_name,
        CAST(location AS CHAR(50)) AS location,
        CAST(country AS CHAR(50)) AS country,
        CAST(lat AS DECIMAL(8,4)) AS latitude,
        CAST(lng AS DECIMAL(8,4)) AS longitude,
        CAST(alt AS SIGNED) AS altitude,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'circuits') }}
),
final AS (
    SELECT * FROM circuits_stg
)
SELECT * FROM final