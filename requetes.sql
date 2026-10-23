-- ========================================
-- 1. Taux de churn par type de forfait
-- ========================================
SELECT
  plan_type,
  COUNT(*) AS total_membres,
  COUNTIF(churned = true) AS nb_resilies,
  ROUND(COUNTIF(churned = true) / COUNT(*) * 100, 1) AS taux_churn_pct
FROM `Peloton_Churn.subscriptions`
GROUP BY plan_type;


-- ========================================
-- 2.  Churn par canal d'acquisition
-- ========================================
SELECT
  acquisition_channel,
  COUNT(*) AS total_membres,
  COUNTIF(churned = true) AS nb_resilies,
  ROUND(COUNTIF(churned = true ) / COUNT(*) * 100, 1) AS taux_churn_pct
FROM `peloton-churn.Peloton_Churn.subscriptions`
GROUP BY acquisition_channel

-- ========================================
-- 3. Durée de vie 
-- ========================================
SELECT
  CASE
    WHEN DATE_DIFF(churn_date, signup_date, DAY) <= 90  THEN '0-3 mois'
    WHEN DATE_DIFF(churn_date, signup_date, DAY) <= 180 THEN '3-6 mois'
    ELSE '6 mois +'
  END AS tranche,
  COUNT(*) AS nb,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM `Peloton_Churn.subscriptions`
WHERE churned = true
GROUP BY tranche
ORDER BY tranche

  
-- ========================================
-- 4. Écart d'activités les premiers mois
-- ========================================
WITH usage_numerote AS (
  SELECT
    u.customer_id,
    s.churned,
    u.minutes_active,
    u.workouts_completed,
    ROW_NUMBER() OVER (PARTITION BY u.customer_id ORDER BY u.month) AS rang_mois
  FROM `Peloton_Churn.usage` AS u
  JOIN `Peloton_Churn.subscriptions` AS s
    ON u.customer_id = s.customer_id
)
SELECT
  rang_mois,
  churned,
  ROUND(AVG(minutes_active), 1)     AS minutes_moy,
  ROUND(AVG(workouts_completed), 1) AS seances_moy
FROM usage_numerote
WHERE rang_mois <= 6
GROUP BY rang_mois, churned
ORDER BY rang_mois, churned


-- ========================================
-- 5. Solde inscription et résiliation
-- ========================================
WITH inscriptions AS (
  SELECT DATE_TRUNC(signup_date, MONTH) AS mois, COUNT(*) AS nb_inscriptions
  FROM `Peloton_Churn.subscriptions` GROUP BY mois
),
resiliations AS (
  SELECT DATE_TRUNC(churn_date, MONTH) AS mois, COUNT(*) AS nb_resiliations
  FROM `Peloton_Churn.subscriptions` WHERE churned = true GROUP BY mois
)
SELECT
  COALESCE(i.mois, r.mois) AS mois,
  i.nb_inscriptions,
  r.nb_resiliations,
  i.nb_inscriptions - COALESCE(r.nb_resiliations, 0) AS solde_net
FROM inscriptions AS i
FULL OUTER JOIN resiliations AS r ON i.mois = r.mois
ORDER BY mois


-- ========================================
-- 6. Churn par appareil
-- ========================================
SELECT
  primary_device,
  COUNT(*) AS total_membres,
  COUNTIF(churned = true) AS nb_resilies,
  ROUND(COUNTIF(churned = true ) / COUNT(*) * 100, 1) AS taux_churn_pct
FROM `peloton-churn.Peloton_Churn.subscriptions`
GROUP BY primary_device;


-- ========================================
-- 7.Churn par groupe d'âge
-- ========================================
SELECT
  age_group,
  COUNT(*) AS total_membres,
  COUNTIF(churned = true) AS nb_resilies,
  ROUND(COUNTIF(churned = true ) / COUNT(*) * 100, 1) AS taux_churn_pct
FROM `peloton-churn.Peloton_Churn.subscriptions`
GROUP BY age_group;

  
-- ========================================
-- 8. Churn par raison de résiliation
-- ========================================
SELECT
  cancel_reason,
  COUNTIF(churned = true) AS nb_resilies
FROM `peloton-churn.Peloton_Churn.subscriptions`
GROUP BY cancel_reason;
