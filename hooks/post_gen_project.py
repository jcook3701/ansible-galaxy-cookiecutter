"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Post project generation Scripts.
"""

import datetime
import json
import os
from typing import Any

from nutrimatic.core import make
from nutrimatic.hooks.post_gen_logic import (
    generate_ansible_dirs,
    generate_docs_templates,
    replace_placeholders_in_dir,
)


def main() -> None:
    """Cookiecutter Post Generation Scripts"""
    # Detect CI (e.g. GitHub Actions, GitLab CI, etc.)
    if os.getenv("CI"):
        print("⚙️  Detected CI environment — skipping GitHub Docs generation.")
        return

    current_date = datetime.datetime.now(datetime.UTC)
    date = current_date.strftime("%Y-%m-%d")
    timestamp = current_date.strftime("%Y-%m-%d %H:%M:%S %Z")
    year = current_date.strftime("%Y")

    # Access cookiecutter context safely
    context = json.loads("""{{ cookiecutter | jsonify }}""")

    autovars: dict[str, Any] = {
        context["_date"]: date,
        context["_timestamp"]: timestamp,
        context["_year"]: year,
    }

    replace_placeholders_in_dir(autovars)

    generate_docs_templates(context)
    generate_ansible_dirs()

    # Run make commands to get project seeded
    make_cmds = [
        "install",
        "git-init",
        "pre-commit-init",
        "changelog",
        # "build-docs",
    ]

    for cmd in make_cmds:
        make(cmd)


if __name__ == "__main__":
    main()
