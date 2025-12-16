"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Post project generation Scripts.
"""

import json
import os

from nutrimatic.core import make
from nutrimatic.hooks.post_gen_logic import (
    generate_ansible_dirs,
    generate_docs_templates,
)


def main() -> None:
    """Cookiecutter Post Generation Scripts"""
    # Detect CI (e.g. GitHub Actions, GitLab CI, etc.)
    if os.getenv("CI"):
        print("⚙️  Detected CI environment — skipping GitHub Docs generation.")
        return

    # Access cookiecutter context safely
    context = json.loads("""{{ cookiecutter | jsonify }}""")

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
