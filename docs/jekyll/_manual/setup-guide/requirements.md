---
layout: default
title: Requirements
nav_order: 1
parent: "Setup Guide"
---

## ansible-galaxy-cookiecutter Requirements

1. Python 3.11  
    ```shell
    $ sudo apt install python3.11 python3.11-dev python3.11-venv
    ```
2. [Nutri-Matic](https://github.com/jcook3701/nutri-matic)
    __Note:__
    __Example:__ Install with the following command (Recommended that this is installed in a python [virtual environment]({% link _manual/tutorials/create-virtual-env.md %})):
    ```shell
    $ python -m pip install nutri-matic
    ```
3. [rustup](https://rust-lang.org/tools/install/)  
    __Note:__ I found that it is easiest to use rustup to manage rustc and cargo but this is not required.  
    __Example:__ Install rustup with the following:  
    ```shell
    $ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ```
4. [git-cliff](https://git-cliff.org/)  
    __Note:__ git-cliff can generate changelog files from the Git history by utilizing conventional commits as well as regex-powered custom parsers.  
    ```shell
    $ cargo install git-cliff
    ```
