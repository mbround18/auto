# [Auto Release by Intuit](https://intuit.github.io/auto/docs)

This is an action wrapping the auto binary for GitHub Action usage.

[if you would like to learn more about the Auto cli, please click here!](https://intuit.github.io/auto/docs)

Disclaimer

All work and credit go to the original creators of the auto project.
This is merely a little bit of shell code that installs it from their GitHub repo and adds it to a path.
Any issues with the action please file them here, but any issues with trunk itself please log them on their GitHub repo.

[Having trunk issues or questions? Click here to navigate to auto by Intuits GitHub repo.](https://intuit.github.io/auto/docs)

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
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0 # <- Suggested to get all tags
          token: ${{ secrets.GH_TOKEN }} # <- This is required

      - name: release
        uses: mbround18/auto@v1.5.0
        with:
          token: ${{ secrets.GH_TOKEN }} # <- This is for auto
```
