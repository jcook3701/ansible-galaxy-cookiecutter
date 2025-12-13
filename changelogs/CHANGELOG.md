# --------------------------------------------------
# Changelog:
# --------------------------------------------------

## [unreleased]

### ⚙️  Miscellaneous

- Develop (#1)

* adding files to modify

* adding files to modify

* cookiecutter fix

* modified test code to use license file. README handled though docs cookie cutter.

* upates to README.md

* added Makefile and pyproject.toml to make project easier to manage.  I should add these to my other cookiecutter projects as well.

* updates

* added yaml-linter

* yaml-lint fixes

* fixes for tests and jinja2 linting.
- Develop (#2)

* adding files to modify

* adding files to modify

* cookiecutter fix

* modified test code to use license file. README handled though docs cookie cutter.

* upates to README.md

* added Makefile and pyproject.toml to make project easier to manage.  I should add these to my other cookiecutter projects as well.

* updates

* added yaml-linter

* yaml-lint fixes

* fixes for tests and jinja2 linting.

* general project updates ci/cd etc.

* Makefile updates, lint fixes, typecheck fixes.

* Makefile updates and getting ready for testing.

* Updates to fix pulling documentation cookiecutters.

* fixed name for hook file.

* updates to post gen scripts.

* added base changelogs

* cookiecutter updates.

* update pyproject files.

* minor changes

* updated version within the changelogs and small updates.

* updated hooks

* yaml-lint update

* general updates

* python project updates to fit ansible project.

* makefile update.

* updates

* updates

* updates

* lame ansible-autodoc hack/fix.

* makefile sphinx and autodoc fixes

* test if i can run makefile from postgenhooks.

* test if i can run makefile from postgenhooks.

* split hooks into seperate files.  and update pytests config.

* import update

* testing

* moved hooks into cookiecutter to create modularity.

* update to remove _shared_hooks

* removed bad post_gen_projects.py file.
- Develop (#3)

* adding files to modify

* adding files to modify

* cookiecutter fix

* modified test code to use license file. README handled though docs cookie cutter.

* upates to README.md

* added Makefile and pyproject.toml to make project easier to manage.  I should add these to my other cookiecutter projects as well.

* added yaml-linter

* yaml-lint fixes

* fixes for tests and jinja2 linting.

* general project updates ci/cd etc.

* Makefile updates, lint fixes, typecheck fixes.

* Makefile updates and getting ready for testing.

* Updates to fix pulling documentation cookiecutters.

* fixed name for hook file.

* updates to post gen scripts.

* added base changelogs

* cookiecutter updates.

* update pyproject files.

* minor changes

* updated version within the changelogs and small updates.

* updated hooks

* yaml-lint update

* general updates

* python project updates to fit ansible project.

* lame ansible-autodoc hack/fix.

* makefile sphinx and autodoc fixes

* test if i can run makefile from postgenhooks.

* test if i can run makefile from postgenhooks.

* split hooks into seperate files.  and update pytests config.

* import update

* moved hooks into cookiecutter to create modularity.

* update to remove _shared_hooks

* removed bad post_gen_projects.py file.

* makefile updates

* updates to cookie pyproject.toml and Makeifle for build_utils.

* updates to cookie pyproject.toml build_utils.

* updates to cookie Makefile build_utils.

* updates to cookie pyproject.toml and Makeifle for build_utils.

* added new ci and major makefile updates

* updates to ci for cookiecutter and both Makefiles.

* fixes to pass ci

* fixes to pass ci

* Updates to python build tools.

* fix ci/cd errors

* makefile updates

* clean up imports

* updating Makefile to use git-cliff to manage changelog files.

* adding format

* bump version fix.

* fixed git-clif config file name

* updates to Makefile.

* updates to Makefile.

* makefile updates

* feat(pre-commit): added pre-commit tool to project to ensure that commit messages are good for git-cliff

* feat(build): updates to ci, makefile, (codespell, deptry, pre-commit, & pip-audit)

* feat(build): Updates to template Makefile & ci/cd (adding pre-commit-init, security, dependency-check, and spellcheck)

* feat(build): Makefile updates to allow creation of changelogs.

* feat(build): Fixed changelog gen with git-cliff.  Need to fix template changelog gen to use antsbull-changelog and antsichaut.

* feat(build): Makefile updates for template changelog. Added post-commit script.

* feat(build): trying to see if adding git add to makefile will help changelog be auto updated after pre-commit hook.

* feat(build): Added cookiecutter-project-upgrader and base setup needed to use this feature on future generated templates.

* fix(changelog): changelogs have been fixed.  getting ready for initial release.  There have also been major updates to build and ci/cd.

* fix(ci/cd): Changed name of security-check to security-audit.

* fix(readme): Updates to readme.

* fix(template): Fixed error that was causing template to not pull correctly.

* fix(libs): Removed ansible-lint from tools install. I might pre-commit to mange ansible-linting to avoid package conflicts.

---------

Co-authored-by: jcook3701 <jcook3701@gmail.com>
- *(shared_hooks)* Removed shared hooks that are replaced by nutri-matic.
- *(testing)* Test.
- *(test)* Testing.
- *(changelog)* Added changelog back to the post-gen-hooks.

### 🌱 Init

- Init commit ansible-galaxy-cookiecutter

### 🐛 Fixed

- *(makefile)* Fixed sphinx build.
- *(spelling)* Fixed codespell issue.  Also added cspell to pre-commit to ensure proper spelling in commit messages.
- *(ansible-lint)* Fixed makefile ansible-lint command to now work with new pre-commit setup.
- *(codespell)* Fixed code spell config to ignore cspell.json file.
- *(gh-check)* Fixed the call to the check that makes sure gh (github) package is installed.
- *(makefile)* Fixes for ansible changelog generation.

### 📚 Documentation

- *(readme)* Dependency updates.

### 🚀 Added

- *(template)* Added spellcheck cspell for template pre-commit commit-msg.
- *(pre-commit)* Updated makefile to use pre-commit version of ansible-lint and turned ansible-lint to manual mode on pre-commit as it takes a bit to run.  Hopefully this works as expected and user can just use ci/cd to ensure ansible-lint passes at the end of working on a feature.
- *(build)* Template makefile updates to add dependency checks for git and gh commands.
- *(upgrade)* Added cookiecutter_project_upgrader to makefile.  Need to test.
