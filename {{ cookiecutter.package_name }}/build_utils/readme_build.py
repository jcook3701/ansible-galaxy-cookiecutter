"""build_utils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Project README generation.
"""

import shutil
import subprocess
from pathlib import Path

import typer

app = typer.Typer(
    help="Generate README.md with Jekyll.",
    add_completion=False,
)


def _write_front_matter(
    tmp_readme: Path,
    source_readme: Path,
    jekyll_dir: Path,
) -> None:
    """Write the Jekyll front matter + auto-generated comment + original content."""

    with tmp_readme.open("w", encoding="utf-8") as f:
        f.write("---\n")
        f.write("layout: raw\n")
        f.write("permalink: /README.md\n")
        f.write("---\n")
        f.write("<!--\n")
        f.write("  Auto-generated file. Do not edit directly.\n")
        f.write(f"  Edit {source_readme} instead.\n")
        f.write("  Run ```make readme``` to regenerate this file\n")
        f.write("-->\n")
        # Append original README.md content
        f.write((jekyll_dir / "README.md").read_text(encoding="utf-8"))


@app.command()
def build_readme(
    jekyll_dir: Path = typer.Argument(..., help="Path to the Jekyll docs directory"),
    output_file: Path = typer.Argument(..., help="Final README.md output file path"),
    readme_gen_dir: Path = typer.Option(
        Path("./docs/.tmp_readme"),
        "--tmp-dir",
        "-t",
        help="Temporary directory to generate README.md",
    ),
    jekyll_build_cmd: str = typer.Option(
        "jekyll build",
        "--jekyll-cmd",
        "-c",
        help="Jekyll build command to execute",
    ),
):
    """
    Build README.md using Jekyll exactly like the Makefile target.
    """

    typer.echo("🔨 Building ./README.md 📘 with Jekyll...")

    # Ensure temp build directory exists
    readme_gen_dir.mkdir(parents=True, exist_ok=True)

    # Copy _config.yml and Gemfile
    shutil.copy(jekyll_dir / "_config.yml", readme_gen_dir / "_config.yml")
    shutil.copy(jekyll_dir / "Gemfile", readme_gen_dir / "Gemfile")

    # Write tmp README.md (front matter + comment + content)
    tmp_readme = readme_gen_dir / "README.md"
    source_readme = jekyll_dir / "README.md"
    _write_front_matter(tmp_readme, source_readme, jekyll_dir)

    # Run Jekyll build
    subprocess.run(jekyll_build_cmd, shell=True, check=True, cwd=readme_gen_dir)

    # Copy result back to project
    shutil.copy(readme_gen_dir / "_site/README.md", output_file)

    # Cleanup
    shutil.rmtree(readme_gen_dir)
    typer.echo("🧹 Cleaning README.md build artifacts...")
    typer.echo("✅ README.md auto generation complete!")


def main() -> None:
    app()


if __name__ == "__main__":
    main()
