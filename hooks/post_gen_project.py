"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Discription: Post project generation Scripts.
"""

import json
import os

from ansible import generate_ansible_dirs
from docs import generate_docs_templates
from utils import make


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
        "build-docs",
    ]

    for cmd in make_cmds:
        make(cmd)


if __name__ == "__main__":
    main()
