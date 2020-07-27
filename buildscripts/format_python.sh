#!/bin/sh

BUILDSCRIPTS="$(dirname "$0")"
PACKAGENAME="$1"

source "$BUILDSCRIPTS/output_formatting.sh"

INCLUDEFILES="setup.py $PACKAGENAME unittests"

if [ "$2" = "--check" ]
then
	function run_isort {
		echo "Checking If Imports Need Sorting..."
		isort --recursive --atomic --check $INCLUDEFILES
	}

	function run_black {
		echo "Checking If Black Would Make Changes..."
		black --check $INCLUDEFILES
	}
else
	function run_isort {
		echo "Sorting Imports..."
		isort --recursive --atomic $INCLUDEFILES
	}

	function run_black {
		echo "Formatting with Black..."
		black $INCLUDEFILES
	}
fi

# Sort imports
run_isort
isort_result=$?
end_section "-"

# Run black auto formatter
run_black
black_result=$?
end_section "-"

if [ $black_result -ne 0 ] || [ $isort_result -ne 0 ]
then
	exit 1
fi
