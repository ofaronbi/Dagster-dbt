WITH drivers_stg AS (
    SELECT
        CAST(driverId AS UNSIGNED) AS driverId,
        CAST(driverRef AS CHAR(100)) AS driverRef,
        CASE
            WHEN TRIM(`number`) IN ('\\N', '-', '') THEN NULL
            ELSE CAST(`number` AS UNSIGNED) 
            END AS drivers_number,
        CAST(code AS CHAR(5)) AS code,
        CAST(forename AS CHAR(50)) AS forename,
        CAST(surname AS CHAR(50)) AS surname,
        CAST(dob AS DATE) AS dob,
        CAST(nationality AS CHAR(50)) AS nationality,
        CURRENT_TIMESTAMP AS created_date
    FROM {{ source('formula1', 'drivers') }}
),
final AS (
    SELECT * FROM drivers_stg
)
SELECT * FROM final
