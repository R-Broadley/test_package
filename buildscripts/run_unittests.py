#!/usr/bin/env python
"""Run unit tests and generate an HTML report."""

from argparse import ArgumentParser
import subprocess
from sys import argv, version_info


def runtests(package_name):
    """Run unit tests, check test coverage and generate HTML reports.

    Args:
        package_name (str): The name of the package to test.

    """
    pyversion = f"{version_info.major}.{version_info.minor}"
    pyversion_slug = pyversion.replace(".", "_")
    subprocess.run(
        [
            "coverage",
            "run",
            "--append",
            "--branch",
            "--context",
            f"py{pyversion}",
            "--source",
            f"{package_name}",
            "-m",
            "pytest",
            f"--html=reports/{pyversion_slug}_unit_test.html",
            "--self-contained-html",
            "unittests",
        ],
        check=True,
    )


def main(args):
    """Parse command line arguments and run unit tests.

    The required args are --name. Use --help for more information.

    Args:
        args (list[str]): the command line arguments.

    """
    parser = ArgumentParser(
        description="Script to run unit tests and generate HTML reports",
    )
    parser.add_argument(
        "--name", type=str, required=True, help="the name of the package to test"
    )
    parsed_args = parser.parse_args(args)
    runtests(parsed_args.name)


if __name__ == "__main__":
    main(argv[1:])
