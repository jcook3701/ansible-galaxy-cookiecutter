---
layout: default
title: "Git Commit Message"
nav_order: 1
parent: Contribute
---
## Git Commit Message Format Guide

Commits are required to be conventional git commit messages.  This helps with the auto-generation of the changelog files and is enforced by [pre-commit](https://pre-commit.com/).  

**options (default):**

* docs
* chore
* feat
* fix
* refactor
* ci
* test
* perf
* revert
* build
* style

**example:**  

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
