select *, 
  {{ get_normal_revenue('transaction.transactionRevenue') }} as amount_usd,
from {{ref("week5_transactions_deduplicated_view")}}
