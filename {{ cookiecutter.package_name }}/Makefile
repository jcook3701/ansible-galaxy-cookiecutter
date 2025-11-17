# Makefile for {{ cookiecutter.package_name }}
# =========================================
# Project: {{ cookiecutter.project_name }}
# =========================================

# --------------------------------------------------
# ⚙️ Environment Settings
# --------------------------------------------------
SHELL := /bin/bash
.SHELLFLAGS := -O globstar -c
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
# --------------------------------------------------
# 📁 Build Directories
# --------------------------------------------------
LIBRARY_DIR := library
PLAYBOOKS_DIR := playbooks
PLUGINS_DIR := plugins
ROLES_DIR := roles
SRC_DIR := $(PLUGINS_DIR) $(LIBRARY_DIR)
TEST_DIR := tests

DOCS_DIR := docs
SPHINX_DIR := $(DOCS_DIR)/sphinx
JEKYLL_DIR := $(DOCS_DIR)/jekyll

SPHINX_BUILD_DIR := $(SPHINX_DIR)/_build/html
SPHINX_OUTPUT_DIR := $(JEKYLL_DIR)/sphinx
AUTODOC_OUTPUT_DIR := $(JEKYLL_DIR)/ansible-docs
README_GEN_DIR := $(JEKYLL_DIR)/tmp_readme
# --------------------------------------------------
# 🐍 Python / Virtual Environment
# --------------------------------------------------
PYTHON_CMD := python3.11
VENV_DIR := .venv
# --------------------------------------------------
# 🐍 Python Dependencies
# --------------------------------------------------
DEV_DEPS := .[dev]
DEV_LINT := .[lint]
DEV_DOCS := .[docs]
# --------------------------------------------------
# 🐍 Python Commands (venv, activate, pip)
# --------------------------------------------------
CREATE_VENV := $(PYTHON_CMD) -m venv $(VENV_DIR)
ACTIVATE := source $(VENV_DIR)/bin/activate
PYTHON := $(ACTIVATE) && $(PYTHON_CMD)
PIP := $(PYTHON) -m pip
# --------------------------------------------------
# 🧠 Typing (mypy)
# --------------------------------------------------
MYPY := $(PYTHON) -m mypy
# --------------------------------------------------
# 🔍 Linting (ruff, yaml)
# --------------------------------------------------
ANSIBLE_LINT := $(ACTIVATE) && ansible-lint
RUFF := $(PYTHON) -m ruff
YAMLLINT := $(PYTHON) -m yamllint
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
PYTEST := $(PYTHON) -m pytest
# --------------------------------------------------
# 📘 Documentation (Sphinx + Autodoc + Jekyll)
# --------------------------------------------------
SPHINX := $(PYTHON) -m sphinx -b markdown
AUTODOC := $(ACTIVATE) && ansible-autodoc
JEKYLL_BUILD := bundle exec jekyll build --quiet
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
# 🪐 Ansible Galaxy
# --------------------------------------------------
GALAXY_NAMESPACE := {{ cookiecutter.namespace }}
GALAXY_COLLECTION := {{ cookiecutter.project_name }}
GALAXY_PATH := .

ANSIBLE_GALAXY := $(ACTIVATE) && ansible-galaxy
# --------------------------------------------------
# 🐍 Build Utils
# --------------------------------------------------
YAML_FRONT_MATTER := $(PYTHON) -m build_utils.yaml_front_matter
# --------------------------------------------------
# 🩹 Hacks
# --------------------------------------------------
AUTODOC_FIX := sed -i 's|yaml.load(yaml_file)|yaml.load(yaml_file, Loader=yaml.SafeLoader)|' \
	$(VENV_DIR)/lib/$(PYTHON_CMD)/site-packages/ansibleautodoc/Annotation.py
# --------------------------------------------------
.PHONY: all autodoc-hack venv install ruff-formatter ruff-lint-check ruff-lint-fix yaml-lint-check \
	ansible-lint-check lint-check typecheck test sphinx autodocs-front-matter autodoc jekyll readme \
	build-docs jekyll-serve run-docs galaxy-build galaxy-install galaxy-publish clean help
# --------------------------------------------------
# Default: run lint, typecheck, tests, and docs
# --------------------------------------------------
all: install lint-check typecheck test build-docs
# --------------------------------------------------
# Hacks (ansible-autodoc)
# --------------------------------------------------
autodoc-hack:
	$(AT)echo "🩹 Applying YAML loader hack for ansible-autodoc..."
	$(AT)$(AUTODOC_FIX)
# --------------------------------------------------
# Virtual Environment Setup
# --------------------------------------------------
venv:
	$(AT)echo "🐍 Creating virtual environment..."
	$(AT)$(CREATE_VENV)
	$(AT)echo "✅ Virtual environment created."

install: venv
	$(AT)echo "📦 Installing project dependencies..."
	$(AT)$(PIP) install --upgrade pip
	$(AT)$(PIP) install -e $(DEV_DEPS)
	$(AT)$(PIP) install -e $(DEV_LINT)
	$(AT)$(PIP) install -e $(DEV_DOCS)
	$(AT)echo "✅ Dependencies installed."
	$(AT)$(MAKE) autodoc-hack
# --------------------------------------------------
# Formating (ruff)
# --------------------------------------------------
ruff-formatter:
	$(AT)echo "🎨 Running ruff formatter..."
	$(AT)$(RUFF) format $(SRC_DIR) $(TEST_DIR)
# --------------------------------------------------
# Linting (ruff, yaml, jinja2)
# --------------------------------------------------
ruff-lint-check:
	$(AT)echo "🔍 Running ruff linting..."
	$(AT)$(RUFF) check $(SRC_DIR) $(TEST_DIR)

ruff-lint-fix:
	$(AT)echo "🎨 Running ruff lint fixes..."
	$(AT)$(RUFF) check --fix --show-files $(SRC_DIR) $(TEST_DIR)

yaml-lint-check:
	$(AT)echo "🔍 Running yamllint..."
	$(AT)$(YAMLLINT) .

ansible-lint-check:
	$(AT)echo "🔍 Running ansible-lint..."
	$(AT)$(ANSIBLE_LINT) ./**/*.yml

lint-check: ruff-lint-check yaml-lint-check ansible-lint-check
# --------------------------------------------------
# Typechecking (MyPy)
# --------------------------------------------------
typecheck:
	$(AT)echo "🧠 Checking types (MyPy)..."
	$(AT)$(MYPY) $(SRC_DIR) $(TEST_DIR) || true
# --------------------------------------------------
# Testing (pytest)
# --------------------------------------------------
test:
	$(AT)echo "🧪 Running tests with pytest..."
	$(AT)$(PYTEST) -v --maxfail=1 --disable-warnings $(TEST_DIR) || true
# --------------------------------------------------
# Documentation (Sphinx + Ansible Autodoc + Jekyll)
# --------------------------------------------------
sphinx:
	$(AT)echo "🧹 Clening Sphinx build artifacts..."
	$(AT)rm -rf $(SPHINX_OUTPUT_DIR)
	$(AT)echo "🔨 Building Sphinx documentation 📘 as Markdown..."
	$(AT)$(SPHINX) $(SPHINX_DIR) $(SPHINX_OUTPUT_DIR)
	$(AT)echo "✅ Sphinx Markdown build complete!"

autodocs-front-matter:
	$(AT)echo "📝 Adding YAML front matter to generated files in $(AUTODOC_OUTPUT_DIR)..."
	$(AT)$(YAML_FRONT_MATTER) $(AUTODOC_OUTPUT_DIR)

autodoc:
	$(AT)echo "🔨 Building Ansible autodoc documentation..."
	$(AT)$(AUTODOC) $(GALAXY_PATH) -o $(AUTODOC_OUTPUT_DIR)
	$(AT)echo "✅ Ansible autodoc documentation generated at $(AUTODOC_OUTPUT_DIR)"
	# $(AT)$(MAKE) autodocs-front-matter

jekyll:
	$(AT)echo "🔨 Building Jekyll site..."
	$(AT)cd $(JEKYLL_DIR) && $(JEKYLL_BUILD)
	$(AT)echo "✅ Full documentation build complete!"

readme:
	$(AT)echo "🔨 Building ./README.md 📘 with Jekyll..."
	$(AT)mkdir -p $(README_GEN_DIR)
	$(AT)cp $(JEKYLL_DIR)/_config.yml $(README_GEN_DIR)/_config.yml
	$(AT)cp $(JEKYLL_DIR)/Gemfile $(README_GEN_DIR)/Gemfile
	$(AT)printf "%s\n" "---" \
		"layout: raw" \
		"permalink: /README.md" \
		"---" > $(README_GEN_DIR)/README.md
	$(AT)printf '%s\n' '<!--' \
		'  Auto-generated file. Do not edit directly.' \
		'  Edit $(JEKYLL_DIR)/README.md instead.' \
		'  Run ```make readme``` to regenrate this file' \
		'-->' >> $(README_GEN_DIR)/README.md
	$(AT)cat $(JEKYLL_DIR)/README.md >> $(README_GEN_DIR)/README.md
	$(AT)cd $(README_GEN_DIR) && $(JEKYLL_BUILD)
	$(AT)cp $(README_GEN_DIR)/_site/README.md ./README.md
	$(AT)echo "🧹 Clening README.md build artifacts..."
	$(AT)rm -r $(README_GEN_DIR)
	$(AT)echo "✅ README.md auto generation complete!"

build-docs: sphinx autodoc jekyll readme

jekyll-serve: docs
	$(AT)echo "🚀 Starting Jekyll development server..."
	$(AT)cd $(JEKYLL_DIR) && $(JEKYLL_SERVE)

run-docs: jekyll-serve
# --------------------------------------------------
# Ansible Galaxy Commands
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
# Clean artifacts
# --------------------------------------------------
clean:
	$(AT)echo "🧹 Clening build artifacts..."
	$(AT)rm -rf $(SPHINX_DIR)/_build $(SPHINX_OUTPUT_DIR) $(AUTODOC_OUTPUT_DIR)
	$(AT)cd $(JEKYLL_DIR) && $(JEKYLL_CLEAN)
	$(AT)rm -rf build dist *.egg-info
	$(AT)find $(SRC_DIR) $(TEST_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	$(AT)-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	$(AT)rm -f $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz
	$(AT)@echo "🧹 Cleaned build artifacts."
# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	$(AT)echo "📦 {{ cookiecutter.package_name }} Makefile"
	$(AT)echo ""
	$(AT)echo "Usage:"
	$(AT)echo "  make venv                   Create virtual environment"
	$(AT)echo "  make install                Install dependencies"
	$(AT)echo "  make ruff-formatter         Run Ruff Formatter"
	$(AT)echo "  make ruff-lint-check        Run Ruff linter"
	$(AT)echo "  make ruff-lint-fix          Auto-fix lint issues with python ruff"
	$(AT)echo "  make yaml-lint-check        Run YAML linter"
	$(AT)echo "  make ansible-lint-check     Run Ansible linter"
	$(AT)echo "  make lint-check             Run all project linters (ruff, yaml, & ansible)"
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
