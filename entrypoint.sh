#!/bin/sh

# Exit on failure
set -e

if [ -z "$DOCS_DIR" ]; then
  DOCS_DIR="$GITHUB_WORKSPACE/doc"
fi

update_file()
{
  REGEX=$1
  REPLACEMENT=$2
  shift; shift;
  FILES=$@

  sed -E -i .backup "s/$REGEX/$REPLACEMENT/g" $FILES
}

echo "==> Locally-install Rebar and Hex"
mix local.hex --force
mix local.rebar --force

echo "==> Install mix dependencies"
mix deps.get

echo "==> Tag mix version number"
hash=$(echo "$GITHUB_SHA" | cut -c1-7)
update_file "version: \"([^\"]+)\"" "version: \"\1+$hash\"" mix.exs

echo "==> Generate docs"
mix docs --output "$DOCS_DIR"
