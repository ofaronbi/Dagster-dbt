{# Constructor vs. Driver performance: Which constructors perform best when paired with certain drivers. #}

WITH constructor_vs_driver_performance
AS(
    SELECT 
        c.const_name AS constructor_name,
        d.forename AS first_name,
        d.surname AS last_name,
        SUM(r.points) AS total_driver_points
    FROM {{ ref('results_stg') }} r
    JOIN {{ ref('drivers_stg') }} d ON r.driverId = d.driverId
    JOIN {{ ref('constructors_stg') }} c ON r.constructorId = c.constructorId
    GROUP BY c.const_name, d.forename, d.surname
    ORDER BY total_driver_points DESC
),
final AS (
    SELECT * FROM constructor_vs_driver_performance
)
SELECT * FROM final