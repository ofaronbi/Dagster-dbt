{# Which circuits produce the most wins or podium finishes #}

WITH circuit_wins AS (
    SELECT *
FROM (
    SELECT 
        c.circuit_name AS circuit_name,
        COUNT(CASE WHEN r.positionOrder = 1 THEN 1 END) AS wins,
        COUNT(CASE WHEN r.positionOrder <= 3 THEN 1 END) AS podiums
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('race_stg') }} ra ON r.raceId = ra.raceId
    JOIN {{ ref('circuits_stg') }} c ON ra.circuitId = c.circuitId
    GROUP BY c.circuit_name
) AS circuit_stats
ORDER BY wins DESC
),
final AS (
    SELECT * FROM circuit_wins
)
SELECT * FROM final


