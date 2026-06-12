with product_performance as (

    select * from {{ ref('int_product_performance') }}

),

product_analysis as (

    select
        product_name,
        brand,
        category,
        cocoa_percentage,

        count(*)                                                    as total_transactions,
        sum(revenue)                                                as total_revenue,
        sum(cost)                                                   as total_cost,
        {{ calculate_profit('sum(revenue)', 'sum(cost)') }}         as total_profit,
        sum(discount_amount)                                        as total_discounts,
        avg(unit_price)                                             as avg_unit_price,
        {{ discount_category('sum(discount_amount)', 'sum(revenue)') }} as discount_category

    from product_performance
    group by product_name, brand, category, cocoa_percentage

)

select * from product_analysis
