{% import '.cookiecutter_includes/community_health_files/__init__.j2' as community_health_files_macro with context %}

{{- community_health_files_macro.pull_request_template.create() -}}
