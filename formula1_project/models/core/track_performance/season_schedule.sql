{# Locations and dates of all races in a season #}
WITH season_schedule
AS (
    SELECT r.race_year, r.race_date, c.circuit_name, c.location, c.country
    FROM {{ ref('race_stg') }} r
    JOIN {{ ref('circuits_stg') }} c ON r.circuitId = c.circuitId
    ORDER BY r.race_year DESC, r.race_date
),
final AS(
    SELECT * FROM season_schedule
)
SELECT * FROM final