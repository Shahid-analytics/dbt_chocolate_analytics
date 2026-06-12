{% macro discount_category(discount_col, revenue_col) %}
    case
        when {{ revenue_col }} = 0                                                  then 'None'
        when {{ discount_col }} / nullif({{ revenue_col }}, 0) * 100 = 0            then 'None'
        when {{ discount_col }} / nullif({{ revenue_col }}, 0) * 100 <= 10          then 'Low'
        when {{ discount_col }} / nullif({{ revenue_col }}, 0) * 100 <= 25          then 'Medium'
        else                                                                              'High'
    end
{% endmacro %}
