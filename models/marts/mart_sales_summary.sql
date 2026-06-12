with sales_enriched as (

    select * from {{ ref('int_sales_enriched') }}

),

daily_summary as (

    select
        {{ generate_surrogate_key(['order_date']) }}  as sales_summary_key,
        order_date,
        count(distinct order_id)    as total_orders,
        sum(quantity_sold)          as total_quantity,
        sum(revenue)                as total_revenue,
        sum(discount_amount)        as total_discounts,
        sum(cost)                   as total_cost,
        {{ calculate_profit('sum(revenue)', 'sum(cost)') }} as total_profit,
        {{ discount_category('sum(discount_amount)', 'sum(revenue)') }} as discount_category

    from sales_enriched
    group by order_date

)

select * from daily_summary
