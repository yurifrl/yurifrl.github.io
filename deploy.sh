#!/bin/bash

docker run --rm -it -w /srv/jekyll \
  -v $HOME/.ssh:/.ssh \
  -v $(pwd):/srv/jekyll \
  -v $(pwd)/.gitconfig:/root/.gitconfig \
  yurifl/octopress octopress deploy


