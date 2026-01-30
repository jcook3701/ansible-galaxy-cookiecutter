---
layout: default
title: "Nutri-Matic"
nav_order: 1
parent: Tutorials
---
## Nutri-Matic Setup

First clone the [Nutri-Matic](https://github.com/jcook3701/nutri-matic) python utility.  This is needed to clone all [jcook3701's](https://github.com/jcook3701), cookiecutter templates, with the ```cookiecutter``` command.  

```shell
$ git clone git@github.com:jcook3701/nutri-matic.git
```

Next, move into the newly cloned directory, ```cd nutri-matic``` . Then utilize the [developer guide]({% link _manual/contribute/developer-guide.md %}) process and run ```make python-install``` to create a python virtual environment stored within the, ```.venv```, folder.  This ensures the latest version of nutri-matic code and is very helpful for development on any of the template repositories.  

Finally, source Nutri-Matic's created virtual environment with the directory, ```.venv```, and begin generating templates.

```shell
$ source .venv/bin/active
```

The Nutri-Matic package is responsible for managing all [jcook3701's](https://github.com/jcook3701) cookiecutter template hooks and build features.  

After the environment is sourced and other project dependencies are installed; templates should be able to be generated using the commands found in our [getting started]({% link _manual/introduction/getting-started.md %}) guide.  
