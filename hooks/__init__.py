"""ansible-galaxy-cookiecutter Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Discription: Hooks init file.
"""

from .ansible import generate_ansible_dirs
from .docs import generate_docs_templates
from .utils import make

__all__ = ["generate_ansible_dirs", "generate_docs_templates", "make"]
