WITH constructor_results_stg AS (
    SELECT
        CAST(constructorResultsId AS UNSIGNED) AS constructorResultsId,
        CAST(raceId AS UNSIGNED) AS raceId,
        CAST(constructorId AS UNSIGNED) AS constructorId,
        CAST(points AS DECIMAL(5,2)) AS points,
        CASE 
            WHEN TRIM(status) IN ('\\N', '-', '') THEN NULL
                ELSE CAST(`status` AS CHAR(25))
                END AS const_rst_status,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'constructor_results') }}
),
final AS (
    SELECT * FROM constructor_results_stg
)
SELECT * FROM final





