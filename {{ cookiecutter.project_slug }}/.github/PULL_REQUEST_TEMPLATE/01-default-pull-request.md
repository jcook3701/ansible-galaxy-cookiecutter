{% import '.cookiecutter_includes/community_health_files/pull_request_template/__init__.j2' as pull_request_template_macro with context %}

{{- pull_request_template_macro.default_pull_request.create() -}}
