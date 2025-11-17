"""build_utils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
"""

import sys
from pathlib import Path


def add_yaml_front_matter(file_path: Path, title: str | None = None) -> None:
    """Prepend YAML front matter to a Markdown file."""
    if not file_path.is_file():
        raise FileNotFoundError(f"{file_path} does not exist")

    yaml_lines = [
        "---",
        f"title: {title or file_path.stem}",
        "layout: default",
        "---",
        "",
    ]
    yaml_content = "\n".join(yaml_lines)

    original_content = file_path.read_text(encoding="utf-8")
    file_path.write_text(yaml_content + original_content, encoding="utf-8")


def add_front_matter_to_dir(directory: Path) -> None:
    """Recursively add YAML front matter to all .yml files in a directory."""
    for file_path in directory.rglob("*.yml"):
        add_yaml_front_matter(file_path)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python -m build_utils.yaml_front_matter <directory>")
        sys.exit(1)

    target_dir = Path(sys.argv[1])
    if not target_dir.is_dir():
        print(f"Error: {target_dir} is not a valid directory")
        sys.exit(1)

    add_front_matter_to_dir(target_dir)
    print(f"✅ Added YAML front matter to all .yml files under {target_dir}")
