# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `rsconstruct.toml:27,31` - ruff and mypy list `exercises` in `src_dirs`, but `exercises/` holds no Python (the only `.py` is `scripts/test_solution.py`); and `rsconstruct.toml:36` lists `scripts` for shellcheck, which holds no shell scripts. Make each processor name only the folders that hold its file type: ruff/mypy `["scripts"]`, shellcheck `["exercises"]`.

## Low

- `exercises/22_del_key_value_from_file/solution.sh:2` - `. |= delpaths([[$delkey]])` is a needlessly indirect way to teach deleting a key; `del(.[$delkey])` (or `del(.size)`) is the idiomatic jq the exercise text asks for, and `delpaths` can get its own exercise if it is meant to be shown.
