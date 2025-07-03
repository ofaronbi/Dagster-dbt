{# Impact of grid position: Analyze how starting position affects final race position. #}

WITH impact_of_grid_position
AS(
    SELECT 
        grid,
        ROUND(AVG(positionOrder), 2) AS avg_finish_position,
        COUNT(*) AS race_count
    FROM {{ ref('results_stg') }}
    WHERE grid > 0
    GROUP BY grid
    ORDER BY grid
),
final AS (
    SELECT * FROM impact_of_grid_position
)
SELECT * FROM final