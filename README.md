# Ansible Galaxy Cookiecutter

__Author:__ Jared Cook  
__Version:__ 0.1.0  

## Overview
Ansible Galaxy cookiecutter template project + Github docs template generation.  

__Note:__ Unless you are using a newer version of cookiecutter >= 2, ```--no-input``` is necessary for template generation without error.  

1. Pull Project with cookiecutter command:  
``` shell
$ cookiecutter git@github.com:jcook3701/ansible-galaxy-cookiecutter.git \
	--no-input \
	namespace="jcook3701", \
	project_name="test-project" \
	description="Ansible test project."  
```


## Development

1. Pull code from development branch while testing updates.  

``` shell
$ cookiecutter git@github.com:jcook3701/ansible-galaxy-cookiecutter.git \
	 --checkout develop \
	  --no-input \
	namespace="jcook3701", \
	project_name="test-project" \
	description="Ansible test project."  
```
replace ```test-project``` or any of the other variables with real context configuration variables:  

### Authors Notes:  
1. This code currently works with cookiecutter 1.7 from Ubuntu's apt repositories.  

### TODO's
1. Update pyproject.toml to use latest version of cookiecutter to get latest features.  
2. Update autodoc init within 
