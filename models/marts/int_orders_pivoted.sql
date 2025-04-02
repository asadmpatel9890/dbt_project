with cte as
(
    select 
        * 
    from {{ ref('stg_stripe__payments') }}
)
,

pivoted as
(
    select 
    {% set payment_methods = ['credit_card','coupon','bank_transfer','gift_card']%}
        order_id,
        {% for payment_method in payment_methods-%}
            sum(case when payment_method='{{payment_method}}' then amount else 0 end ) as bank_transfer_amount_{{payment_method}}
            {%- if not loop.last -%}
                ,
            {% endif -%}
        {% endfor %}
    from cte
    where status= 'success'
    group by 1
)

select * from pivoted