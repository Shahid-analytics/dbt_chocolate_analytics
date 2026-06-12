with sales as (

    select * from {{ ref('stg_sales') }}

),

products as (

    select * from {{ ref('stg_products') }}

),

product_performance as (

    select
        -- product details
        products.product_name,
        products.product_brand         as brand,
        products.product_category      as category,
        products.cocoa_percentage,

        -- sales details
        sales.unit_price,
        sales.discount_amount,
        sales.revenue,
        sales.cost

    from sales
    left join products
        on sales.product_id = products.product_id

)

select * from product_performance
