"""build_utils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
"""

import sys
from pathlib import Path


def add_yaml_front_matter(file_path: Path, title: str | None = None) -> bool:
    """
    Add YAML front matter to a single file.
    Returns True if modified, False if skipped.
    """
    original_content = file_path.read_text(encoding="utf-8")

    # Skip if file already begins with '---'
    if original_content.lstrip().startswith("---"):
        return False

    front_matter = [
        "---",
        f"title: {title or file_path.stem}",
        "layout: default",
        "---",
        "",
    ]
    new_text = "\n".join(front_matter) + original_content
    file_path.write_text(new_text, encoding="utf-8")
    return True


def add_front_matter_to_dir(
    directory: Path,
    extensions: set[str],
) -> int:
    """
    Walk a directory recursively, adding front matter to all valid extensions.
    Returns the number of files modified.
    """
    count = 0
    # TODO:If README.md is the name change to ansible-autodocs.md
    for file_path in directory.rglob("*"):
        if not file_path.is_file():
            continue
        print("Checking file:", file_path)
        if file_path.suffix.lower() not in extensions:
            print(" - skipped due to extension:", file_path.suffix)
            continue
        if add_yaml_front_matter(file_path):
            print(" - front matter added:", file_path)
            count += 1

    return count


def main() -> None:
    if len(sys.argv) < 2:
        print(
            "Usage: python -m build_utils.yaml_front_matter <directory>",
            file=sys.stderr,
        )
        sys.exit(1)

    target_dir = Path(sys.argv[1]).resolve()

    if not target_dir.exists():
        print(f"Error: Directory does not exist: {target_dir}", file=sys.stderr)
        sys.exit(1)

    extensions = {".yml", ".yaml", ".md"}

    modified = add_front_matter_to_dir(target_dir, extensions)
    print(f"✅ Added YAML front matter to {modified} file(s) under {target_dir}")


if __name__ == "__main__":
    main()
