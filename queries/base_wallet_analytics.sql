SELECT
  ROUND(SUM(value)/1e18, 5) AS total_volume_eth,
  COUNT(*) AS tx_count,
  COUNT(DISTINCT "to") AS unique_contracts,
  ROUND(SUM(gas_used * gas_price)/1e18, 5) AS gas_spent_eth,
  MIN(block_time) AS first_activity,
  COUNT(DISTINCT date_trunc('day', block_time)) AS active_days,
  COUNT(DISTINCT date_trunc('month', block_time)) AS active_months,
  SUM(
    CASE
      WHEN value > 0 AND "to" IS NOT NULL THEN 1
      ELSE 0
    END
  ) AS bridge_like_tx
FROM base.transactions
WHERE success = true
  AND (
    "from" = from_hex('9d5765595a92c560c8759d2a9c375c66123765a5')
    OR "to" = from_hex('9d5765595a92c560c8759d2a9c375c66123765a5')
  );
