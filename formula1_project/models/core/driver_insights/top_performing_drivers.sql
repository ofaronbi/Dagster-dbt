{# Top performing drivers Based on wins, podiums, points #}

WITH top_performing_drivers
AS (
    SELECT 
        d.forename AS first_name,
        d.surname AS last_name,
        COUNT(CASE WHEN r.positionOrder = 1 THEN 1 END) AS wins,
        COUNT(CASE WHEN r.positionOrder <= 3 THEN 1 END) AS podiums,
        SUM(r.points) AS total_points
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('drivers_stg') }} d ON r.driverId = d.driverId
    GROUP BY d.forename, d.surname
    ORDER BY total_points DESC
),
final AS (
    SELECT * FROM top_performing_drivers
)
SELECT * FROM final