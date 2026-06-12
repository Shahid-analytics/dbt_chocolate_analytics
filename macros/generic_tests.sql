{% test not_negative(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where {{ column_name }} < 0
{% endtest %}

{% test is_positive(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where {{ column_name }} <= 0
{% endtest %}

{% test not_greater_than(model, column_name, max_value) %}
    select {{ column_name }}
    from {{ model }}
    where {{ column_name }} > {{ max_value }}
{% endtest %}
