# coding: utf-8
"""Python3 Cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE.TXT file for more details.

Author: Jared Cook
"""

def test_bake_with_defaults(cookies):
    """Ensure the template bakes correctly with default context."""
    result = cookies.bake()
    assert result.exit_code == 0
    assert result.exception is None
    assert result.project_path.is_dir()

    # Optional sanity checks
    project_name = result.project_path.name
    assert project_name  # non-empty
    readme_file = result.project_path / "LICENSE"
    assert readme_file.exists()

def test_bake_with_custom_name(cookies):
    """Ensure custom project_name works."""
    result = cookies.bake(extra_context={"project_name": "test_project"})
    assert result.exit_code == 0
    assert result.exception is None
    assert result.project_path.is_dir()
    assert result.project_path.name == "test_project"
