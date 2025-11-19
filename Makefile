# Makefile
# =========================================
# Project: ansible-galaxy-cookiecutter
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

# Detect if we are running inside GitHub Actions CI.
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
# 📁 Build Directories
# --------------------------------------------------
COOKIE_DIR := {{ cookiecutter.package_name }}
HOOKS_DIR := hooks
SHARED_HOOKS_DIR := $(COOKIE_DIR)/_shared_hooks
BUILD_UTILS_DIR := $(COOKIE_DIR)/build_utils
SRC_DIR := $(HOOKS_DIR) '$(SHARED_HOOKS_DIR)' '$(BUILD_UTILS_DIR)'
TEST_DIR := tests
COOKIE_TESTS_DIR := $(COOKIE_DIR)/tests
TESTS_DIR := '$(COOKIE_TESTS_DIR)' $(TEST_DIR)
DOCS_DIR := docs
SPHINX_DIR := $(DOCS_DIR)/sphinx
JEKYLL_DIR := $(DOCS_DIR)/jekyll

SPHINX_BUILD_DIR := $(SPHINX_DIR)/_build/html
JEKYLL_OUTPUT_DIR := $(JEKYLL_DIR)/sphinx
# --------------------------------------------------
# 🐍 Python / Virtual Environment
# --------------------------------------------------
PYTHON_CMD := python3.11
VENV_DIR := .venv
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
# 🧠 Typing (mypy)
# --------------------------------------------------
MYPY := $(PYTHON) -m mypy
# --------------------------------------------------
# 🔍 Linting (ruff, yaml, jinja2)
# --------------------------------------------------
RUFF := $(PYTHON) -m ruff
YAMLLINT := $(PYTHON) -m yamllint
JINJA := $(ACTIVATE) && jinja2 --strict
# --------------------------------------------------
# 🎨 Formatting (black)
# --------------------------------------------------
BLACK := $(PYTHON) -m black
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
PYTEST := $(PYTHON) -m pytest
# --------------------------------------------------
# 📘 Documentation (Sphinx + Jekyll)
# --------------------------------------------------
SPHINX := $(PYTHON) -m sphinx -b markdown
JEKYLL_BUILD := bundle exec jekyll build --quiet
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
.PHONY: all list-folders venv install black-formatter-fix black-formatter-check \
	ruff-lint-check ruff-lint-fix yaml-lint-check jinja2-lint-check lint-check \
	typecheck test docs jekyll-serve clean help
# --------------------------------------------------
# Default: run lint, typecheck, tests, and docs
# --------------------------------------------------
all: install lint-check typecheck test docs
# --------------------------------------------------
# Make Internal Utilities
# --------------------------------------------------
list-folders:
	$(AT)printf "\
	     Hooks: $(HOOKS_DIR)\n\
	     Shared Hooks: '$(SHARED_HOOKS_DIR)'\n\
	     Build Utilities: '$(BUILD_UTILS_DIR)'\n\
	     Test: $(TESTS_DIR)\n"
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
	# $(AT)$(PIP) install -e $(DEPS)
	$(AT)$(PIP) install -e $(DEV_DEPS)
	$(AT)$(PIP) install -e $(DEV_DOCS)
	$(AT)echo "✅ Dependencies installed."
# --------------------------------------------------
# Formating (black, ruff)
# --------------------------------------------------
black-formatter-fix:
	$(AT)echo "🎨 Running black formatter fixes..."
	$(AT)$(BLACK) $(SRC_DIR) $(TESTS_DIR)
	$(AT)echo "✅ Finished formatting Python code with Black!"

black-formatter-check:
	$(AT)echo "🔍 Running black formatter style check..."
	$(AT)$(call run_ci_safe, $(BLACK) --check $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Finished formatting check of Python code with Black!"

ruff-formatter:
	$(AT)echo "🎨 Running ruff formatter..."
	$(AT)$(MAKE) list-folders
	$(AT)$(RUFF) format $(SRC_DIR) $(TESTS_DIR)
# --------------------------------------------------
# Linting (ruff, yaml, jinja2)
# --------------------------------------------------
ruff-lint-check:
	$(AT)echo "🔍 Running ruff linting..."
	$(AT)$(MAKE) list-folders
	$(AT)$(RUFF) check --config pyproject.toml $(SRC_DIR) $(TESTS_DIR) \
		--force-exclude '$(COOKIE_DIR)/pyproject.toml'

ruff-lint-fix:
	$(AT)echo "🎨 Running ruff lint fixes..."
	$(AT)$(RUFF) check --config pyproject.toml --show-files $(SRC_DIR) $(TESTS_DIR)
	$(AT)$(RUFF) check --config pyproject.toml --fix $(SRC_DIR) $(TESTS_DIR) \
		--force-exclude '$(COOKIE_DIR)/pyproject.toml'

yaml-lint-check:
	$(AT)echo "🔍 Running yamllint..."
	$(AT)$(YAMLLINT) .

jinja2-lint-check:
	$(AT)echo "🔍 jinja2 linting all template files under $(COOKIE_DIR)..."
	$(AT)jq '{cookiecutter: .}' cookiecutter.json > /tmp/_cc_wrapped.json
	$(AT)find '$(COOKIE_DIR)' -type f \
		! -path "$(COOKIE_DIR)/.github/*" \
		! -name "*.png" \
		! -name "*.jpg" \
		! -name "*.ico" \
		! -name "*.gif" \
		-print0 | while IFS= read -r -d '' f; do \
			if file "$$f" | grep -q text; then \
				echo "Checking $$f"; \
				$(JINJA) "$$f" /tmp/_cc_wrapped.json || exit 1; \
			fi; \
		done

lint-check: ruff-lint-check yaml-lint-check jinja2-lint-check
# --------------------------------------------------
# Typechecking (MyPy)
# --------------------------------------------------
typecheck:
	$(AT)echo "🧠 Checking types (MyPy)..."
	$(AT)$(MAKE) list-folders
	$(AT)$(call run_ci_safe, $(MYPY) $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Python typecheck complete!"
# --------------------------------------------------
# Testing (pytest)
# --------------------------------------------------
# NOTE: This is using TEST_DIR and not TESTS_DIR at the moment.
# TODO: See if I can also get working with '$(COOKIE_TESTS_DIR)'
test:
	$(AT)echo "🧪 Running tests with pytest..."
	$(AT)$(call run_ci_safe,$(PYTEST) $(TEST))
	$(AT)echo "✅ Python tests complete!"
# --------------------------------------------------
# Documentation (Sphinx + Jekyll)
# --------------------------------------------------
sphinx:
	$(AT)echo "🔨 Building Sphinx documentation 📘 as Markdown..."
	$(AT)$(SPHINX) $(SPHINX_DIR) $(JEKYLL_OUTPUT_DIR)
	$(AT)echo "✅ Sphinx Markdown build complete!"

jekyll:
	$(AT)echo "🔨 Building Jekyll site..."
	$(AT)cd $(JEKYLL_DIR) && $(JEKYLL_BUILD)
	$(AT)echo "✅ Full documentation build complete!"

build-docs: sphinx jekyll

jekyll-serve: docs
	$(AT)echo "🚀 Starting Jekyll development server..."
	$(AT)cd $(JEKYLL_DIR) && $(JEKYLL_SERVE)
# --------------------------------------------------
# Clean artifacts
# --------------------------------------------------
clean:
	$(AT)echo "🧹 Clening build artifacts..."
	$(AT)rm -rf $(SPHINX_DIR)/_build $(JEKYLL_OUTPUT_DIR)
	$(AT)$(call run_ci_safe, cd $(JEKYLL_DIR) && $(JEKYLL_CLEAN))
	$(AT)rm -rf build dist *.egg-info
	$(AT)find $(HOOKS_DIR) $(TESTS_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	$(AT)-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	$(AT)echo "🧹 Cleaned build artifacts."
# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	$(AT)echo "📦 ansible-galaxy-cookiecutter Makefile"
	$(AT)echo ""
	$(AT)echo "Usage:"
	$(AT)echo "  make venv                   Create virtual environment"
	$(AT)echo "  make install                Install dependencies"
	$(AT)echo "  make ruff-formatter         Run Ruff Formatter"
	$(AT)echo "  make ruff-lint-check        Run Ruff linter"
	$(AT)echo "  make ruff-lint-fix          Auto-fix lint issues with python ruff"
	$(AT)echo "  make yaml-lint-check        Run YAML linter"
	$(AT)echo "  make jinja2-lint-check      Run jinja-cmd linter"
	$(AT)echo "  make lint-check             Run all project linters (ruff, yaml, & jinja2)"
	$(AT)echo "  make typecheck              Run Mypy type checking"
	$(AT)echo "  make test                   Run Pytest suite"
	$(AT)echo "  make build-docs             Build Sphinx + Jekyll documentation"
	$(AT)echo "  make jekyll-serve           Serve Jekyll site locally"
	$(AT)echo "  make clean                  Clean build artifacts"
	$(AT)echo "  make all                    Run lint, typecheck, test, and docs"
	$(AT)echo "Options:"
	$(AT)echo "  V=1             Enable verbose output (show all commands being executed)"
	$(AT)echo "  make -s         Run completely silently (suppress make's own output AND command echo)"
