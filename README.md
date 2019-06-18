# Generate Elixir Docs Action

A GitHub Action that generates the documentation for an Elixir project to be published by a separate Action.

## Use

Publish the Elixir documentation for your project to GitHub Pages on every push to the `master` branch:

```
workflow "Publish documentation on push" {
  on = "push"
  resolves = ["Publish docs"]
}

action "Only on master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Generate docs" {
  needs = ["Only on master"]
  uses = "lee-dohm/generate-elixir-docs@master"
}

# See https://github.com/peaceiris/actions-gh-pages for more information about this Action
action "Publish docs" {
  needs = ["Generate docs"]
  uses = "peaceiris/actions-gh-pages@v1.0.1"
  secrets = ["ACTIONS_DEPLOY_KEY"]
  env = {
    PUBLISH_DIR = "./doc"
    PUBLISH_BRANCH = "gh-pages"
  }
}
```

## Configuration

| Key | Description | Type | Required |
|-----|-------------|------|----------|
| `DOCS_DIR` | Directory where the documentation should be generated. _(Defaults to `$GITHUB_WORKSPACE/doc`)_ | `env` | No |

## License

[MIT](LICENSE.md)
