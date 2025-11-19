"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Discription: Utility functions.
"""

import os
import shutil
import subprocess
import sys
from pathlib import Path


def clean() -> None:
    """Remove _shared_hooks directory."""
    _shared_hooks = Path.cwd() / "_shared_hooks"
    print(f"hooks directory: {_shared_hooks}")
    if _shared_hooks.exists() and _shared_hooks.is_dir():
        shutil.rmtree(_shared_hooks)
        print(f"Removed {_shared_hooks} directory.")
    else:
        print("_shared_hooks directory does not exist, nothing to remove.")


def make(cmd: str) -> None:
    """Run a make target inside post-gen, exiting on failure."""
    print(f"▶ Running: make {cmd}")
    result = subprocess.run(["make", cmd], check=True)
    if result.returncode != 0:
        print(f"❌ Command failed: make {cmd}")
        sys.exit(result.returncode)


def tree() -> None:
    """Run tree cmd inside the post-gen."""
    print(f"Current working directory: {os.getcwd()}")
    subprocess.run(["tree", "-a", "."], check=False)
