# PR Changed Files Reference

## Getting the changed markdown files

To find which markdown files have been changed on the current branch compared to main, excluding deleted files:

```bash
git diff main --diff-filter=d --name-only -- '*.md'
```

The `--diff-filter=d` flag (lowercase) excludes deleted files so you only get files that exist on disk.

**Important:** Do not pipe this command through `grep` or other filters. Piped commands require separate permission approval. If you need to exclude paths (like `.claude/`), use multiple `--` path arguments or filter the results in your code instead of using shell pipes.

## Getting changed line numbers for a file

To find which specific lines were added or modified in a file (needed for matching CI behavior):

```bash
git diff main --unified=0 -- path/to/file.md
```

Parse the `@@ -old,count +new,count @@` hunk headers to extract the added line ranges. A line number is "changed" if it falls within a `+new,count` range.

## Determining the base branch

The examples above use `main` as the base branch. Check the repository's default branch if this differs. In this repository, the main branch is `main`.
