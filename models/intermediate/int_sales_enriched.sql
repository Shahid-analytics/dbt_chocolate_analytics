with sales as (

    select * from {{ ref('stg_sales') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

stores as (

    select * from {{ ref('stg_stores') }}

),

enriched as (

    select
        -- order details
        sales.order_id,
        sales.order_date,
        sales.quantity_sold,
        sales.unit_price,
        sales.discount_amount,
        sales.revenue,
        sales.cost,

        -- customer details
        customers.customer_age         as age,
        customers.customer_gender      as gender,
        customers.is_loyalty_member    as loyalty_flag,

        -- store details
        stores.store_name,
        stores.store_city,
        stores.store_country,
        stores.store_type

    from sales
    left join customers
        on sales.customer_id = customers.customer_id
    left join stores
        on sales.store_id = stores.store_id

)

select * from enriched
