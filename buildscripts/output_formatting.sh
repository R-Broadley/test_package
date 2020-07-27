#!/bin/sh

function end_section {
	echo
	printf "%0.s$1" {1..79}
	printf "\n\n"
}
