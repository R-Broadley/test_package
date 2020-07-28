SHELL := /bin/sh

PROJECT_SLUG := "test_package"
SOURCES := $(shell find $(PROJECT_SLUG) -name '*.py')
UNITTESTS := $(shell find "unittests" -name '*.py')
TOX_CONTAINER_DEPS = tox.ini
PYVER := $(shell python3 -c "from sys import version_info; print(f'{version_info.major}.{version_info.minor}')")

START_CONTAINER_CMD = ./buildscripts/start_container.sh $(PROJECT_SLUG)

.PHONY: all image package docs format	lint shell test	dev	clean

all: test

image:
	./buildscripts/build_image.sh $(PROJECT_SLUG)

package: $(SOURCES) setup.py $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e package

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

py%: $(SOURCES) $(UNITTESTS) $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e $@

coverage_report: .coverage $(TOX_CONTAINER_DEPS)
	$(START_CONTAINER_CMD) tox -e $@

requirements.txt: setup.py
	./buildscripts/update_requirements_txt.py

dev: export PYVERSION=$(PYVER)
dev: requirements_dev.txt tox.ini
	tox -e devenv
	source .venv/bin/activate && pip install -U pip -r $<

clean: $(TOX_CONTAINER_DEPS)
	rm -rf .tox
	$(START_CONTAINER_CMD) tox -e $@


