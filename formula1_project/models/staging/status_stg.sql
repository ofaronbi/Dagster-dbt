WITH status_stg AS (
    SELECT
        CAST(statusId AS UNSIGNED) AS statusId,
        CAST(`status` AS CHAR(100)) AS status,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'status') }}
),
final AS (
    SELECT * FROM status_stg
)
SELECT * FROM final