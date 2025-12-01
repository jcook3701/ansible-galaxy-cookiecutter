"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Pre project generation Scripts.
"""

import os

from pathlib import Path
from nutrimatic.hooks.pre_gen_logic import release_date


def main() -> None:
    """Cookiecutter Pre Generation Scripts"""
    # Detect CI (e.g. GitHub Actions, GitLab CI, etc.)
    if os.getenv("CI"):
        print("⚙️  Detected CI environment — skipping GitHub Docs generation.")
        return
    
    project_dir = Path.cwd()

    # Init Auto Variables
    release_date(path=project_dir)


if __name__ == "__main__":
    main()
