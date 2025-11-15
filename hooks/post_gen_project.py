"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
"""

import json
import os
import shutil

from cookiecutter.main import cookiecutter


def generate_docs_templates(context: dict) -> None:
    """Generate one or more documentation templates inside docs/"""
    project_dir = os.getcwd()
    docs_dir = os.path.join(project_dir, "docs")
    tmp_dir = os.path.join(docs_dir, "_tmp_docs")

    os.makedirs(tmp_dir, exist_ok=True)

    base_ctx = {
        "project_name": context.get("project_name"),
        "author": context.get("author"),
        "version": context.get("version"),
        "description": context.get("description"),
    }

    templates = {
        "github": {
            "enabled": context.get("add_github_docs", True),
            "name": "Github",
            "repo": "jcook3701/github-docs-cookiecutter",
            "target": os.path.join(docs_dir, "jekyll"),
            "extra_ctx": {
                **base_ctx,
                "theme": context.get("theme"),
                "ga_tracking": context.get("ga_tracking"),
                "github_username": context.get("github_username"),
                "linkedin_usercode": context.get("linkedin_usercode"),
                "twitter_username": context.get("twitter_username"),
                "buymeacoffee_username": context.get("buymeacoffee_username"),
            },
        },
        "sphinx": {
            "enabled": context.get("add_sphinx_docs", True),
            "name": "Sphinx",
            "repo": "jcook3701/sphinx-cookiecutter",
            "target": os.path.join(docs_dir, "sphinx"),
            "extra_ctx": {
                **base_ctx,
            },
        },
    }

    for _key, cfg in templates.items():
        if not cfg.get("enabled", True):
            print(f"🚫 Skipping {cfg['name']} docs (disabled)")
            continue

        name = cfg["name"]
        repo = cfg["repo"]
        target = cfg["target"]
        extra_ctx = cfg["extra_ctx"]

        print(f"📦 Generating {name} docs from {repo} → {target}")

        try:
            # Bake template into temp directory
            cookiecutter(
                f"https://github.com/{repo}.git",
                no_input=True,
                extra_context=extra_ctx,
                output_dir=tmp_dir,
            )

            # Find the generated folder (Cookiecutter creates a subfolder automatically)
            subdirs = [os.path.join(tmp_dir, d) for d in os.listdir(tmp_dir) if os.path.isdir(os.path.join(tmp_dir, d))]
            if not subdirs:
                print(f"⚠️  No generated directory found for {name}")
                continue

            generated_dir = subdirs[0]

            if os.path.exists(target):
                shutil.rmtree(target)
            shutil.move(generated_dir, target)

            # Clean up tmp
            for d in os.listdir(tmp_dir):
                path = os.path.join(tmp_dir, d)
                if os.path.isdir(path):
                    shutil.rmtree(path)

            print(f"✅ {name} Docs generated in {target}")

        except Exception as e:
            print(f"⚠️  Skipping {name} Docs generation: {e}")

        print("🎉 All documentation templates generated successfully!")


def main() -> None:
    # Detect CI (e.g. GitHub Actions, GitLab CI, etc.)
    if os.getenv("CI"):
        print("⚙️  Detected CI environment — skipping GitHub Docs generation.")
        return

    # Access cookiecutter context safely
    context = json.loads("""{{ cookiecutter | jsonify }}""")

    generate_docs_templates(context)


if __name__ == "__main__":
    main()
