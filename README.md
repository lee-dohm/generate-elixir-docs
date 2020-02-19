# Generate Elixir Docs Action

A GitHub Action that generates the documentation for an Elixir project to be published by a separate Action.

## Use

Publish the Elixir documentation for your project to GitHub Pages on every push to the `master` branch:

```yaml
on:
  push:
    branches:
      - master
jobs:
  generateDocs:
    name: Generate project documentation
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-elixir@v1 # See documentation for examples of input parameters
      - name: Build docs
        uses: lee-dohm/generate-elixir-docs@v1
      - name: Publish to Pages
        uses: peaceiris/actions-gh-pages@v1.0.1
        env:
          ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
          PUBLISH_DIR: ./doc
          PUBLISH_BRANCH: gh-pages
```

### Inputs

- `docsDir` -- Directory where the documentation should be generated _(defaults to `$GITHUB_WORKSPACE/doc`)_
- `tagVersionWithHash` -- If set, the version number in `mix.exs` will be appended with the first seven characters of `$GITHUB_SHA`

## License

[MIT](LICENSE.md)
