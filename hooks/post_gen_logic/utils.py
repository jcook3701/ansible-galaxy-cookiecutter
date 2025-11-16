"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Discription: Utility functions.
"""

import subprocess
import sys


def make(cmd: str) -> None:
    """Run a make target inside post-gen, exiting on failure."""
    print(f"▶ Running: make {cmd}")
    result = subprocess.run(["make", cmd], check=True)
    if result.returncode != 0:
        print(f"❌ Command failed: make {cmd}")
        sys.exit(result.returncode)
