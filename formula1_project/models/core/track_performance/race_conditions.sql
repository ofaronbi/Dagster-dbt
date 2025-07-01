{# Use alt, lat, lng from circuits to analyze environmental impact on race results #}

WITH race_conditions
AS (
    SELECT c.circuit_name, c.altitude, c.latitude, c.longitude,
           AVG(r.positionOrder) AS avg_finish_position
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('race_stg') }} ra ON r.raceId = ra.raceId
    JOIN {{ ref('circuits_stg') }} c ON ra.circuitId = c.circuitId
    GROUP BY c.circuit_name, c.altitude, c.latitude, c.longitude

),
final AS (
    SELECT * FROM race_conditions
)
SELECT * FROM final