# test_bake_project.py for ansible-galaxy-cookiecutter
#
# Copyright (c) 2026, Jared Cook
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <www.gnu.org>.
#


from pytest_cookies.plugin import Cookies


def test_bake_with_defaults(cookies: Cookies) -> None:
    """Ensure the template bakes correctly with default context."""
    result = cookies.bake()
    assert result.exit_code == 0
    assert result.exception is None
    assert result.project_path.is_dir()

    # Optional sanity checks
    project_name = result.project_path.name
    assert project_name  # non-empty
    test_file = result.project_path / "LICENSE"
    assert test_file.exists()


def test_bake_with_custom_name(cookies: Cookies) -> None:
    """Ensure custom project_name works."""
    result = cookies.bake(extra_context={"project_name": "Test Project"})
    print(result)
    assert result.exit_code == 0
    assert result.exception is None
    assert result.project_path.is_dir()
    assert result.project_path.name == "jcook3701.test_project"
