with sales_enriched as (

    select * from {{ ref('int_sales_enriched') }}

),

store_performance as (

    select
        store_name,
        store_city,
        store_country,
        store_type,

        count(distinct order_id)                                    as total_orders,
        sum(quantity_sold)                                          as total_quantity,
        sum(revenue)                                                as total_revenue,
        sum(cost)                                                   as total_cost,
        {{ calculate_profit('sum(revenue)', 'sum(cost)') }}         as total_profit,
        sum(discount_amount)                                        as total_discounts,
        {{ discount_category('sum(discount_amount)', 'sum(revenue)') }} as discount_category

    from sales_enriched
    group by store_name, store_city, store_country, store_type

)

select * from store_performance
