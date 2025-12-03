# Makefile for {{ cookiecutter.package_name }}
# =========================================
# Project: {{ cookiecutter.project_name }}
# =========================================

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

# Define a reusable CI-safe runner
define run_ci_safe =
( $1 || [ "$(CI)" != "1" ] )
endef
# --------------------------------------------------
# ⚙️ Build Settings
# --------------------------------------------------
GALAXY_PACKAGE_NAME = {{ cookiecutter.package_name }}
GALAXY_NAMESPACE := {{ cookiecutter.namespace }}
GALAXY_COLLECTION := {{ cookiecutter.project_name }}
GALAXY_AUTHOR := {{ cookiecutter.author }}
GALAXY_VERSION := {{ cookiecutter.version }}
GALAXY_PATH := $(PROJECT_ROOT)
# --------------------------------------------------
# 📁 Build Directories
# --------------------------------------------------
LIBRARY_DIR := $(PROJECT_ROOT)/library
PLAYBOOKS_DIR := $(PROJECT_ROOT)/playbooks
PLUGINS_DIR := $(PROJECT_ROOT)/plugins
ROLES_DIR := $(PROJECT_ROOT)/roles
SRC_DIR := $(PLUGINS_DIR) $(LIBRARY_DIR)
TESTS_DIR := $(PROJECT_ROOT)/tests
DOCS_DIR := $(PROJECT_ROOT)/docs
SPHINX_DIR := $(DOCS_DIR)/sphinx
JEKYLL_DIR := $(DOCS_DIR)/jekyll
JEKYLL_SPHINX_DIR := $(JEKYLL_DIR)/sphinx
JEKYLL_AUTODOC_DIR := $(JEKYLL_DIR)/ansible-docs
README_GEN_DIR := $(JEKYLL_DIR)/tmp_readme
CHANGELOG_DIR := $(PROJECT_ROOT)/changelogs
CHANGELOG_RELEASE_DIR = $(CHANGELOG_DIR)/releases
# --------------------------------------------------
# 📄 Build Files
# --------------------------------------------------
README_FILE = $(PROJECT_ROOT)/README.md
CHANGELOG_FILE = $(CHANGELOG_DIR)/changelog.yml
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
# --------------------------------------------------
# 🔍 Linting (ruff, yaml)
# --------------------------------------------------
ANSIBLE_LINT := $(ACTIVATE) && ansible-lint
RUFF := $(PYTHON) -m ruff
TOMLLINT := $(ACTIVATE) && tomllint
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
# 📜 Changelog generation (git-clif)
# --------------------------------------------------
GITCLIFF := git cliff
# --------------------------------------------------
# 🐙 Github Tools (git)
# --------------------------------------------------
GIT := git
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
PRECOMMIT := $(ACTIVATE) && pre-commit
# --------------------------------------------------
# 🪐 Ansible Galaxy
# --------------------------------------------------
ANSIBLE_GALAXY := $(ACTIVATE) && ansible-galaxy
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
.PHONY: all list-folders autodoc-hack venv install black-formatter-check \
	black-formatter-fix format-check format-fix ruff-lint-check ruff-lint-fix \
	yaml-lint-check ansible-lint-check lint-check lint-fix typecheck test sphinx \
	autodocs-front-matter autodoc jekyll readme build-docs jekyll-serve run-docs \
	galaxy-build galaxy-install galaxy-publish clean help
# --------------------------------------------------
# Default: run lint, typecheck, tests, and docs
# --------------------------------------------------
all: install lint-check typecheck test build-docs
# --------------------------------------------------
# Utilities
# --------------------------------------------------
list-folders:
	$(AT)printf "\
	     Python Source Paths:\n\
	     Plugins: $(PLUGINS_DIR)\n\
	     Libraries: $(LIBRARY_DIR)\n\
	     Test: $(TESTS_DIR)\n"
# --------------------------------------------------
# 🩹 Hacks (ansible-autodoc)
# --------------------------------------------------
autodoc-hack:
	$(AT)echo "🩹 Applying YAML loader hack for ansible-autodoc..."
	$(AT)$(AUTODOC_FIX)
	$(AT)echo "✅ YAML loader hack for ansible-autodoc complete!"
# --------------------------------------------------
# 🐍 Virtual Environment Setup
# --------------------------------------------------
venv:
	$(AT)echo "🐍 Creating virtual environment..."
	$(AT)$(CREATE_VENV)
	$(AT)echo "✅ Virtual environment created."

install: venv
	$(AT)echo "📦 Installing project dependencies..."
	$(AT)$(PIP) install --upgrade pip
	$(AT)$(PIP) install -e $(DEV_DEPS)
	$(AT)$(PIP) install -e $(DEV_TOOLS)
	$(AT)$(PIP) install -e $(DEV_DOCS)
	$(AT)echo "✅ Dependencies installed."
	$(AT)$(MAKE) autodoc-hack
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
pre-commit-init:
	$(AT)echo "📦 Installing pre-commit hooks and hook-types..."
	$(AT)which $(GIT) >/dev/null || { $(AT)echo "Git is required"; exit 1; }
	$(AT)$(PRECOMMIT) install --install-hooks
	$(AT)$(PRECOMMIT) install --hook-type pre-commit --hook-type commit-msg
	$(AT)echo "✅ pre-commit dependencies installed!"
# --------------------------------------------------
# 🛡️ Security (pip-audit)
# --------------------------------------------------
security:
	$(AT)echo "🛡️ Running security audit..."
	$(AT)$(PIPAUDIT)
	$(AT)echo "✅ Finished security audit!"
# --------------------------------------------------
# 🧬 Dependency Management (deptry)
# --------------------------------------------------
dependency-check:
	$(AT)echo "🧬 Checking dependency issues..."
	$(AT)$(DEPTRY) --pep621-dev-dependency-groups dev,docs \
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
# 🔍 Linting (ruff, yaml, ansible)
# --------------------------------------------------
ruff-lint-check:
	$(AT)echo "🔍 Running ruff linting..."
	$(AT)$(MAKE) list-folders
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
			! -path "*{{*" \
			! -path "*}}*" \
			-print0 | xargs -0 $(TOMLLINT)
	$(AT)echo "✅ Finished linting check of toml configuration files with Tomllint!"
{% endraw %}

yaml-lint-check:
	$(AT)echo "🔍 Running yamllint..."
	$(AT)$(YAMLLINT) .
	$(AT)echo "✅ Finished linting check of yaml files with yamllint!"

ansible-lint-check:
	$(AT)echo "🔍 Running ansible-lint..."
	$(AT)$(ANSIBLE_LINT) ./**/*.yml

lint-check: ruff-lint-check toml-lint-check yaml-lint-check ansible-lint-check
lint-fix: ruff-lint-fix
# --------------------------------------------------
# 🎓 Spellchecker (codespell)
# --------------------------------------------------
spellcheck:
	$(AT)echo "🎓 Checking Spelling (codespell)..."
	$(AT)$(CODESPELL) $(SRC_DIR) $(TESTS_DIR) $(DOCS_DIR)
	$(AT)echo "✅ Finished spellcheck!"
# --------------------------------------------------
# 🧠 Typechecking (MyPy)
# --------------------------------------------------
typecheck:
	$(AT)echo "🧠 Checking types (MyPy)..."
	$(AT)$(MAKE) list-folders
	$(AT)$(call run_ci_safe, $(MYPY) $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Python typecheck complete!"
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
test:
	$(AT)echo "🧪 Running tests with pytest..."
	$(AT)$(call run_ci_safe, $(PYTEST) $(TESTS_DIR))
	$(AT)echo "✅ Python tests complete!"
# --------------------------------------------------
# 📚 Documentation (Sphinx + Ansible Autodoc + Jekyll)
# --------------------------------------------------
sphinx:
	$(MAKE) -C $(SPHINX_DIR) all PUBLISHDIR=$(JEKYLL_SPHINX_DIR)

autodocs-front-matter:
	$(AT)echo "📝 Adding YAML front matter to generated files in $(JEKYLL_AUTODOC_DIR)..."
	$(AT)$(NUTRIMATIC) build add-yaml-front-matter $(JEKYLL_AUTODOC_DIR) --project $(GALAXY_PACKAGE_NAME)
	$(AT)echo "✅ Adding YAML front matter to Ansible autodoc files complete!"

autodoc:
	$(AT)echo "🔨 Building Ansible autodoc documentation..."
	$(AT)$(AUTODOC) $(GALAXY_PATH) -o $(JEKYLL_AUTODOC_DIR)
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
run-docs: jekyll-serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
# TODO: Also create a git tag of current version.
bump-version-patch:
	$(AT)echo "🔖 Updating $(GALAXY_PACKAGE_NAME) version from $(GALAXY_VERSION)..."
	$(AT)$(BUMPVERSION) $(PATCH)
	$(AT)echo "✅ $(GALAXY_PACKAGE_NAME) version update complete!"
# --------------------------------------------------
# 📜 Changelog generation (git-cliff)
# --------------------------------------------------
changelog:
	$(AT)echo "📜 $(GALAXY_PACKAGE_NAME) Changelog Generation..."
# GIT_CLIFF_TEMPLATE=release_yaml
	$(GITCLIFF) \
	  --tag $(GALAXY_VERSION) \
	  --output $(CHANGELOG_RELEASE_DIR)/$(GALAXY_VERSION).yml

#	GIT_CLIFF_TEMPLATE=index_append $(GITCLIFF) \
	  --tag $(GALAXY_VERSION) \
	  --prepend $(CHANGELOG_DIR)/changelog.yml
	$(AT)echo "✅ Finished Changelog Update!"
# --------------------------------------------------
# 🐙 Github Commands (git)
# --------------------------------------------------
git-init:
	$(AT)echo "🌱 $(GALAXY_PACKAGE_NAME) Git initialization! 🎉"
	$(AT)$(GIT) init
	$(AT)echo "✅ Finished Git initialization!"

#NOTE: Not yet tested!!!
git-release: changelog
	$(AT)echo "📦 $(GALAXY_PACKAGE_NAME) Release Tag - $(GALAXY_VERSION)! 🎉"
	$(AT)$(GIT) tag -a v$(GALAXY_VERSION) -m "Release v$(GALAXY_VERSION)"
	$(AT)$(GIT) push origin v$(GALAXY_VERSION)
	$(AT)echo "✅ Finished uploading Release - $(GALAXY_VERSION)!"
# --------------------------------------------------
# 🪐 Ansible Galaxy Commands
# --------------------------------------------------
galaxy-build:
	$(AT)echo "🔨 Building Ansible Galaxy collection... 🪐"
	$(AT)$(ANSIBLE_GALAXY) collection build $(GALAXY_PATH)
	$(AT)echo "✅ Build complete."

galaxy-install:
	$(AT)echo "📦 Installing local Ansible Galaxy collection... 🪐"
	$(AT)$(ANSIBLE_GALAXY) collection install $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz --force
	$(AT)echo "✅ Installed."

galaxy-publish:
	$(AT)echo "🚀 Publishing collection to Ansible Galaxy... 🪐"
	$(AT)$(ANSIBLE_GALAXY) collection publish $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz
	$(AT)echo "✅ Published."
# --------------------------------------------------
# 🧹 Clean artifacts
# --------------------------------------------------
clean:
	$(AT)echo "🧹 Clening build artifacts..."
	$(AT)rm -rf $(SPHINX_DIR)/_build $(JEKYLL_SPHINX_DIR) $(JEKYLL_AUTODOC_DIR)
	$(AT)$(MAKE) -C $(JEKYLL_DIR) clean
	$(AT)$(MAKE) -C $(SPHINX_DIR) clean
	$(AT)rm -rf build dist *.egg-info
	$(AT)find $(SRC_DIR) $(TESTS_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	$(AT)-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	$(AT)rm -f $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz
	$(AT)@echo "🧹 Cleaned build artifacts."
# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	$(AT)echo "📦 $(GALAXY_PACKAGE_NAME) Makefile"
	$(AT)echo ""
	$(AT)echo "Usage:"
	$(AT)echo "  make venv                   Create virtual environment"
	$(AT)echo "  make install                Install dependencies"
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
