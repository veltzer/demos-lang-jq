# demos-lang-jq

Demos and exercises for the `jq` JSON processor.

## Layout

`exercises/` holds numbered exercises, one directory each. Every exercise has:

- `exercise.md` - the task.
- `input.json` - the input document.
- `solution.sh` - a jq one-liner that solves it.
- `output.json` - the expected output.

The build runs every `solution.sh` against its `input.json` and checks the result
matches `output.json`, so the solutions are verified in CI.
