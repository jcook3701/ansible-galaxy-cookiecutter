# --------------------------------------------------
# Changelog:
# --------------------------------------------------

## [unreleased]

### ⚙️  Miscellaneous

- Feat 002 (#6)

* chore(version): version bump.

* fix(cspell): fixed cspell to include project name and namespace as words to avoid them causing the commit spellcheck from failing.

* feat(timestamps): Updates to add both date and year timestamps.

* refactor(template): Template was refactored to use project_slug rather than package_name.  Hopefully this helps improve cookiecutter_project_upgrader.  Also added updates for license file and jinja2-cli extensions.

* fix(funding): removed .github/FUNDING.yml from _copy_without_render.

* fix(cookiecutter): cleaned up the cookiecutter.json file.
- Revert "Feat 002 (#6)"

This reverts commit 560ce6be59543a2e24cd7e670e65bf6662bc4d50.
- Feat 002 (#7)

* chore(version): version bump.

* fix(cspell): fixed cspell to include project name and namespace as words to avoid them causing the commit spellcheck from failing.

* feat(timestamps): Updates to add both date and year timestamps.

* refactor(template): Template was refactored to use project_slug rather than package_name.  Hopefully this helps improve cookiecutter_project_upgrader.  Also added updates for license file and jinja2-cli extensions.

* fix(funding): removed .github/FUNDING.yml from _copy_without_render.

* fix(cookiecutter): cleaned up the cookiecutter.json file.

* fix(cookiecutter): turned hidden vars to dynamic hidden vars by changing '_' with '__'.
- Merge pull request #8 from jcook3701/develop

Feat 002 (#7)
- Feat 003 (#10)

* feat(license): Updates to license headers.

* fix(header): trying to fix too many newlines being added above header.

* refactor(license): reformat of license texts to be in alphabetical order.

* feat(header): Got license headers working.

* feat(cookiecutter): Setup cookiecutter renderer within build to make it possible to lint toml and yaml files before committing edits.

* fix(build): added cookiecutter to pyproject.toml to allow rendering of project from build.

* feat(build): Created tool to collect files by type and ignores the template directory.  Also Generate cookiecutter template that is linted through to avoid testing by pushing.
- Merge pull request #11 from jcook3701/develop

Feat 003 (#10)
- Feat 004 (#12)

* feat(git): Init check to make sure that the project has not already been initialized.

* fix(cspell): updated cspell to allow a few more words.

* fix(cspell): updated cspell to allow a few more words.

* fix(build): fixes for black within pyproject.toml.

* feat(template): Setup template upgrade from cookiecutter-cookiecutter project.

* Update template

* fix(upgrade): Fixed upgrade file to remove changelog generation during upgrade.

* Update template
- Merge pull request #13 from jcook3701/develop

Feat 004 (#12)
- Feat 005 (#14)

* fix(docs): readme badge fix.

* fix(ci/cd): fixed ci/cd to run on feature branches.

* fix(jinja): fixed template error in github pages ci/cd.
- Merge pull request #15 from jcook3701/develop

Feat 005 (#14)
- Feat 006 (#16)

* feat(template): Updates to cookiecutter.json to run hooks.

* feat(template): Updates to cookiecutter.json to run hooks.

* fix(template): Fixed template ci cd errors.

* fix(build): Build fixes for license files.

* feat(git): added git attributes file.

* fix(yamllint): Updates to yamllint ignore section.

* feat(galaxy): Setting up galaxy-importer for testing.

* fix(build): fix for build-docs so that pre-commit can continue after docs are built without having to re-run git add command.

* fix(ansible): Created ansible galaxy-importer.cfg file to store configuration rather than trying to use the pyproject file.

* feat(galaxy): Upgrades getting ready for first sub repository publishing to ansible galaxy.

* fix(ci/cd): Fix to changelog jinja templating.

* fix(template): hopefully template fix.

* feat(update): Preparation for update from cookiecutter-cookiecutter project.

* feat(docs): Readme updates.

* feat(docs): Readme updates.

* feat(docs): Readme updates.

* fix(template): testing template settings.

* fix(testing): testing settings update.

* fix(testing): testing settings update.

* Update template

* fix(template): fixed license headers in template. Next is to fix python configuration file.

* fix(template): This now renders.  Should pass more ci/cd tests.

* fix(tests): Unit test fix.
- Merge pull request #18 from jcook3701/develop

Feat 006 (#16)
## [0.1.0] - 2025-12-13

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
- Feat 001 (#4)

* docs(readme): dependency updates.

* chore(shared_hooks): removed shared hooks that are replaced by nutri-matic.

* fix(makefile): Fixed sphinx build.

* fix(spelling): Fixed codespell issue.  Also added cspell to pre-commit to ensure proper spelling in commit messages.

* feat(template): added spellcheck cspell for template pre-commit commit-msg.

* feat(pre-commit): Updated makefile to use pre-commit version of ansible-lint and turned ansible-lint to manual mode on pre-commit as it takes a bit to run.  Hopefully this works as expected and user can just use ci/cd to ensure ansible-lint passes at the end of working on a feature.

* fix(ansible-lint): fixed makefile ansible-lint command to now work with new pre-commit setup.

* chore(testing): test.

* feat(build): template makefile updates to add dependency checks for git and gh commands.

* fix(codespell): fixed code spell config to ignore cspell.json file.

* feat(upgrade): Added cookiecutter_project_upgrader to makefile.  Need to test.

* fix(gh-check): Fixed the call to the check that makes sure gh (github) package is installed.

* chore(test): testing.

* fix(makefile): fixes for ansible changelog generation.

* chore(changelog): added changelog back to the post-gen-hooks.

* fix(timestamp): seeing if setting timestamp to hidden var fixes cookiecutter_project_upgrader issues.  Also fixes to cookiecutter_project_upgrader command in makefile.

---------

Co-authored-by: jcook3701 <jcook3701@gmail.com>
- Merge pull request #5 from jcook3701/develop

Feat 001 (#4)

### 🌱 Init

- Init commit ansible-galaxy-cookiecutter
