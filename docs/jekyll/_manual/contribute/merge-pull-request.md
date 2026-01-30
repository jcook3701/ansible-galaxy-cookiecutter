---
layout: default
title: Merge a pull request
nav_order: 1
parent: Contribute
---
## Merge a pull request

When a pull request has been reviewed and approved by at least one person and all checks have passed, then it's time to merge the pull request.

## Who is expected to merge a pull request?

Maintainers are responsible for merging all pull requests. If a maintainer has opened a pull request, then the general rule is that the same maintainer merges the pull request. If a non-maintainer has opened a pull request, then it's suggested that one of the maintainers who reviews the pull request should merge the pull request.

## Checklist of considerations

Consider (and ask about) the items on the following checklist before merging a pull request:

- Is it reviewed and approved?
- Have all checks passed?
- Does it have a proper pull request title?
- Does it need to be added to the changelog (release notes)?
- Does it need backporting?

## Before merge

Before actually merging a pull request, consider the following things:

### Status checks

Before you can merge a pull request, it must have a review approval, and all the required status checks must pass.

### Format the pull request title

<!-- ### Assign a milestone (automated) -->

### Changelog (automated)

## Doing the actual merge

The best time to actually merge the pull request varies from case to case. All commits in a pull request are squashed.

You can change the commit message before merging. Please remember that developers might use the commit information for tasks like reviewing changes of files, doing Git blame, and resolving merge conflicts.

While there aren't formal best practices around this process, you can consider the following guidance:

**Do:**

- Make sure the pull request title is formatted properly before merging. Doing so automatically gives you a good and short summary of the commit.
- Leave `Co-authored-by:` lines as is so that co-authors are credited for the contribution.
- Remove any commit information that doesn't bring any context to the change.

**Consider:**

- Keep any references to issues that the pull request fixes, closes, or references. Doing this allows cross-reference between the commit and referenced issue or issues.

To finalize the merge, click the **Confirm squash and merge** button.

## After the merge

Make sure to close any referenced or related issues. We recommend that you assign the same milestone on the issues that the pull request fixes or closes, but this isn't required.
