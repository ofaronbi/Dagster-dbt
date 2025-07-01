{# Number of races per season #}

WITH race_frequency AS (
    SELECT race_year, COUNT(*) AS race_count
    FROM {{ ref('race_stg') }}
    GROUP BY race_year
    ORDER BY race_count DESC

),
final AS (
    SELECT * FROM race_frequency
)
SELECT * FROM final

