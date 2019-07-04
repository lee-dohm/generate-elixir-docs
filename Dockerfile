FROM elixir:latest

LABEL "com.github.actions.name"="Generates Elixir documentation"
LABEL "com.github.actions.description"="Generates Elixir project documentation to be published"
LABEL "com.github.actions.icon"="edit"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/lee-dohm/generate-elixir-docs"
LABEL "homepage"="https://github.com/lee-dohm/generate-elixir-docs"
LABEL "maintainer"="Lee Dohm <lee-dohm@github.com>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential

COPY ./entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
