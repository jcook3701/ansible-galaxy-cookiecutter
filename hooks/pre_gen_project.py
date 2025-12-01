"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Pre project generation Scripts.
"""

import json
import os
from pathlib import Path

from nutrimatic.hooks.pre_gen_logic import release_date


def main() -> None:
    """Cookiecutter Pre Generation Scripts"""
    # Detect CI (e.g. GitHub Actions, GitLab CI, etc.)
    if os.getenv("CI"):
        print("⚙️  Detected CI environment — skipping GitHub Docs generation.")
        return
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    print(f"Context: {context}")
    # json_file = "cookiecutter.json"

    json_path = Path(__file__).absolute() / "cookiecutter.json"

    # project_dir = Path.cwd()
    print(f"FileName: {json_path}")
    # print(f"JSON File: {json_file}")
    # Init Auto Variables
    release_date(json_path)


if __name__ == "__main__":
    main()
