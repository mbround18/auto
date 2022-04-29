# [Auto Release by Intuit](https://intuit.github.io/auto/docs)

This is an action wrapping the auto binary for GitHub Action usage.

## Usage

[**Must have a .autorc file**](https://intuit.github.io/auto/docs/configuration/autorc)

```yaml
# This is an example pipeline
name: Release
on: [push]
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0 # <- Suggested to get all tags
          token: ${{ secrets.GH_TOKEN }} # <- This is required

      - name: release
        uses: mbround18/auto@v1
        with:
          token: ${{ secrets.GH_TOKEN }} # <- This is for auto
```
