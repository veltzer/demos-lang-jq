#!/usr/bin/env python
"""Check that an exercise's solution.sh reproduces its committed output.json.

Takes one or more solution.sh paths (rsconstruct's script processor appends the
discovered files to the command line). For each one, the solution is run in a
temporary directory against a copy of the exercise's input.json, and the
output.json it produces is compared to the committed one.

Running in a temporary directory matters: each solution.sh writes output.json
into its own working directory, so running it in place would clobber the
committed expected output.
"""

import argparse
import filecmp
import pathlib
import shutil
import subprocess
import sys
import tempfile


def check(solution: pathlib.Path) -> bool:
    """Run one solution and compare its output to the committed output.json.

    Returns True if the exercise passed.
    """
    exercise = solution.parent
    name = exercise.name
    expected = exercise / "output.json"
    source = exercise / "input.json"

    for required in (source, expected):
        if not required.is_file():
            print(f"FAIL {name}: missing {required.name}", file=sys.stderr)
            return False

    with tempfile.TemporaryDirectory() as tmpdir:
        tmp = pathlib.Path(tmpdir)
        shutil.copy(solution, tmp)
        shutil.copy(source, tmp)

        result = subprocess.run(
            ["bash", "./solution.sh"],
            cwd=tmp,
            capture_output=True,
            text=True,
            check=False,
        )
        if result.returncode != 0:
            print(
                f"FAIL {name}: solution.sh exited {result.returncode}",
                file=sys.stderr,
            )
            sys.stderr.write(result.stderr)
            return False

        produced = tmp / "output.json"
        if not produced.is_file():
            print(f"FAIL {name}: solution.sh did not produce output.json", file=sys.stderr)
            return False

        if not filecmp.cmp(expected, produced, shallow=False):
            print(
                f"FAIL {name}: produced output differs from committed output.json",
                file=sys.stderr,
            )
            diff = subprocess.run(
                ["diff", "-u", str(expected), str(produced)],
                capture_output=True,
                text=True,
                check=False,
            )
            sys.stderr.write(diff.stdout)
            return False

    return True


def main() -> int:
    """Check every solution passed on the command line, returning an exit code."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "solutions",
        nargs="+",
        type=pathlib.Path,
        help="paths to solution.sh files",
    )
    args = parser.parse_args()

    failures = [s for s in args.solutions if not check(s)]
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
