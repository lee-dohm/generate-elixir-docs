FROM elixir:1.8-alpine

LABEL "com.github.actions.name"="Generates Elixir documentation"
LABEL "com.github.actions.description"="Generates Elixir project documentation to be published"
LABEL "com.github.actions.icon"="edit"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/lee-dohm/generate-elixir-docs"
LABEL "homepage"="https://github.com/lee-dohm/generate-elixir-docs"
LABEL "maintainer"="Lee Dohm <lee-dohm@github.com>"

RUN set -xe \
    && apk add sed \
    && apk add build-base

COPY ./entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
