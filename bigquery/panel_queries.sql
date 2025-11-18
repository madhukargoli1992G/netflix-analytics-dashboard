-- =========================================================
-- Netflix Analytics 2010–2025
-- BigQuery SQL for all 15 Grafana panels
-- Table: madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public
-- =========================================================


-- ---------------------------------------------------------
-- Panel 1 – Total Movies in Dataset (Stat)
-- ---------------------------------------------------------
SELECT
  COUNT(*) AS total_titles,
  CURRENT_TIMESTAMP() AS time
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE title IS NOT NULL;


-- ---------------------------------------------------------
-- Panel 2 – ROI Over Time (Time series by release_year)
-- ---------------------------------------------------------
SELECT
  TIMESTAMP(DATETIME(release_year, 1, 1)) AS year_ts,
  release_year,
  ROUND(AVG(roi), 2) AS avg_roi
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE roi IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


-- ---------------------------------------------------------
-- Panel 3 – Genre Distribution (Bar chart)
-- Splits multi-genre strings into separate rows.
-- ---------------------------------------------------------
WITH exploded AS (
  SELECT
    TRIM(genre) AS genre
  FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`,
  UNNEST(SPLIT(genres, ',')) AS genre
  WHERE genres IS NOT NULL
)
SELECT
  genre,
  COUNT(*) AS total_titles
FROM exploded
GROUP BY genre
ORDER BY total_titles DESC;


-- ---------------------------------------------------------
-- Panel 4 – Country-wise ROI Leaders (Top countries by avg ROI)
-- Uses only first country from the list, with a minimum count.
-- ---------------------------------------------------------
WITH country_clean AS (
  SELECT
    TRIM(SPLIT(country, ',')[OFFSET(0)]) AS country_part,
    roi
  FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
  WHERE country IS NOT NULL
    AND roi IS NOT NULL
)
SELECT
  country_part AS country,
  ROUND(AVG(roi), 2) AS avg_roi,
  COUNT(*) AS title_count
FROM country_clean
GROUP BY country
HAVING COUNT(*) >= 10
ORDER BY avg_roi DESC
LIMIT 15;


-- ---------------------------------------------------------
-- Panel 5 – Country-wise Movie Success (Titles per country)
-- ---------------------------------------------------------
WITH country_clean AS (
  SELECT
    TRIM(SPLIT(country, ',')[OFFSET(0)]) AS country_part
  FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
  WHERE country IS NOT NULL
)
SELECT
  country_part AS country,
  COUNT(*) AS total_titles
FROM country_clean
GROUP BY country
ORDER BY total_titles DESC
LIMIT 20;


-- ---------------------------------------------------------
-- Panel 6 – Average Duration by Genre
-- ---------------------------------------------------------
WITH exploded AS (
  SELECT
    TRIM(genre) AS genre,
    duration
  FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`,
  UNNEST(SPLIT(genres, ',')) AS genre
  WHERE genres IS NOT NULL
    AND duration IS NOT NULL
)
SELECT
  genre,
  ROUND(AVG(duration), 1) AS avg_duration_minutes,
  COUNT(*) AS title_count
FROM exploded
GROUP BY genre
HAVING COUNT(*) >= 20
ORDER BY avg_duration_minutes DESC;


-- ---------------------------------------------------------
-- Panel 7 – Ratings Distribution (Histogram-style)
-- ---------------------------------------------------------
SELECT
  rating,
  COUNT(*) AS total_titles
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY rating;


-- ---------------------------------------------------------
-- Panel 8 – Release Trend by Year (Titles per release_year)
-- ---------------------------------------------------------
SELECT
  release_year,
  COUNT(*) AS total_titles
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


-- ---------------------------------------------------------
-- Panel 9 – ROI vs Popularity & Vote Count (Scatter)
-- Used as “Predicted ROI based on popularity & vote_count”
-- ---------------------------------------------------------
SELECT
  popularity,
  vote_count,
  ROUND(roi, 2) AS predicted_roi
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE popularity IS NOT NULL
  AND vote_count IS NOT NULL
  AND roi IS NOT NULL;


-- ---------------------------------------------------------
-- Panel 10 – Top 10 Highest Rated Titles
-- With a minimum vote_count threshold.
-- ---------------------------------------------------------
SELECT
  title,
  release_year,
  vote_average,
  vote_count,
  popularity
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE vote_average IS NOT NULL
  AND vote_count >= 500
ORDER BY vote_average DESC, vote_count DESC
LIMIT 10;


-- ---------------------------------------------------------
-- Panel 11 – Language Distribution
-- ---------------------------------------------------------
SELECT
  language,
  COUNT(*) AS total_titles
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE language IS NOT NULL
GROUP BY language
ORDER BY total_titles DESC;


-- ---------------------------------------------------------
-- Panel 12 – Age Rating Distribution (using numeric rating field)
-- ---------------------------------------------------------
SELECT
  rating AS age_rating,
  COUNT(*) AS total_titles
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE rating IS NOT NULL
GROUP BY age_rating
ORDER BY age_rating;


-- ---------------------------------------------------------
-- Panel 13 – Movie Runtime Patterns (Avg duration by release_year)
-- ---------------------------------------------------------
SELECT
  release_year,
  ROUND(AVG(duration), 1) AS avg_duration_minutes,
  COUNT(*) AS title_count
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE release_year IS NOT NULL
  AND duration IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


-- ---------------------------------------------------------
-- Panel 14 – Global ROI Efficiency (ROI buckets)
-- ---------------------------------------------------------
SELECT
  CASE
    WHEN roi IS NULL THEN 'Unknown'
    WHEN roi < 0 THEN 'Loss (< 0)'
    WHEN roi >= 0 AND roi < 1 THEN 'Low (0–1x)'
    WHEN roi >= 1 AND roi < 2 THEN 'Moderate (1–2x)'
    WHEN roi >= 2 AND roi < 5 THEN 'High (2–5x)'
    WHEN roi >= 5 THEN 'Very High (5x +)'
  END AS roi_bucket,
  COUNT(*) AS total_titles
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
GROUP BY roi_bucket
ORDER BY
  CASE roi_bucket
    WHEN 'Loss (< 0)' THEN 1
    WHEN 'Low (0–1x)' THEN 2
    WHEN 'Moderate (1–2x)' THEN 3
    WHEN 'High (2–5x)' THEN 4
    WHEN 'Very High (5x +)' THEN 5
    WHEN 'Unknown' THEN 6
  END;


-- ---------------------------------------------------------
-- Panel 15 – High-Budget vs High-Revenue Titles (Scatter)
-- ---------------------------------------------------------
SELECT
  budget,
  revenue,
  profit,
  roi,
  title,
  release_year
FROM `madhukargolipersonal.netflix_analysis.Netflix_Analysis_2010_2025_updated_public`
WHERE budget IS NOT NULL
  AND revenue IS NOT NULL
  AND budget > 0
  AND revenue > 0;
