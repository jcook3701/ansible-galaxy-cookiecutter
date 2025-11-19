"""build_utils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Unit tests for yaml_front_matter.
"""


import pytest
from pathlib import Path

from build_utils.yaml_front_matter import (
    add_yaml_front_matter,
    add_front_matter_to_dir,
)


def test_add_yaml_front_matter_adds_front_matter(tmp_path: Path):
    file = tmp_path / "example.md"
    file.write_text("Original content", encoding="utf-8")

    modified = add_yaml_front_matter(file)

    assert modified is True
    text = file.read_text(encoding="utf-8")

    assert text.startswith("---")
    assert "title: example" in text
    assert "layout: default" in text
    assert "Original content" in text


def test_add_yaml_front_matter_skips_existing_front_matter(tmp_path: Path):
    file = tmp_path / "already.md"
    file.write_text(
        "---\ntitle: test\nlayout: default\n---\nExisting",
        encoding="utf-8"
    )

    modified = add_yaml_front_matter(file)

    assert modified is False
    text = file.read_text(encoding="utf-8")

    # Should be unchanged
    assert text.startswith("---")
    assert "Existing" in text


def test_add_front_matter_to_dir_counts_correctly(tmp_path: Path):
    valid = tmp_path / "doc.yaml"
    valid.write_text("hello", encoding="utf-8")

    invalid = tmp_path / "notes.txt"
    invalid.write_text("ignore me", encoding="utf-8")

    exts = {".yml", ".yaml", ".md"}

    count = add_front_matter_to_dir(tmp_path, exts)

    assert count == 1
    assert valid.read_text(encoding="utf-8").startswith("---")
    assert not invalid.read_text(encoding="utf-8").startswith("---")


def test_recursive_directory_handling(tmp_path: Path):
    subdir = tmp_path / "nested"
    subdir.mkdir()

    file = subdir / "test.yml"
    file.write_text("data", encoding="utf-8")

    exts = {".yml", ".yaml", ".md"}

    count = add_front_matter_to_dir(tmp_path, exts)

    assert count == 1
    assert file.read_text(encoding="utf-8").startswith("---")


def test_title_is_overridden(tmp_path: Path):
    file = tmp_path / "anything.md"
    file.write_text("body", encoding="utf-8")

    add_yaml_front_matter(file, title="Custom Title")

    text = file.read_text(encoding="utf-8")
    assert "title: Custom Title" in text
