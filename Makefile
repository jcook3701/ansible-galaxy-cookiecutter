# Makefile for ansible-galaxy-cookiecutter
#
# Copyright (c) 2026, Jared Cook
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <www.gnu.org>.
#
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
# Detect if we are running inside GitHub Actions CI.
# GitHub sets the environment variable GITHUB_ACTIONS=true in workflows.
# We set CI=1 if running in GitHub Actions, otherwise CI=0 for local runs.
ifeq ($(GITHUB_ACTIONS),true)
CI := 1
else
CI := 0
endif
# Detect if we are running inside Cookiecutter (pre/post) hooks.
# Cookiecutter hooks are used to set the environment variable COOKIECUTTER_HOOKS=true.
# We set CC=1 if running in Cookiecutter hooks, otherwise CC=0 for standard runs.
COOKIECUTTER_RENDER_DIR := /tmp/rendered
ifeq ($(COOKIECUTTER_HOOKS),true)
CC := 1
else
CC := 0
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
# cc_or_std:
#   Selects between Cookiecutter hook context and standard execution context.
#
#   If COOKIECUTTER_HOOKS=true, expands to the first argument (Cookiecutter render).
#   Otherwise, expands to the second argument (normal project execution).
#
#   Usage:
#     PROJECT_ROOT := $(call cc_or_std,$(COOKIECUTTER_RENDER_DIR),$(PWD))
cc_or_std = $(if $(filter true,$(COOKIECUTTER_HOOKS)),$(1),$(2))
# --------------------------------------------------
# ⚙️ Build Settings
# --------------------------------------------------
PROJECT_NAME := "ansible-galaxy-cookiecutter"
AUTHOR := "Jared Cook"
VERSION := 0.1.1
RELEASE := v$(VERSION)
# --------------------------------------------------
# 🐙 Github Build Settings
# --------------------------------------------------
GITHUB_USER := "jcook3701"
GITHUB_REPO := $(GITHUB_USER)/$(PROJECT_NAME)
# --------------------------------------------------
# 📁 Build Directories
# --------------------------------------------------
PROJECT_ROOT := $(call cc_or_std,$(CURDIR),$(PWD))
HOOKS_DIR := $(PROJECT_ROOT)/hooks
SRC_DIR := $(HOOKS_DIR)
TEST_DIR := $(PROJECT_ROOT)/tests
TESTS_DIR := $(TEST_DIR)
DOCS_DIR := $(PROJECT_ROOT)/docs
JEKYLL_DIR := $(DOCS_DIR)/jekyll
README_GEN_DIR := $(JEKYLL_DIR)/tmp_readme
CHANGELOG_DIR := $(PROJECT_ROOT)/changelogs
CHANGELOG_RELEASE_DIR := $(CHANGELOG_DIR)/releases
# --------------------------------------------------
# 📄 Build Files
# --------------------------------------------------
README_FILE := $(PROJECT_ROOT)/README.md
CHANGELOG_FILE := $(CHANGELOG_DIR)/CHANGELOG.md
CHANGELOG_RELEASE_FILE := $(CHANGELOG_RELEASE_DIR)/$(RELEASE).md
# --------------------------------------------------
# 🍪 Template Directories (cookiecutter)
# --------------------------------------------------
COOKIE_DIR := $(PROJECT_ROOT)/{{ cookiecutter.project_slug }}
COOKIE_MACRO_DIR := $(COOKIE_DIR)/.cookiecutter_includes
RENDERED_COOKIE_DIR := /tmp/rendered
RENDERED_VENV_DIR := $(RENDERED_COOKIE_DIR)/**/.venv
# --------------------------------------------------
# 🐍 Python / Virtual Environment
# --------------------------------------------------
PYTHON_CMD := python3.11
VENV_DIR := $(PROJECT_ROOT)/.venv
# --------------------------------------------------
# 🐍 Python Dependencies
# --------------------------------------------------
DEPS := .
DEV_DEPS := .[dev]
DEV_DOCS := .[docs]
# --------------------------------------------------
# 🐍 Python Commands
# --------------------------------------------------
CREATE_VENV := $(PYTHON_CMD) -m venv $(VENV_DIR)
ACTIVATE := source $(VENV_DIR)/bin/activate
PYTHON := $(ACTIVATE) && $(PYTHON_CMD)
PIP := $(PYTHON) -m pip
# --------------------------------------------------
# 🍪 Render template (cookiecutter, cookiecutter_project_upgrader)
# --------------------------------------------------
COOKIECUTTER := $(ACTIVATE) && cookiecutter
PROJECT_UPGRADE := $(ACTIVATE) && cookiecutter_project_upgrader
# --------------------------------------------------
# 🧬 Dependency Management (deptry)
# --------------------------------------------------
DEPTRY := $(ACTIVATE) && deptry
# --------------------------------------------------
# 🛡️ Security Audit (pip-audit)
# --------------------------------------------------
PIPAUDIT := $(ACTIVATE) && pip-audit
# --------------------------------------------------
# 🎨 Formatting (black)
# --------------------------------------------------
BLACK := $(PYTHON) -m black
# --------------------------------------------------
# 🔍 Linting (ruff, yaml, jinja2)
# --------------------------------------------------
RUFF := $(PYTHON) -m ruff
TOMLLINT := tomllint
YAMLLINT := $(PYTHON) -m yamllint
JINJA := $(ACTIVATE) && jinja2 --strict \
	--extension=cookiecutter.extensions.JsonifyExtension \
	--extension=cookiecutter.extensions.RandomStringExtension \
	--extension=cookiecutter.extensions.SlugifyExtension \
	--extension=cookiecutter.extensions.TimeExtension \
	--extension=cookiecutter.extensions.UUIDExtension
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
# 📚 Documentation (Jekyll + nutrimatic)
# --------------------------------------------------
JEKYLL_BUILD := bundle exec jekyll build --quiet
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
BUMPVERSION := $(ACTIVATE) && bump-my-version bump --verbose
# Patch types:
MAJOR := major
MINOR := minor
PATCH := patch
# --------------------------------------------------
# 📜 Changelog generation (git-clif)
# --------------------------------------------------
GITCLIFF := git cliff
GITCLIFF_CHANGELOG := $(GITCLIFF) --output $(CHANGELOG_FILE)
GITCLIFF_CHANGELOG_RELEASE := $(GITCLIFF) --unreleased --tag $(RELEASE) --output $(CHANGELOG_RELEASE_FILE)
# --------------------------------------------------
# 🐙 Github Tools (git)
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
# 🏃‍♂️ Nutri-Matic command
# --------------------------------------------------
NUTRIMATIC := $(PYTHON) -m nutrimatic
# --------------------------------------------------
# Functions
# --------------------------------------------------
# Finds files of a given extension or "*" (all files) under a directory,
# skipping VENV_DIR and template markers like {{ }}.
define get_files_by_extension
	find $(1) -name "$(2)" \
		! -path "$(VENV_DIR)/*" \
		! -path "$(RENDERED_VENV_DIR)/*" \
		! -path "*{{*" \
		! -path "*}}*" \
		! -name "__init__.j2" \
		-print0
endef

JINJA_FILE_LIST := ( \
		$(call get_files_by_extension,$(PROJECT_ROOT),*.j2); \
		$(call get_files_by_extension,$(RENDERED_COOKIE_DIR),*.j2) \
	)
TOML_FILE_LIST := 	( \
		$(call get_files_by_extension,$(PROJECT_ROOT),*.toml); \
		$(call get_files_by_extension,$(RENDERED_COOKIE_DIR),*.toml) \
	)
# --------------------------------------------------
.PHONY: \
	all list-folders venv install \
	pre-commit-init security dependency-check black-formatter-check \
	black-formatter-fix render-cookiecutter jinja2-lint-check ruff-lint-check \
	ruff-lint-fix toml-lint-check yaml-lint-check format-check \
	format-fix lint-check lint-fix spellcheck \
	typecheck test jekyll readme \
	jekyll-serve run-docs build-docs bump-version-patch \
	changelog git-release pre-commit pre-release \
	release clean-docs clean-build clean \
	version help
# --------------------------------------------------
# Default: run lint, typecheck, spellcheck, tests, & docs
# --------------------------------------------------
all: install lint-check typecheck spellcheck test build-docs
# --------------------------------------------------
# Make Internal Utilities
# --------------------------------------------------
list-folders:
	$(AT)printf "\
	🐍 src: $(SRC_DIR)\n\
	🧪 Test: $(TESTS_DIR)\n"
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

install: venv
	$(AT)echo "📦 Installing project dependencies..."
	$(AT)$(PIP) install --upgrade pip setuptools wheel
	# $(AT)$(PIP) install -e $(DEPS)
	$(AT)$(PIP) install -e $(DEV_DEPS)
	$(AT)$(PIP) install -e $(DEV_DOCS)
	$(AT)echo "✅ Dependencies installed."
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
# Note: Run as part of project initialization.  No manual run needed.
pre-commit-init:
	$(AT)echo "📦 Installing pre-commit hooks and hook-types..."
	$(AT)which $(GIT) >/dev/null || { echo "Git is required"; exit 1; }
	$(AT)$(PRECOMMIT) install --install-hooks
	$(AT)$(PRECOMMIT) install --hook-type pre-commit --hook-type commit-msg
	$(AT)echo "✅ pre-commit dependencies installed!"
# --------------------------------------------------
# 🍪 Project Updater (cookiecutter_project_upgrader)
# --------------------------------------------------
project-upgrade:
	$(AT)echo "🍪 Upgrading project from initial cookiecutter template..."
	$(AT)$(PROJECT_UPGRADE) --context-file ./docs/cookiecutter_input.json \
		--upgrade-branch main \
		-e "cookiecutter.json" \
		-e "$(COOKIE_DIR)"
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
	$(AT)$(DEPTRY) --pep621-dev-dependency-groups dev,docs \
		 $(SRC_DIR)
	$(AT)echo "✅ Finished checking for dependency issues!"
# --------------------------------------------------
# 🎨 Formatting (black)
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
# 🔍 Linting (jinja2, ruff, toml, & yaml)
# --------------------------------------------------
render-cookiecutter:
	$(AT)rm -rf $(RENDERED_COOKIE_DIR)
	$(AT)$(COOKIECUTTER) . --no-input \
		--output-dir $(RENDERED_COOKIE_DIR) \
		--overwrite-if-exists

jinja2-lint-check:
	$(AT)echo "🔍 jinja2 lint..."
	$(AT)jq '{cookiecutter: .}' cookiecutter.json > /tmp/_cc_wrapped.json
	$(AT)$(JINJA_FILE_LIST) | tr '\0' '\n'
	$(AT)$(ACTIVATE) && $(JINJA_FILE_LIST) | \
		while IFS= read -r -d '' f; do \
			if file "$$f" | grep -q text; then \
				echo "Checking $$f"; \
				$(JINJA) "$$f" /tmp/_cc_wrapped.json || exit 1; \
			fi; \
		done
	$(AT)echo "✅ Finished linting check of jinja2 macro files with jinja2!"

ruff-lint-check:
	$(AT)echo "🔍 Running ruff linting..."
	$(AT)$(MAKE) list-folders
	$(AT)$(RUFF) check --config pyproject.toml $(SRC_DIR) $(TESTS_DIR) \
		--force-exclude '$(COOKIE_DIR)/pyproject.toml'
	$(AT)echo "✅ Finished linting check of Python code with Ruff!"

ruff-lint-fix:
	$(AT)echo "🎨 Running ruff lint fixes..."
	$(AT)$(RUFF) check --config pyproject.toml --show-files $(SRC_DIR) $(TESTS_DIR)
	$(AT)$(RUFF) check --config pyproject.toml --fix $(SRC_DIR) $(TESTS_DIR) \
		--force-exclude '$(COOKIE_DIR)/pyproject.toml'
	$(AT)echo "✅ Finished linting Python code with Ruff!"

toml-lint-check:
	$(AT)echo "🔍 Running Tomllint..."
	$(AT)$(TOML_FILE_LIST) | tr '\0' '\n'
	$(AT)$(ACTIVATE) && \
		$(TOML_FILE_LIST) \
		| xargs -0 -n 1 $(TOMLLINT)
	$(AT)echo "✅ Finished linting check of toml files with Tomllint!"

yaml-lint-check:
	$(AT)echo "🔍 Running yamllint..."
	$(AT)$(YAMLLINT) $(PROJECT_ROOT)
	$(AT)$(YAMLLINT) $(RENDERED_COOKIE_DIR)
	$(AT)echo "✅ Finished linting check of yaml files with yamllint!"

lint-check: render-cookiecutter ruff-lint-check toml-lint-check yaml-lint-check
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
	$(AT)$(MAKE) list-folders
	$(AT)$(call run_ci_safe, $(MYPY) $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Python typecheck complete!"
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
test:
	$(AT)echo "🧪 Running tests with pytest..."
	$(AT)$(call run_ci_safe, $(PYTEST))
	$(AT)echo "✅ Python tests complete!"
# --------------------------------------------------
# 📚 Documentation (Jekyll + nutrimatic)
# --------------------------------------------------
jekyll:
	$(MAKE) -C $(JEKYLL_DIR) all;

jekyll-serve: docs
	$(MAKE) -C $(JEKYLL_DIR) run;

readme:
	$(AT)$(NUTRIMATIC) build readme $(JEKYLL_DIR) $(README_FILE) \
		--tmp-dir $(README_GEN_DIR) --jekyll-cmd '$(JEKYLL_BUILD)'

# Note: Run as part of pre-commit.  No manual run needed.
build-docs: jekyll readme
	$(AT)$(GIT) add $(DOCS_DIR)
	$(AT)$(GIT) add $(README_FILE)

run-docs: jekyll-serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
# TODO: Also create a git tag of current version.
bump-version-patch:
	$(AT)echo "🔖 Updating $(PROJECT_NAME) version from $(VERSION)..."
	$(AT)$(BUMPVERSION) $(PATCH)
	$(AT)echo "✅ $(PROJECT_NAME) version update complete!"
# --------------------------------------------------
# 📜 Changelog generation (git-cliff)
# --------------------------------------------------
# Note: Run as part of pre-commit.  No manual run needed.
changelog:
	$(AT)echo "📜 $(PROJECT_NAME) Changelog Generation..."
	$(AT)$(GITCLIFF_CHANGELOG)
	$(AT)$(GITCLIFF_CHANGELOG_RELEASE)
	$(AT)$(GIT) add $(CHANGELOG_FILE)
	$(AT)$(GIT) add $(CHANGELOG_RELEASE_FILE)
	$(AT)echo "✅ Finished Changelog Update!"
# --------------------------------------------------
# 🐙 Github Commands (git)
# --------------------------------------------------
# Note: Run as part of project initialization.  No manual run needed.
git-init: git-dependency-check
	$(AT)if ! $(GIT_INIT_STATUS); then \
		echo "🌱 $(PROJECT_NAME) Git initialization! 🎉"; \
		$(GIT) init; \
		$(GIT) add --all; \
		$(GIT) commit -m "chore(init): Init commit. \
			Project $(PROJECT_NAME) template generation complete."; \
		echo "✅ Finished Git initialization!"; \
	else \
		echo "ℹ️ Git is already initialized for $(PROJECT_NAME)."; \
	fi

git-release:
	$(AT)if $(GIT_INIT_STATUS); then \
		echo "📦 $(PROJECT_NAME) Release Tag - $(RELEASE)! 🎉"; \
		$(GIT) tag -a $(RELEASE) -m "Release $(RELEASE)"; \
		$(GIT) push origin $(RELEASE); \
		$(GITHUB) release create $(RELEASE) --generate-notes; \
	echo "✅ Finished uploading Release - $(RELEASE)! 🎉"; \
	else \
		echo "❌ Git is not yet initialized.  Skipping version release." \
	fi
# --------------------------------------------------
# 📢 Release
# --------------------------------------------------
pre-commit: test security dependency-check format-fix lint-check spellcheck typecheck
pre-release: clean install pre-commit build-docs changelog build
release: git-release bump-version-patch
# --------------------------------------------------
# 🧹 Clean artifacts
# --------------------------------------------------
clean-docs:
	$(AT)echo "🧹 Cleaning documentation artifacts..."
	$(AT)$(MAKE) -C $(JEKYLL_DIR) clean
	$(AT)echo "✅ Cleaned documentation artifacts..."

clean-build:
	$(AT)echo "🧹 Cleaning build artifacts..."
	$(AT)rm -rf build dist *.egg-info
	$(AT)find $(SRC_DIR) $(TESTS_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	$(AT)-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	$(AT)echo "🧹 Cleaned build artifacts."

clean: clean-docs clean-build
# --------------------------------------------------
# Version
# --------------------------------------------------
version:
	$(AT)echo "$(PROJECT_NAME)"
	$(AT)echo "author: $(AUTHOR)"
	$(AT)echo "version: $(VERSION)"
# --------------------------------------------------
# ❓ Help
# --------------------------------------------------
help:
	$(AT)echo "📦 $(PROJECT_NAME) Makefile"
	$(AT)echo ""
	$(AT)echo "Usage:"
	$(AT)echo "  make venv                   Create python virtual environment (venv)"
	$(AT)echo "  make install                Install python project dependencies (pip)"
	$(AT)echo "  make security               Security audit (pip-audit)"
	$(AT)echo "  make dependency-check       dependency check (deptry)"
	$(AT)echo "  make black-formatter-check  Run Black python formatter check (black)"
	$(AT)echo "  make black-formatter-fix    Run Black python formatter (black)"
	$(AT)echo "  make format-check           Run all project formatter checks (black)"
	$(AT)echo "  make format-fix             Run all project formatter autofixes (black)"
	$(AT)echo "  make jinja2-lint-check      Run jinja linter (jinja-cmd)"
	$(AT)echo "  make ruff-lint-check        Run Ruff linter (ruff)"
	$(AT)echo "  make ruff-lint-fix          Auto-fix python lint issues (ruff)"
	$(AT)echo "  make toml-lint-check        Run TOML linter (tomllint)"
	$(AT)echo "  make yaml-lint-check        Run YAML linter (yamllint)"
	$(AT)echo "  make lint-check             Run all project linters (jinja2, ruff, toml, & yaml)"
	$(AT)echo "  make lint-fix               Run all project linter autofixes (ruff)"
	$(AT)echo "  make spellcheck             Run spellcheck (codespell)"
	$(AT)echo "  make typecheck              Run type checking (mypy)"
	$(AT)echo "  make test                   Run test suite (pytest)"
	$(AT)echo "  make jekyll                 Generate Jekyll Documentation"
	$(AT)echo "  make build-docs             Build all project documentation"
	$(AT)echo "  make run-docs               Serve Jekyll site locally"
	$(AT)echo "  make clean                  Clean build artifacts"
	$(AT)echo "  make version                Displays project information."
	$(AT)echo "  make all                    Run lint, typecheck, test, and docs"
	$(AT)echo "Options:"
	$(AT)echo "  V=1             Enable verbose output (show all commands being executed)"
	$(AT)echo "  make -s         Run completely silently (suppress make's own output AND command echo)"
