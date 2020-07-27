"""Configuration for Pytest."""

from sys import version_info


def pytest_html_report_title(report):
    """Modify the title of pytest-html report.

    Args:
        report(pytest_html.plugin.HTMLReport): report whose title should be modified

    """
    pyversion = f"{version_info.major}.{version_info.minor}"
    test_type = report.title.split(".")[0].replace("_", " ").title()
    report.title = f"Python Boilerplate {test_type} Results ({pyversion})"
