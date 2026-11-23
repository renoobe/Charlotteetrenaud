#!/usr/bin/env bash
# Assemble index.html (page autonome) à partir de pile.html (fragment publié en Artifact).
set -e
cd "$(dirname "$0")"
{
  printf '<!doctype html>\n<html lang="fr">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  cat pile.html
  printf '\n</html>\n'
} > index.html
