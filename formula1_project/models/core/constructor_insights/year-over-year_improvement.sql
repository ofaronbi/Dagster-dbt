

WITH `year-over-year_improvement`
AS(
    SELECT 
        c.const_name AS constructor_name,
        r.race_year,
        SUM(cs.points) AS total_points
    FROM {{ ref('constructor_standings_stg') }} cs
    JOIN {{ ref('race_stg') }} r ON cs.raceId = r.raceId
    JOIN {{ ref('constructors_stg') }} c ON cs.constructorId = c.constructorId
    GROUP BY c.const_name, r.race_year
    ORDER BY r.race_year DESC, c.const_name
), 
final AS (
    SELECT * FROM `year-over-year_improvement`
)
SELECT * FROM final