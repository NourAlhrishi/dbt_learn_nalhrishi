
with order_payments as (

    select 
            order_id, 
            sum(amount) as amount

    from {{ ref('stg_payment') }}

    group by 1
)

select 
    o.order_id,
    o.customer_id,
    o.order_date, 
    o.status,
    coalesce(op.amount, 0) as amount

from {{ ref('stg_orders') }} o  
left join  order_payments op  on op.order_id = o.order_id

