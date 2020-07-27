SHELL := /bin/sh

PROJECT_SLUG := "test_package"
SOURCES := $(shell find "test_package" -name '*.py')
UNITTESTS := $(shell find "unittests" -name '*.py')
TOX_CONTAINER_DEPS = tox.ini image
PYVER := $(shell python3 -c "from sys import version_info; print(f'{version_info.major}.{version_info.minor}')")

START_CONTAINER_CMD = ./buildscripts/start_container.sh $(PROJECT_SLUG)

.PHONY:
	all
	image
	dist
	docs
	format
	lint
	shell
	test
	dev
	clean

all: test

image:
	./buildscripts/build_image.sh $(PROJECT_SLUG)

dist: $(SOURCES) setup.py $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e wheel

docs: $(SOURCES) docs/conf.py $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e $@

format: $(SOURCES) $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e $@

lint: $(SOURCES) $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e $@

shell: image
	./buildscripts/start_container.sh --entrypoint /bin/bash $(PROJECT_SLUG)

test: $(SOURCES) $(UNITTESTS) $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox

requirements.txt: setup.py
	./buildscripts/update_requirements_txt.py

dev: export PYVERSION=$(PYVER)
dev: requirements_dev.txt tox.ini
	tox -e devenv
	source .venv/bin/activate && pip install -U pip -r $<

clean:
	./buildscripts/clean.sh
