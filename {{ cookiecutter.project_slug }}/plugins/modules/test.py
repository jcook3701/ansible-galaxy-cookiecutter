{% import '.cookiecutter_includes/license_header.jinja' as license_macros with context %}
{{- license_macros.license_header(
  cookiecutter.license,
  cookiecutter.author,
  cookiecutter.project_slug,
  file_name='test.py',
  comment_style='python') -}}
