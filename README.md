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
    - uses: actions/checkout@master
    - name: Build docs
      uses: lee-dohm/generate-elixir-docs@master
    - name: Publish to Pages
      uses: peaceiris/actions-gh-pages@v1.0.1
      env:
        ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
        PUBLISH_DIR: ./doc
        PUBLISH_BRANCH: gh-pages
```

## Configuration

| Key | Description | Type | Required |
|-----|-------------|------|----------|
| `DOCS_DIR` | Directory where the documentation should be generated. _(Defaults to `$GITHUB_WORKSPACE/doc`)_ | `env` | No |
| `TAG_VERSION_WITH_HASH` | If set, the version number in `mix.exs` will be appended with `+${GITHUB_SHA:0:7}` | `env` | No |

## License

[MIT](LICENSE.md)
