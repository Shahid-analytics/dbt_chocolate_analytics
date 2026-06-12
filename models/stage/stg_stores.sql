with source as (

    select * from {{ source('raw', 'Stores') }}

),

renamed as (

    select
        Store_id    as store_id,
        store_name  as store_name,
        city        as store_city,
        country     as store_country,
        store_type  as store_type

    from source

)

select * from renamed
