"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Discription: Ansible specific post generation hooks.
"""

from pathlib import Path


def generate_ansible_dirs() -> None:
    """Generate ansible project directories"""
    project_dir = Path.cwd()
    ansible_dirs = [
        "library",
        "playbooks",
        "roles",
        "tests"
    ]

    for d in ansible_dirs:
        dir_path = project_dir / d
        if not dir_path.exists():
            dir_path.mkdir(parents=True, exist_ok=True)
            print(f"📁 Created {dir_path}")
        else:
            print(f"✔️  {dir_path} already exists")
