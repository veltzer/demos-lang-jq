#!/bin/bash -e
# Test that every exercise's solution.sh, when run against its input.json,
# produces exactly the committed output.json.
#
# Each solution.sh writes to output.json in its own directory, so to avoid
# clobbering the committed expected output we copy each exercise into a
# temporary directory, run the solution there, and diff the freshly produced
# output.json against the committed one.

here=$(cd "$(dirname "$0")" && pwd)
exercises_dir="$here/exercises"

failures=0
total=0

for dir in "$exercises_dir"/*/; do
	name=$(basename "$dir")
	# Only consider directories that actually contain an exercise.
	[ -f "$dir/solution.sh" ] || continue
	[ -f "$dir/input.json" ] || { echo "FAIL $name: missing input.json"; failures=$((failures + 1)); continue; }
	[ -f "$dir/output.json" ] || { echo "FAIL $name: missing output.json"; failures=$((failures + 1)); continue; }

	total=$((total + 1))

	tmp=$(mktemp -d)
	# shellcheck disable=SC2064
	trap "rm -rf '$tmp'" EXIT

	cp "$dir/solution.sh" "$dir/input.json" "$tmp/"
	expected="$dir/output.json"

	if ! (cd "$tmp" && bash ./solution.sh) 2>"$tmp/err"; then
		echo "FAIL $name: solution.sh exited non-zero"
		sed 's/^/    /' "$tmp/err"
		failures=$((failures + 1))
		rm -rf "$tmp"
		trap - EXIT
		continue
	fi

	if [ ! -f "$tmp/output.json" ]; then
		echo "FAIL $name: solution.sh did not produce output.json"
		failures=$((failures + 1))
		rm -rf "$tmp"
		trap - EXIT
		continue
	fi

	if diff -u "$expected" "$tmp/output.json" >"$tmp/diff"; then
		echo "PASS $name"
	else
		echo "FAIL $name: produced output differs from committed output.json"
		sed 's/^/    /' "$tmp/diff"
		failures=$((failures + 1))
	fi

	rm -rf "$tmp"
	trap - EXIT
done

echo
if [ "$failures" -eq 0 ]; then
	echo "All $total exercises passed."
else
	echo "$failures of $total exercises FAILED."
	exit 1
fi
