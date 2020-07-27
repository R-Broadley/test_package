#!/usr/bin/env python
"""Write requirements.txt from setup.py."""

from distutils.core import run_setup

HEADER = [
    "# This file is auto generated, set requirements in setup.py",
    "# and run make requirements.txt to update this file.",
    "\n",
]


def main():
    """Write requirements.txt from setup.py."""
    result = run_setup("./setup.py", stop_after="init")
    with open("requirements.txt", "w") as req_file:
        req_file.write("\n".join(HEADER))
        req_file.write("\n".join(result.install_requires))


if __name__ == "__main__":
    main()
