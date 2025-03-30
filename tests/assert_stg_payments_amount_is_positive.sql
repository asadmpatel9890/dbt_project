with payments as 
(
    select * from {{ ref('stg_stripe__payments') }}
)

select 
    order_id,
    sum(amount) AS total_amount
from
    payments
group by 
    order_id
having
    total_amount< 0