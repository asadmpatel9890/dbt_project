{% macro limit_data_in_dev(column_timestamp) %}

{% if target.name == 'dev'%}
where column_timestamp>= dateadd('day',-3,current_timestamp)
{% endif %}
{% endmacro %}