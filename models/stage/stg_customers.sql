with source as (

    select * from {{ source('raw', 'Customers') }}

),

renamed as (

    select
        Customer_id     as customer_id,
        age             as customer_age,
        gender          as customer_gender,
        loyalty_member  as is_loyalty_member,
        join_date       as customer_join_date

    from source

)

select * from renamed
