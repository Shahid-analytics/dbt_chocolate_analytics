with source as (

    select * from {{ source('raw', 'Sales') }}

),

renamed as (

    select
        order_id        as order_id,
        order_date      as order_date,
        product_id      as product_id,
        store_id        as store_id,
        customer_id     as customer_id,
        quantity        as quantity_sold,
        unit_price      as unit_price,
        discount        as discount_amount,
        revenue         as revenue,
        cost            as cost

    from source

)

select * from renamed
