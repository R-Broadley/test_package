# Test Package
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)


## About
A test python package.


## Installation
Test Package can be installed with `pip install test_package`.
It is developed for Python >= 3.6.


## Development
Development of this package is centred on two key tools, Docker and tox.
The best way to build the package is with `make`, this will start a docker container and run code style checks, run unit tests supported python versions, generate test reports, build the docs and package the code ready for distribution (source and wheel).

It is also possible to work locally, `make dev` will create a virtual environment with all the development requirements in `.venv`. You will need tox for this to work.

There are several other commands which can be used for specific tasks e.g. `make lint` will check the style of the python code, `make clean` will remove build artefacts.
If docker is not available on your system, it is possible to use `tox -e <command>` to run these locally. By default tox will use Python 3.6 to run these, set the environment variable `PYVERSION` if you are using a different version (e.g. `export PYVERSION=3.7`).


### Code Style
There are four tools used to enforce code style: black, isort, pydocsyle and pylint.
Black and isort can be used to auto format using `make format`.
`make lint` will use all four tools to check style and highlight any errors, an html report is produced and stored in `reports/static_analysis/static_analysis.html`.
Calling `make` will perform the style checks, but will not perform any auto formatting.


### Unit Test Framework
Pytest is use for unit tests, this will run test written based on either the Pytest or Unittest frameworks.
Full tests across supported versions should be run with `make`, or if not using docker `tox`.
It is possible to run tests on a single python version by running, for example, `tox -e py36`; run make shell first to run the tests inside the docker container.

html test reports are generated for each python version tested, these can be found in reports/py3x.
Additionally the test coverage is checked of full test runs and a report is placed in reports/coverage.
The test run will fail if coverage is less than 100% (this is configurable in the tox.ini).


### Changelog
The package changelog-cli is used to manage the change log.

`changelog (new|change|fix|breaks) "<message>"` -> adds a line to the appropriate section

`changelog release (--major|minor|patch|suggest) (--yes)` -> Cuts a release for the changelog, incrementing the version.

`changelog current` -> returns the current version of the project based on the changelog

`changelog suggest` -> returns the suggested version of the next release based on the current logged changes

`changelog --version` -> get the current version of the changelog tool

`changelog --help` -> show helps screen

See [changelog-cli PyPI](https://pypi.org/project/changelog-cli/) for further information.


### Versioning
- Before releasing a new version, make sure the change log is up to date.
- Use `changelog release ...` to cut a new release in the change log.
- Use `changelog current` to get the new version number.
- Update `test_package/_version.py` with the new version number.
