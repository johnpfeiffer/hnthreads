# hnthreads

Hacker News thread analysis, with one directory per HN item ID.

## Layout

```text
threads/
  <item-id>/
    insightful.json
    astroturf.json  # launch/vendor analyses, when applicable
    noise.json      # signal-to-noise analyses, when applicable
```

Each JSON artifact records its thread metadata and analysis methodology. Classifications describe rhetorical patterns, not proof that an account is a bot or shill.

## Project skills

The reusable workflows live in `.agents/skills/`:

- `fetch-hacker-news`: fetch a complete story and comment tree, and reconcile comment counts.
- `analyze-hacker-news-thread`: classify comments and produce the JSON analysis artifacts.

## Validation

Install `jq`, then validate every JSON artifact from the repository root:

```bash
./validate-json.sh
```
