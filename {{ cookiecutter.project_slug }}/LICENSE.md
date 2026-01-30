{% import '.cookiecutter_includes/license/__init__.j2' as license_macros with context %}

{{- license_macros.license.create(
	cookiecutter.license,
  cookiecutter.copyright) -}}
