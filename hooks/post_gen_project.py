"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Discription: Post project generation Scripts.
"""

import json
import os
import sys
from pathlib import Path

# Add the generated package to sys.path so Python can find it
PROJECT_DIR = Path.cwd()
HOOKS_DIR = PROJECT_DIR / "_shared_hooks" / "post_gen_logic"
sys.path.insert(0, str(HOOKS_DIR))

from ansible import generate_ansible_dirs  # noqa: E402
from docs import generate_docs_templates  # noqa: E402
from utils import clean, make  # noqa: E402


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

    clean()


if __name__ == "__main__":
    main()
