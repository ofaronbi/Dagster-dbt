WITH constructors_stg AS (
    SELECT
        CAST(constructorID AS UNSIGNED) AS constructorID,
        CAST(constructorRef AS CHAR(100)) AS constructorRef,
        CAST(`name` AS CHAR(100)) AS const_name,
        CAST(nationality AS CHAR(100)) AS nationality,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'constructors') }}
),
final AS (
    SELECT * FROM constructors_stg
)
SELECT * FROM final