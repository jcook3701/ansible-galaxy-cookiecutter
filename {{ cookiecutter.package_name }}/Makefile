# Makefile for jcook3701.homelab
# =========================================
# Project: homelab
# =========================================
SHELL := /bin/bash
.SHELLFLAGS := -O globstar -c

SRC_DIR := plugins
PLAYBOOKS_DIR := playbooks
ROLES_DIR := roles
TEST_DIR := tests

DOCS_DIR := docs
SPHINX_DIR := docs/sphinx
JEKYLL_DIR := docs/jekyll

SPHINX_BUILD_DIR := $(SPHINX_DIR)/_build/html
JEKYLL_OUTPUT_DIR := $(JEKYLL_DIR)/sphinx
AUTODOC_OUTPUT := $(SPHINX_DIR)/source/ansible-docs  # 🧩 autodoc output

# --------------------------------------------------
# Python / Virtual Environment
# --------------------------------------------------
PYTHON := python3.11
VENV_DIR := .venv
# --------------------------------------------------
# Python Dependencies
# --------------------------------------------------
DEPS := .
DEV_DEPS := .[dev]
DEV_DOCS := .[docs]
# --------------------------------------------------
# Python Commands
# --------------------------------------------------
CREATE_VENV := $(PYTHON) -m venv $(VENV_DIR)
ACTIVATE := source $(VENV_DIR)/bin/activate
PIP := $(ACTIVATE) && $(PYTHON) -m pip
# --------------------------------------------------
# Typing
# --------------------------------------------------
MYPY := $(ACTIVATE) && $(PYTHON) -m mypy
# --------------------------------------------------
# Linting
# --------------------------------------------------
ANSIBLE_LINT := $(ACTIVATE) && ansible-lint
RUFF := $(ACTIVATE) && $(PYTHON) -m ruff
YAMLLINT := $(ACTIVATE) && $(PYTHON) -m yamllint
# --------------------------------------------------
# Testing
# --------------------------------------------------
PYTEST := $(ACTIVATE) && $(PYTHON) -m pytest
# --------------------------------------------------
# Documentation
# --------------------------------------------------
SPHINX := $(ACTIVATE) && $(PYTHON) -m sphinx -b markdown
AUTODOC := $(ACTIVATE) && ansible-autodoc
# --------------------------------------------------
# Jekyll
# --------------------------------------------------
JEKYLL_BUILD := bundle exec jekyll build
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
# Ansible Galaxy
# --------------------------------------------------
GALAXY_NAMESPACE := jcook
GALAXY_COLLECTION := homelab
GALAXY_PATH := .

ANSIBLE_GALAXY := $(ACTIVATE) && ansible-galaxy

# --------------------------------------------------
.PHONY: all venv install ruff-lint-check ruff-lint-fix yaml-lint-check \
	ansible-lint-check lint-check typecheck test docs autodoc \
	jekyll-serve galaxy-build galaxy-install galaxy-publish clean help

# --------------------------------------------------
# Default: run lint, typecheck, tests, and docs
# --------------------------------------------------
all: install ruff-lint-check typecheck test docs

# --------------------------------------------------
# Virtual Environment Setup
# --------------------------------------------------
venv:
	@echo "🐍 Creating virtual environment..."
	$(CREATE_VENV)
	@echo "✅ Virtual environment created."

install: venv
	@echo "📦 Installing project dependencies..."
	$(PIP) install --upgrade pip
	$(PIP) install -e $(DEPS)
	$(PIP) install -e $(DEV_DEPS)
	$(PIP) install -e $(DEV_DOCS)
	@echo "✅ Dependencies installed."

# --------------------------------------------------
# Linting / Typechecking / Testing
# --------------------------------------------------
ruff-lint-check:
	@echo "🔍 Running ruff linting..."
	$(RUFF) check $(SRC_DIR) $(TEST_DIR)

ruff-lint-fix:
	@echo "🔍 Running ruff lint fixes..."
	$(RUFF) check --fix --show-files $(SRC_DIR) $(TEST_DIR)

yaml-lint-check:
	@echo "🔍 Running yamllint..."
	$(YAMLLINT) .

ansible-lint-check:
	@echo "🔍 Running ansible-lint..."
	$(ANSIBLE_LINT) ./**/*.yml

lint-check: ruff-lint-check yaml-lint-check ansible-lint-check

typecheck: install
	$(MYPY) $(SRC_DIR)

test: install
	$(PYTEST) -v --maxfail=1 --disable-warnings $(TEST_DIR)

# --------------------------------------------------
# Ansible Autodoc
# --------------------------------------------------
autodoc: install
	@echo "🧠 Generating Ansible autodoc documentation..."
	$(AUTODOC) $(GALAXY_PATH) --output $(AUTODOC_OUTPUT)
	@echo "✅ Ansible autodoc documentation generated at $(AUTODOC_OUTPUT)"

# --------------------------------------------------
# Documentation (Sphinx + Jekyll)
# --------------------------------------------------
docs: autodoc
	@echo "📘 Building Sphinx documentation as Markdown..."
	$(SPHINX) $(SPHINX_DIR) $(JEKYLL_OUTPUT_DIR)
	@echo "✅ Sphinx Markdown build complete!"
	@echo "🧱 Building Jekyll site..."
	cd $(JEKYLL_DIR) && $(JEKYLL_BUILD)
	@echo "✅ Full documentation build complete!"

jekyll-serve: docs
	@echo "🚀 Starting Jekyll development server..."
	cd $(JEKYLL_DIR) && $(JEKYLL_SERVE)

# --------------------------------------------------
# Ansible Galaxy Commands
# --------------------------------------------------
galaxy-build:
	@echo "📦 Building Ansible Galaxy collection..."
	$(ANSIBLE_GALAXY) collection build $(GALAXY_PATH)
	@echo "✅ Build complete."

galaxy-install:
	@echo "🧰 Installing local Ansible Galaxy collection..."
	$(ANSIBLE_GALAXY) collection install $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz --force
	@echo "✅ Installed."

galaxy-publish:
	@echo "🚀 Publishing collection to Ansible Galaxy..."
	$(ANSIBLE_GALAXY) collection publish $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz
	@echo "✅ Published."

# --------------------------------------------------
# Clean artifacts
# --------------------------------------------------
clean:
	rm -rf $(SPHINX_DIR)/_build $(JEKYLL_OUTPUT_DIR) $(AUTODOC_OUTPUT)
	cd $(JEKYLL_DIR) && $(JEKYLL_CLEAN)
	rm -rf build dist *.egg-info
	find $(SRC_DIR) $(TEST_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	rm -f $(GALAXY_NAMESPACE)-$(GALAXY_COLLECTION)-*.tar.gz
	@echo "🧹 Cleaned build artifacts."

# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	@echo "📦 homelab Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make venv                   Create virtual environment"
	@echo "  make install                Install dependencies"
	@echo "  make ruff-lint-check        Run Ruff linter"
	@echo "  make ruff-lint-fix          Auto-fix lint issues with python ruff"
	@echo "  make yaml-lint-check        Run YAML linter"
	@echo "  make ansible-lint-check     Run Ansible linter"
	@echo "  make lint-check             Run all project linters (ruff, yaml, & ansible)"
	@echo "  make typecheck              Run Mypy type checking"
	@echo "  make test                   Run Pytest suite"
	@echo "  make autodoc                Generate Ansible autodoc Markdown"
	@echo "  make docs                   Build Sphinx + Jekyll documentation"
	@echo "  make jekyll-serve           Serve Jekyll site locally"
	@echo "  make ansible-lint-check     Run ansible-lint"
	@echo "  make galaxy-build           Build Ansible Galaxy collection"
	@echo "  make galaxy-install         Install local Galaxy build"
	@echo "  make galaxy-publish         Publish collection to Ansible Galaxy"
	@echo "  make clean                  Clean build artifacts"
	@echo "  make all                    Run lint, typecheck, test, autodoc, and docs"
