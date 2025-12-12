# Ansible Galaxy Cookiecutter

__Author:__ Jared Cook  
__Version:__ 0.1.0  

## Overview:
Ansible Galaxy cookiecutter template project /w Ansible Auto Documentation + [Github docs](https://github.com/jcook3701/github-docs-cookiecutter) template generation + [Sphinx docs](https://github.com/jcook3701/sphinx-cookiecutter) template generation.  

![black-format](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/black-format.yml/badge.svg)
![dependency-check](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/dependency-check.yml/badge.svg)
![jinja2-lint](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/jinja2-lint.yml/badge.svg)
![ruff-lint](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/ruff-lint.yml/badge.svg)
![security-audit](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/security-audit.yml/badge.svg)
![spellcheck](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/spellcheck.yml/badge.svg)
![tests](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/tests.yml/badge.svg)
![typecheck](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/typecheck.yml/badge.svg)
![yaml-lint](https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/yaml-lint.yml/badge.svg)

__Note:__ Unless you are using a newer version of cookiecutter >= 2, ```--no-input``` is necessary for template generation without error.  

## Usage Examples:
__Example:__ Pull from main branch.  
``` shell
$ cookiecutter git@github.com:jcook3701/ansible-galaxy-cookiecutter.git \
	--no-input \
	namespace="jcook3701" \
	project_name="test-project" \
	description="Ansible test project."
```
__Example:__ Pull from develop branch.  
``` shell
$ cookiecutter git@github.com:jcook3701/ansible-galaxy-cookiecutter.git \
	 --checkout develop \
	  --no-input \
	namespace="jcook3701" \
	project_name="test-project" \
	description="Ansible test project."
```
__Note:__ replace ```test-project``` or any of the other variables with real context configuration variables.  

***

## Development Strategy:
__Note:__ All Makefile commands are used in ci/cd to ensure that if they pass locally they should also pass once pushed to github.  
### 🐍️ Build environment (.venv)
``` shell
$ make install
```
### 🧬 Dependency Management (deptry)
```shell
$ make dependency-check
```
### 🛡️ Security Audit (pip-audit)
```shell
$ make security
```
### 🎨 Formatting (black)
```shell
$ make format-check
```
```shell
$ make format-fix
```
### 🔍 Linting (jinja2-cli, ruff, tomllint, & yaml-lint)
``` shell
$ make lint-check
```
``` shell
$ make lint-fix
```
### 🎓 Spellchecking (codespell)
```shell
$ make spellcheck
```
### 🧠 Typechecking (mypy)
``` shell
$ make typecheck
```
### 🧪 Testing (pytest)
``` shell
$ make test
```
### 🚀 Release (git tag)
```shell
$ make release
```
### ❓ Build Help
``` shell
$ make help
```

## Commit Help:
__Note:__ Commits are required to be conventional git commit message.  This helps with the auto-generation of the changelog files and is enforced by pre-commit.  
__example:__  
```shell
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```
* ```<type>```: A required noun that describes the nature of the change.  
* ```[optional scope]```: An optional phrase within parentheses that specifies the part of the codebase being affected (e.g., fix(parser):).  
* ```<description>```: A required short, imperative-mood summary of the changes.  
* ```[optional body]```: A longer description providing additional context and "what and why" details.  
* ```[optional footer(s)]```: Used for adding meta-information, such as issue references (Fixes #123) or indicating breaking changes.  

***

## Requirements:
1. Python 3.11  
```shell
$ sudo apt install python3.11
```
2. [rustup](https://rust-lang.org/tools/install/)  
__Note:__ I found that it is easiest to use rustup to manage rustc and cargo but this is not required.  
__Example:__ Install rustup with the following:  
```shell
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

3. [git-cliff](https://git-cliff.org/)  
__Note:__ git-cliff can generate changelog files from the Git history by utilizing conventional commits as well as regex-powered custom parsers.  
```shell
$ cargo install git-cliff
```

***

### Authors Notes:
1. This code currently works with cookiecutter 1.7 from Ubuntu's apt repositories.

### TODO's
1. Update pyproject.toml to use latest version of cookiecutter to get latest features.
2. Update cookiecutter.json with:
	```"license": ["MIT", "GPLv3", "Apache 2.0"],```

<!--
### Helpful Emojis:

📡🐋🛢️🚢 🦊💼 👨🏼‍💻🚧 📌 🌱🌳 ⏳🔑 🔫⌚ 🧼🧽 🔌💉

### Authors Hidden TODO's

1.
--->
