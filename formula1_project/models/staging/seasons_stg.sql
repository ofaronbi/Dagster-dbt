WITH seasons_stg AS (
    SELECT
        CAST(`year` AS CHAR(10)) AS season_year,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'seasons') }}
),
final AS (
    SELECT * FROM seasons_stg
)
SELECT * FROM final
