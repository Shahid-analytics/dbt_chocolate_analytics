with customer_segments as (

    select * from {{ ref('int_customer_segments') }}

),

with_segments as (

    select
        customer_id,
        age,
        gender,
        loyalty_flag,
        join_date,
        days_since_last_purchase,
        total_orders,
        total_units_purchased,
        avg_unit_price,
        total_discount,
        {{ discount_category('total_discount', 'total_revenue') }}  as discount_category,

        -- lifetime value
        total_revenue                                       as ltv,

        -- loyalty segment
        case
            when loyalty_flag = true  then 'Loyalty'
            else 'Non-Loyalty'
        end                                                 as loyalty_segment,

        -- age group
        case
            when age between 18 and 25 then '18-25'
            when age between 26 and 35 then '26-35'
            when age between 36 and 45 then '36-45'
            when age >= 46             then '46+'
            else 'Unknown'
        end                                                 as age_group

    from customer_segments

)

select * from with_segments
