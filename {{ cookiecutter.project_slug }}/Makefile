{% import '.cookiecutter_includes/license/__init__.j2' as license_macros with context %}
{{- license_macros.license_header.create(
	cookiecutter.license,
	cookiecutter.author,
	cookiecutter.project_slug,
	file_name='Makefile',
	comment_style='hash') -}}
# --------------------------------------------------
# ⚙️ Environment Settings
# --------------------------------------------------
SHELL := /bin/bash
.SHELLFLAGS := -O globstar -c
PROJECT_ROOT := $(PWD)
# If V is set to '1' or 'y' on the command line,
# AT will be empty (verbose).  Otherwise, AT will
# contain '@' (quiet by default).  The '?' is a
# conditional assignment operator: it only sets V
# if it hasn't been set externally.
V ?= 0
ifeq ($(V),0)
    AT = @
else
    AT =
endif

# Detect if we are running inside GitHub Actions CI 👷.
# GitHub sets the environment variable GITHUB_ACTIONS=true in workflows.
# We set CI=1 if running in GitHub Actions, otherwise CI=0 for local runs.
ifeq ($(GITHUB_ACTIONS),true)
CI := 1
else
CI := 0
endif
# --------------------------------------------------
# 🏗️ CI/CD Functions
# --------------------------------------------------
# Returns true when CI is off and gracefully moves through failed checks.
define run_ci_safe =
( $1 || \
	if [ "$(CI)" != "1" ]; then \
		echo "❌ process finished with error; continuing..."; \
		true; \
	else \
		echo "❌ process finished with error"; \
		exit 1; \
	fi \
)
endef
# --------------------------------------------------
# ⚙️ Build Settings
# --------------------------------------------------
GALAXY_NAMESPACE := {{ cookiecutter.__namespace }}
GALAXY_COLLECTION := {{ cookiecutter.__project_name }}
GALAXY_PACKAGE_NAME = $(GALAXY_NAMESPACE).$(GALAXY_COLLECTION)
GALAXY_AUTHOR := {{ cookiecutter.author }}
GALAXY_VERSION := {{ cookiecutter.version }}
GALAXY_RELEASE := v$(GALAXY_VERSION)
GALAXY_PATH := $(PROJECT_ROOT)
# --------------------------------------------------
# 🐙 Github Build Settings
# --------------------------------------------------
GITHUB_USER := "{{ cookiecutter.github_username }}"
GITHUB_REPO = $(GITHUB_USER)/$(PACKAGE_NAME)
# --------------------------------------------------
# 📁 Build Directories
# --------------------------------------------------
PLAYBOOKS_DIR := $(PROJECT_ROOT)/playbooks
PLUGINS_DIR := $(PROJECT_ROOT)/plugins
ROLES_DIR := $(PROJECT_ROOT)/roles
SRC_DIR := $(PLUGINS_DIR)
TESTS_DIR := $(PROJECT_ROOT)/tests
DOCS_DIR := $(PROJECT_ROOT)/docs
SPHINX_DIR := $(DOCS_DIR)/sphinx
JEKYLL_DIR := $(DOCS_DIR)/jekyll
JEKYLL_SPHINX_DIR := $(JEKYLL_DIR)/sphinx
JEKYLL_AUTODOC_DIR := $(JEKYLL_DIR)/ansible-docs
README_GEN_DIR := $(JEKYLL_DIR)/tmp_readme
CHANGELOG_DIR := $(PROJECT_ROOT)/changelogs
CHANGELOG_RELEASE_DIR := $(CHANGELOG_DIR)/releases
# --------------------------------------------------
# 📄 Build Files
# --------------------------------------------------
README_FILE := $(PROJECT_ROOT)/README.md
AUTODOC_README_FILE := $(JEKYLL_AUTODOC_DIR)/ansible-autodoc.md
CHANGELOG_FILE := $(CHANGELOG_DIR)/changelog.yml
TARBALL := $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz
# --------------------------------------------------
# 🐍 Python / Virtual Environment
# --------------------------------------------------
PYTHON_CMD := python3.11
VENV_DIR := .venv
# --------------------------------------------------
# 🐍 Python Dependencies
# --------------------------------------------------
DEV_DEPS := .[dev]
DEV_TOOLS := .[tools]
DEV_DOCS := .[docs]
# --------------------------------------------------
# 🐍 Python Commands (venv, activate, pip)
# --------------------------------------------------
CREATE_VENV := $(PYTHON_CMD) -m venv $(VENV_DIR)
ACTIVATE := source $(VENV_DIR)/bin/activate
PYTHON := $(ACTIVATE) && $(PYTHON_CMD)
PIP := $(PYTHON) -m pip
# --------------------------------------------------
# 🍪 Project Updater (cookiecutter_project_upgrader)
# --------------------------------------------------
# NOTE: Git version 2.9 required to use this tool.
# Example: $(PROJECT_UPGRADE) --context-file $(DOCS_DIR)/cookiecutter_inputs.json
PROJECT_UPGRADE := $(ACTIVATE) && cookiecutter_project_upgrader
# --------------------------------------------------
# 🧬 Dependency Management (deptry)
# --------------------------------------------------
DEPTRY := $(ACTIVATE) && deptry
# --------------------------------------------------
# 🛡️ Security Audit (pip-audit)
# --------------------------------------------------
PIPAUDIT :=	$(ACTIVATE) && pip-audit
# --------------------------------------------------
# 🎨 Formatting (black)
# --------------------------------------------------
BLACK := $(PYTHON) -m black
YAMLFIXER := yamlfixer
# --------------------------------------------------
# 🔍 Linting (ruff, yaml)
# --------------------------------------------------
ANSIBLE_LINT := $(ACTIVATE) && pre-commit run ansible-lint --all-files --hook-stage manual
RUFF := $(PYTHON) -m ruff
TOMLLINT := tomllint
YAMLLINT := $(PYTHON) -m yamllint
# --------------------------------------------------
# 🎓 Spellchecker (codespell)
# --------------------------------------------------
CODESPELL := $(ACTIVATE) && codespell
# --------------------------------------------------
# 🧠 Typing (mypy)
# --------------------------------------------------
MYPY := $(PYTHON) -m mypy
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
PYTEST := $(PYTHON) -m pytest
# --------------------------------------------------
# 📚 Documentation (Sphinx + Autodoc + Jekyll)
# --------------------------------------------------
SPHINX := $(PYTHON) -m sphinx -b markdown
AUTODOC := $(ACTIVATE) && ansible-autodoc
JEKYLL_BUILD := bundle exec jekyll build --quiet
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
BUMPVERSION := bump-my-version bump --verbose
# Patch types:
MAJOR := major
MINOR := minor
PATCH := patch
# --------------------------------------------------
# 📜 Changelog generation (antsichaut + antsibull-changelog)
# --------------------------------------------------
ANTSICHAUT := $(ACTIVATE) && antsichaut
ANTSIBULL_CHANGELOG := $(ACTIVATE) && antsibull-changelog
# --------------------------------------------------
# 🐙 Github Tools (git, gh)
# --------------------------------------------------
GIT := git
GITHUB := gh
# Commands:
GIT_INIT_STATUS := git rev-parse --is-inside-work-tree > /dev/null 2>&1
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
PRECOMMIT := $(ACTIVATE) && pre-commit
# --------------------------------------------------
# 🪐 Ansible Galaxy
# --------------------------------------------------
ANSIBLE_GALAXY := $(ACTIVATE) && ansible-galaxy
GALAXY_IMPORTER := $(PYTHON) -m galaxy_importer.main
# --------------------------------------------------
# 🏃‍♂️ Nutri-Matic Commands
# --------------------------------------------------
NUTRIMATIC := $(PYTHON) -m nutrimatic
# --------------------------------------------------
# 🩹 Hacks
# --------------------------------------------------
AUTODOC_FIX := sed -i 's|yaml.load(yaml_file)|yaml.load(yaml_file, Loader=yaml.SafeLoader)|' \
	$(VENV_DIR)/lib/$(PYTHON_CMD)/site-packages/ansibleautodoc/Annotation.py
# --------------------------------------------------
# Functions
# --------------------------------------------------
# (Add functions here)
# --------------------------------------------------
.PHONY: all list-python-folders autodoc-hack venv python-install pre-commit-init security \
	dependency-check black-formatter-check black-formatter-fix format-check \
	format-fix ruff-lint-check ruff-lint-fix toml-lint-check yaml-lint-check \
	ansible-lint-check lint-check lint-fix spellcheck typecheck test sphinx \
	autodocs-front-matter autodoc jekyll readme build-docs jekyll-serve run-docs \
	bump-version-patch changelog git-init git-release galaxy-build galaxy-install \
	galaxy-publish clean version help
# --------------------------------------------------
# Default: run lint, typecheck, tests, and docs
# --------------------------------------------------
all: python-install lint-check typecheck spellcheck test build-docs
# --------------------------------------------------
# Utilities
# --------------------------------------------------
list-python-folders:
	$(AT)printf "\
	🐍 Python Source Paths: 📁\n\
	🔌 Plugins: $(PLUGINS_DIR)\n\
	🧪 Test: $(TESTS_DIR)\n"
# --------------------------------------------------
# 🩹 Hacks (ansible-autodoc)
# --------------------------------------------------
autodoc-hack:
	$(AT)echo "🩹 Applying YAML loader hack for ansible-autodoc..."
	$(AT)$(AUTODOC_FIX)
	$(AT)echo "✅ YAML loader hack for ansible-autodoc complete!"
# --------------------------------------------------
# Dependency Checks
# --------------------------------------------------
git-dependency-check:
	$(AT)which $(GIT) >/dev/null || \
		{ echo "Git is required: sudo apt install git"; exit 1; }

gh-dependency-check:
	$(AT)which $(GITHUB) >/dev/null || \
		{ echo "GitHub is required: sudo apt install gh"; exit 1; }
# --------------------------------------------------
# 🐍 Virtual Environment Setup
# --------------------------------------------------
venv:
	$(AT)echo "🐍 Creating virtual environment..."
	$(AT)$(CREATE_VENV)
	$(AT)echo "✅ Virtual environment created."

python-install: venv
	$(AT)echo "📦 Installing project dependencies..."
	$(AT)$(PIP) install --upgrade pip setuptools wheel
	$(AT)$(PIP) install -e $(DEV_DEPS)
	$(AT)$(PIP) install -e $(DEV_TOOLS)
	$(AT)$(PIP) install -e $(DEV_DOCS)
	$(AT)echo "✅ Dependencies installed."
	$(AT)$(MAKE) autodoc-hack
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
pre-commit-init: git-dependency-check
	$(AT)echo "📦 Installing pre-commit hooks and hook-types..."
	$(AT)$(PRECOMMIT) install --install-hooks
	$(AT)$(PRECOMMIT) install --hook-type pre-commit --hook-type commit-msg
	$(AT)echo "✅ pre-commit dependencies installed!"
# --------------------------------------------------
# 🍪 Project Updater (cookiecutter_project_upgrader)
# --------------------------------------------------
project-upgrade:
	$(AT)echo "🍪 Upgrading project from initial cookiecutter template..."
	$(AT)$(PROJECT_UPGRADE) --context-file ./docs/cookiecutter_input.json --upgrade-branch main
	$(AT)echo "✅ Finished project upgrade!"
# --------------------------------------------------
# 🛡️ Security (pip-audit)
# --------------------------------------------------
security:
	$(AT)echo "🛡️ Running security audit..."
	$(AT)$(call run_ci_safe, $(PIPAUDIT))
	$(AT)echo "✅ Finished security audit!"
# --------------------------------------------------
# 🧬 Dependency Management (deptry)
# --------------------------------------------------
dependency-check:
	$(AT)echo "🧬 Checking dependency issues..."
	$(AT)$(DEPTRY) --pep621-dev-dependency-groups dev,tools,docs \
		 $(SRC_DIR)
	$(AT)echo "✅ Finished checking for dependency issues!"
# --------------------------------------------------
# 🎨 Formatting (black, ruff)
# --------------------------------------------------
black-formatter-check:
	$(AT)echo "🔍 Running black formatter style check..."
	$(AT)$(call run_ci_safe, $(BLACK) --check $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Finished formatting check of Python code with Black!"

black-formatter-fix:
	$(AT)echo "🎨 Running black formatter fixes..."
	$(AT)$(BLACK) $(SRC_DIR) $(TESTS_DIR)
	$(AT)echo "✅ Finished formatting Python code with Black!"

format-check: black-formatter-check
format-fix: black-formatter-fix
# --------------------------------------------------
# 🔍 Linting (ansible, ruff, toml, yaml)
# --------------------------------------------------
ansible-lint-check:
	$(AT)echo "🔍 Running ansible-lint..."
	$(AT)$(call run_ci_safe, $(ANSIBLE_LINT))
	$(AT)echo "✅ Finished linting check with ansible-lint!"

ruff-lint-check:
	$(AT)echo "🔍 Running ruff linting..."
	$(AT)$(MAKE) list-python-folders
	$(AT)$(RUFF) check $(SRC_DIR) $(TESTS_DIR)
	$(AT)echo "✅ Finished linting check of Python code with Ruff!"

ruff-lint-fix:
	$(AT)echo "🎨 Running ruff lint fixes..."
	$(AT)$(RUFF) check --fix --show-files $(SRC_DIR) $(TESTS_DIR)
	$(AT)echo "✅ Finished linting Python code with Ruff!"
{% raw %}
toml-lint-check:
	$(AT)echo "🔍 Running Tomllint..."
	$(AT)$(ACTIVATE) && \
		find $(PROJECT_ROOT) -name "*.toml" \
			! -path "$(VENV_DIR)/*" \
			-print0 | xargs -0 -n 1 $(TOMLLINT)
	$(AT)echo "✅ Finished linting check of toml configuration files with Tomllint!"
{% endraw %}
yaml-lint-check:
	$(AT)echo "🔍 Running yamllint..."
	$(AT)$(YAMLLINT) .
	$(AT)echo "✅ Finished linting check of yaml files with yamllint!"

yaml-formatter-fix:
	$(AT)echo "🎨 Running yamlfixer lint fixes..."
	$(AT)$(ACTIVATE) && \
		find $(PROJECT_ROOT) -type f \
			\( -name "*.yaml" -o -name "*.yml" \) \
			! -path "*$(VENV_DIR)/*" \
			-print0 | xargs -0 $(YAMLFIXER) --config-file .yamllint --nochange --summary
	$(AT)echo "✅ Finished linting fix of yaml files with yamllint!"

lint-check: ansible-lint-check ruff-lint-check toml-lint-check yaml-lint-check
lint-fix: ruff-lint-fix
# --------------------------------------------------
# 🎓 Spellchecker (codespell)
# --------------------------------------------------
spellcheck:
	$(AT)echo "🎓 Checking Spelling (codespell)..."
	$(AT)$(call run_ci_safe, $(CODESPELL))
	$(AT)echo "✅ Finished spellcheck!"
# --------------------------------------------------
# 🧠 Typechecking (MyPy)
# --------------------------------------------------
typecheck:
	$(AT)echo "🧠 Checking types (MyPy)..."
	$(AT)$(MAKE) list-python-folders
	$(AT)$(call run_ci_safe, $(MYPY) '.')
	$(AT)echo "✅ Python typecheck complete!"
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
test:
	$(AT)echo "🧪 Running tests with pytest..."
	$(AT)$(call run_ci_safe, $(PYTEST) --suppress-no-test-exit-code)
	$(AT)echo "✅ Python tests complete!"
# --------------------------------------------------
# 📚 Documentation (Sphinx + Ansible Autodoc + Jekyll)
# --------------------------------------------------
sphinx:
	$(ACTIVATE) && $(MAKE) -C $(SPHINX_DIR) all PUBLISHDIR=$(JEKYLL_SPHINX_DIR)

autodocs-front-matter:
	$(AT)echo "📝 Adding YAML front matter to generated files in $(JEKYLL_AUTODOC_DIR)..."
	$(AT)$(NUTRIMATIC) build add-yaml-front-matter $(JEKYLL_AUTODOC_DIR) --project $(GALAXY_PACKAGE_NAME)
	$(AT)echo "✅ Adding YAML front matter to Ansible autodoc files complete!"

autodoc:
	$(AT)echo "🔨 Building Ansible autodoc documentation..."
	$(AT)$(AUTODOC) $(GALAXY_PATH) -o $(JEKYLL_AUTODOC_DIR)
	$(AT)mv $(JEKYLL_AUTODOC_DIR)/README.md $(AUTODOC_README_FILE)
	$(AT)echo "✅ Ansible autodoc documentation generated at $(JEKYLL_AUTODOC_DIR)"
	$(AT)$(MAKE) autodocs-front-matter

jekyll:
	$(MAKE) -C $(JEKYLL_DIR) build;

jekyll-serve:
	$(MAKE) -C $(JEKYLL_DIR) run;

readme:
	$(AT)$(NUTRIMATIC) build readme $(JEKYLL_DIR) $(README_FILE) \
		--tmp-dir $(README_GEN_DIR) --jekyll-cmd '$(JEKYLL_BUILD)'

build-docs: sphinx autodoc jekyll readme
	$(AT)$(GIT) add $(DOCS_DIR)
	$(AT)$(GIT) add $(README_FILE)

run-docs: jekyll-serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
bump-version-patch:
	$(AT)echo "🔖 Updating $(GALAXY_PACKAGE_NAME) version from $(GALAXY_VERSION)..."
	$(AT)$(BUMPVERSION) $(PATCH)
	$(AT)echo "✅ $(GALAXY_PACKAGE_NAME) version update complete!"
# --------------------------------------------------
# 📜 Changelog generation (antsichaut + antsibull-changelog)
# --------------------------------------------------
# Run antsichaut, relying on the environment variable GITHUB_TOKEN being present
# when the shell command executes.
# --------------------------------------------------
# Note: Run as part of pre-commit.  No manual run needed.
changelog:
	$(AT)echo "📜 $(GALAXY_PACKAGE_NAME) Changelog Generation..."
	$(AT)$(ANTSIBULL_CHANGELOG) release
	$(AT)echo "✅ Finished Changelog Release!"

update-changelog:
	$(AT)echo "📜 $(GALAXY_PACKAGE_NAME) Changelog Fragment Generation..."
	$(AT)$(ANTSICHAUT) \
  		--github_token $(GITHUB_TOKEN) \
  		--repository $(GITHUB_REPO) \
		--since_version $(PREVIOUS_VERSION) \
		--to_version $(CURRENT_VERSION) \
	$(AT)echo "✅ Finished Changelog Fragment Generation..."

changelog-release: update-changelog
	$(AT)echo Finalize the release (e.g., generate the final RST/MD file)
	$(AT)$(ANTSIBULL_CHANGELOG) generate
	$(AT)echo "✅ Finished Changelog Update for Release"
# --------------------------------------------------
# 🐙 Github Commands (git)
# --------------------------------------------------
git-init: git-dependency-check
	$(AT)if ! $(GIT_INIT_STATUS); then \
		echo "🌱 $(GALAXY_PACKAGE_NAME) Git initialization! 🎉"; \
		$(GIT) init; \
		$(GIT) add --all; \
		$(GIT) commit -m "chore(init): Init commit. \
			Project $(GALAXY_PACKAGE_NAME) template generation complete."; \
		echo "✅ Finished Git initialization!"; \
	else \
		echo "ℹ️ Git is already initialized for $(GALAXY_PACKAGE_NAME)."; \
	fi

git-release: git-dependency-check gh-dependency-check
	$(AT)if $(GIT_INIT_STATUS); then \
		echo "📦 $(GALAXY_PACKAGE_NAME) Release Tag - $(GALAXY_RELEASE)! 🎉"; \
		$(GIT) tag -a $(GALAXY_RELEASE) -m "Release $(GALAXY_RELEASE)"; \
		$(GIT) push origin $(GALAXY_RELEASE); \
		$(GITHUB) release create $(REGALAXY_RELEASELEASE) --generate-notes; \
		echo "✅ Finished uploading Release - $(GALAXY_RELEASE)!"; \
	else \
		echo "❌ Git is not yet initialized.  Skipping version release."; \
	fi
# --------------------------------------------------
# 🪐 Ansible Galaxy Commands (ansible-galaxy)
# --------------------------------------------------
galaxy-build:
	$(AT)echo "🔨 Building Ansible Galaxy collection... 🪐"
	$(AT)$(ANSIBLE_GALAXY) collection build $(GALAXY_PATH) --force
	$(AT)echo "✅ Build complete."

galaxy-install:
	$(AT)echo "📦 Installing local Ansible Galaxy collection... 🪐"
	$(AT)$(ANSIBLE_GALAXY) collection install $(TARBALL) --pre --force
	$(AT)echo "✅ Installed."

galaxy-publish:
	$(AT)echo "🚀 Publishing collection to Ansible Galaxy... 🪐"
	$(AT)$(ANSIBLE_GALAXY) collection publish $(TARBALL)
	$(AT)echo "✅ Published."

galaxy-import:
	$(GALAXY_IMPORTER) $(TARBALL)
# --------------------------------------------------
# 📢 Release
# --------------------------------------------------
pre-commit: test security dependency-check format-fix lint-check spellcheck typecheck
pre-release: clean python-install pre-commit build-docs changelog galaxy-build
release: git-release bump-version-patch
# --------------------------------------------------
# 🧹 Clean artifacts
# --------------------------------------------------
clean-docs:
	$(AT)echo "🧹 Cleaning documentation artifacts..."
	$(AT)rm -rf $(JEKYLL_SPHINX_DIR) $(JEKYLL_AUTODOC_DIR)
	$(AT)$(MAKE) -C $(JEKYLL_DIR) clean
	$(AT)$(MAKE) -C $(SPHINX_DIR) clean
	$(AT)echo "✅ Cleaned documentation artifacts..."

clean-build:
	$(AT)echo "🧹 Cleaning build artifacts..."
	$(AT)rm -rf build dist *.egg-info
	$(AT)find $(SRC_DIR) $(TESTS_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	$(AT)-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	$(AT)rm -f $(TARBALL)
	$(AT)@echo "✅ Cleaned build artifacts."

clean-tests:
	$(AT)echo "🧹 Cleaning test artifacts..."
	$(AT)rm -f importer_result.json
	$(AT)@echo "✅ Cleaned test artifacts."

clean: clean-docs clean-build clean-tests
# --------------------------------------------------
# Version
# --------------------------------------------------
version:
	$(AT)echo "$(GALAXY_PACKAGE_NAME)"
	$(AT)echo "author: $(GALAXY_AUTHOR)"
	$(AT)echo "version: $(GALAXY_VERSION)"
# --------------------------------------------------
# ❓ Help
# --------------------------------------------------
help:
	$(AT)echo "📦 $(GALAXY_PACKAGE_NAME) Makefile"
	$(AT)echo ""
	$(AT)echo "Usage:"
	$(AT)echo "  make venv                   Create virtual environment"
	$(AT)echo "  make python-install                Install dependencies"
	$(AT)echo "  make black-formatter-check  Run Black formatter check"
	$(AT)echo "  make black-formatter-fix    Run Black formatter"
	$(AT)echo "  make ruff-lint-check        Run Ruff linter"
	$(AT)echo "  make ruff-lint-fix          Auto-fix lint issues with python ruff"
	$(AT)echo "  make format-check           Run all project formatter checks (black)"
	$(AT)echo "  make format-fix             Run all project formatter autofixes (black)"
	$(AT)echo "  make yaml-lint-check        Run YAML linter"
	$(AT)echo "  make ansible-lint-check     Run Ansible linter"
	$(AT)echo "  make lint-check             Run all project linters (ruff, yaml, & ansible)"
	$(AT)echo "  make lint-fix               Run all project linter autofixes (ruff)"
	$(AT)echo "  make typecheck              Run Mypy type checking"
	$(AT)echo "  make test                   Run Pytest suite"
	$(AT)echo "  make sphinx                 Generate Sphinx Documentation"
	$(AT)echo "  make autodoc                Generate Ansible Autodoc Documentation"
	$(AT)echo "  make jekyll                 Generate Jekyll Documentation"
	$(AT)echo "  make readme                 Uses Jekyll $(JEKYLL_DIR)/README.md for readme generation"
	$(AT)echo "  make build-docs             Build Sphinx + Autodoc + Jekyll documentation + readme"
	$(AT)echo "  make run-docs               Serve Jekyll site locally"
	$(AT)echo "  make galaxy-build           Build Ansible Galaxy collection"
	$(AT)echo "  make galaxy-install         Install local Galaxy build"
	$(AT)echo "  make galaxy-publish         Publish collection to Ansible Galaxy"
	$(AT)echo "  make clean                  Clean build artifacts"
	$(AT)echo "  make all                    Run lint, typecheck, test, build-docs, & readme"
	$(AT)echo "Options:"
	$(AT)echo "  V=1             Enable verbose output (show all commands being executed)"
	$(AT)echo "  make -s         Run completely silently (suppress make's own output AND command echo)"
