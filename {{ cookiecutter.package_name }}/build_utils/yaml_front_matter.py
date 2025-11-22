"""build_utils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: YAML front matter injector.  Intended to be used with
ansible autodocs output.
"""

from pathlib import Path

import typer

app = typer.Typer(
    help="Add YAML front matter to markdown/YAML files recursively.",
    add_completion=False,
)


def compute_folder_depth(file_path: Path) -> int:
    zero_depth = {"readme", "index"}
    return 0 if file_path.stem.lower() in zero_depth else len(file_path.parents)


def add_yaml_front_matter_to_file(file_path: Path, project: str | None = None) -> bool:
    """
    Add YAML front matter to a single file.
    Returns True if modified, False if skipped.
    """
    # TODO:If README.md is the name change to ansible-autodocs.md
    depth = compute_folder_depth(file_path)
    readme = ["readme", "index"]
    stem = file_path.stem.lower()
    if stem in readme:
        new_name = "ansible-autodocs.md"
        new_path = file_path.with_name(new_name)
    else:
        new_path = file_path
    # Adjust for 'readme' having 0 parents but being at depth 0
    # depth = len(file_path.parents) - (1 if file_path.stem.lower() != "readme" else 0)

    parent_dir = new_path.parent.name or (project or "Project")

    original_content = (
        new_path.read_text(encoding="utf-8")
        if new_path.exists()
        else file_path.read_text(encoding="utf-8")
    )
    # Skip if file already begins with '---'
    if original_content.lstrip().startswith("---"):
        return False

    front_matter = [
        "---",
        f"title: {new_path.stem}",
        "layout: default",
        f"nav_order: {depth}",
        f"parent: {parent_dir}",
        "---",
        "",
    ]
    new_text = "\n".join(front_matter) + original_content
    file_path.write_text(new_text, encoding="utf-8")
    return True


def add_front_matter_to_dir(
    directory: Path,
    extensions: set[str],
    project: str | None = None,
) -> int:
    """
    Walk a directory recursively, adding front matter to all valid extensions.
    Returns the number of files modified.
    """
    count = 0
    for file_path in directory.rglob("*"):
        if not file_path.is_file():
            continue
        typer.echo(f"Checking file: {file_path}")
        if file_path.suffix.lower() not in extensions:
            typer.echo(f" - skipped due to extension: {file_path.suffix}")
            continue
        if add_yaml_front_matter_to_file(file_path, project):
            typer.echo(f" - front matter added: {file_path}")
            count += 1

    return count


@app.command()
def add_yaml_front_matter(
    directory: Path = typer.Argument(
        ..., exists=True, file_okay=False, help="Directory to scan"
    ),
    ext: list[str] = typer.Option(
        ["yml", "yaml", "md"],
        "--ext",
        "-e",
        help="File extensions to modify. Repeatable.",
    ),
    project: str = typer.Option(
        None,
        "--project",
        help="Project or top-level name used for top parent pages.",
    ),
):
    """
    Add YAML front matter to all files in DIRECTORY matching extensions.
    """

    extensions = {e.lower() for e in ext}

    modified = add_front_matter_to_dir(directory, extensions, project)

    typer.echo(f"✅ Added YAML front matter to {modified} file(s) under {directory}")


def main() -> None:
    app()


if __name__ == "__main__":
    main()
