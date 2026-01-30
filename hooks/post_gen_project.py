# post_gen_project.py for ansible-galaxy-cookiecutter
#
# SPDX-FileCopyrightText: Copyright (c) 2025-2026, Jared Cook
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import json
import os

from nutrimatic.core import make
from nutrimatic.hooks.post_gen_logic import (
    generate_ansible_dirs,
    generate_docs_templates,
    get_make_cmds,
)


def main() -> None:
    """Cookiecutter Post Generation Scripts"""
    # Detect CI (e.g. GitHub Actions, GitLab CI, etc.)
    if os.getenv("CI"):
        print("⚙️  Detected CI environment — skipping GitHub Docs generation.")
        return
    os.environ["COOKIECUTTER_HOOKS"] = "true"

    # Access cookiecutter context safely
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    generate_docs_templates(context)
    generate_ansible_dirs()

    # Run make commands to get project seeded
    make_cmds: list[str] = get_make_cmds(context)

    for cmd in make_cmds:
        make(cmd)


if __name__ == "__main__":
    main()
