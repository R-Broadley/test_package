#!/usr/bin/env python

"""The setup script."""

# this is only necessary when not using setuptools/distribute
from setuptools import find_packages, setup

VERSION_FILE = "test_package/_version.py"
with open(VERSION_FILE, "r") as vf:
    value = vf.readlines()[-1]
VERSION = value.split("=")[1].strip().strip('"')

with open("README.md") as readme_file:
    README = readme_file.read()

with open("CHANGELOG.md") as change_file:
    CHANGELOG = change_file.read()

REQUIREMENTS = []

NAME = "test_package"
AUTHOR = "Rob Broadley"
DESCRIPTION = "A test python package."

setup(
    author=AUTHOR,
    # Email address of lead maintainer
    author_email="[email protected]",
    python_requires=">=3.6",
    classifiers=[
        "Development Status :: 2 - Pre-Alpha",
        "Intended Audience :: Developers",
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
    ],
    description=DESCRIPTION,
    install_requires=REQUIREMENTS,
    long_description="\n\n".join([README, CHANGELOG]),
    long_description_content_type="text/markdown",
    include_package_data=True,
    keywords=["test_package"],
    name=NAME,
    packages=find_packages(include=["test_package", "test_package.*"]),
    test_suite="unittests",
    url="https://github.com/r-broadley/test_package",
    version=VERSION,
)
