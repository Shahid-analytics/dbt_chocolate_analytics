{% snapshot scd_products_cocoa %}

{{
    config(
        target_schema='snapshots',
        unique_key='product_id',
        strategy='check',
        check_cols=['cocoa_percentage']
    )
}}

select
    product_id,
    product_name,
    product_brand,
    product_category,
    cocoa_percentage,
    weight_grams

from {{ ref('stg_products') }}

{% endsnapshot %}
