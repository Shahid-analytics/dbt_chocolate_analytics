with sales as (

    select * from {{ ref('stg_sales') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

-- aggregate sales to customer level for RFM metrics
customer_orders as (

    select
        customer_id,

        -- recency: days since last purchase
        datediff('day', max(order_date), current_date)  as days_since_last_purchase,

        -- frequency: total number of orders
        count(distinct order_id)                         as total_orders,

        -- monetary: total spend metrics
        sum(revenue)                                     as total_revenue,
        sum(cost)                                        as total_cost,
        sum(quantity_sold)                               as total_units_purchased,
        avg(unit_price)                                  as avg_unit_price,
        sum(discount_amount)                             as total_discount

    from sales
    group by customer_id

),

enriched as (

    select
        -- customer profile
        customers.customer_id,
        customers.customer_age          as age,
        customers.customer_gender       as gender,
        customers.is_loyalty_member     as loyalty_flag,
        customers.customer_join_date    as join_date,

        -- recency
        customer_orders.days_since_last_purchase,

        -- frequency
        customer_orders.total_orders,

        -- monetary
        customer_orders.total_revenue,
        customer_orders.total_cost,
        customer_orders.total_units_purchased,
        customer_orders.avg_unit_price,
        customer_orders.total_discount

    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.customer_id

)

select * from enriched
