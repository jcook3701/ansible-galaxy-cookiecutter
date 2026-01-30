---
layout: default
title: Create Virtual Environment
nav_order: 1
parent: Tutorials
---
## Install Python3 and Python Virtual Environment

Either install python 3.10 or 3.11. Below example is to install python 3.11, however, to install and utilize python 3.10 just replace '11' with '10' in each instance below.  

```shell
$ sudo apt install python3.11 python3.11-dev python3.11-venv
```

## Create Virtual Environment (Python)

First you need to decide where you would like you virtual environment to be stored.  Personally I use ```~/Documents/python3-venvs``` to store utility python environments. After creating the directory where you would like to store you python environments move into it and run the below command.  

``` shell
$ python3.11 -m venv nutri-matic-venv
```

Then source into that python environment.  

```shell
$ source ./nutri-matic-venv/bin/activate
```
