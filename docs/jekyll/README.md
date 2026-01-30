# {{ site.title }}

[![License](https://img.shields.io/github/license/{{ site.github_username }}{{ site.baseurl }})](LICENSE)

__Author:__ {{ site.author }}  
__Version:__ {{ site.version }}  

## Overview
{{ site.description }}  

__CI/CD Check List:__
* ![dependency-check]({{ site.repo_url }}/actions/workflows/dependency-check.yml/badge.svg)
* ![format-check]({{ site.repo_url }}/actions/workflows/format-check.yml/badge.svg)
* ![lint-check]({{ site.repo_url }}/actions/workflows/lint-check.yml/badge.svg)
* ![security-audit]({{ site.repo_url }}/actions/workflows/security-audit.yml/badge.svg)
* ![spellcheck]({{ site.repo_url }}/actions/workflows/spellcheck.yml/badge.svg)
* ![tests]({{ site.repo_url }}/actions/workflows/tests.yml/badge.svg)
* ![typecheck]({{ site.repo_url }}/actions/workflows/typecheck.yml/badge.svg)

***
<!-- NOTE: This page is currently included in _copy_without_render which is why there are no raw or endraw tags. And no calls to {{ cookiecutter.etc }}. -->
<!-- NOTE: On this page all links need to be from site.github_io_url and not jinja2 links -->

## Getting Started
* [Installation guide]({{ site.github_io_url }}/manual/introduction/installation-guide)  

## Documentation
The {{ site.title }} documentation is available at [docs]({{ site.github_io_url }}).  

## Contributing
If you're interested in contributing to the {{ site.title }} project:  
* Start by reading the [contributing guide]({{ site.github_io_url }}/developer-resources/contribute).  
* Learn how to setup your local environment, in our [developer guide]({{ site.github_io_url }}/contribute/developer-guide).  
* Look through our [style guide]({{ site.github_io_url }}/contribute/style-guides/index).  

## License
{{ site.copyright }}  

This project is licensed under the __{{ site.license }} License__.
See the [LICENSE]({{ site.repo_blob }}/LICENSE.md) file for the full license text.  

SPDX-License-Identifier: {{ site.license }}  
