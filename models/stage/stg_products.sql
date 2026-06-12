with source as (

    select * from {{ source('raw', 'Products') }}

),

renamed as (

    select
        product_id      as product_id,
        product_name    as product_name,
        brand           as product_brand,
        category        as product_category,
        cocoa_percent   as cocoa_percentage,
        weight_g        as weight_grams

    from source

)

select * from renamed
