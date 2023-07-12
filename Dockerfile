FROM jekyll/jekyll:pages

WORKDIR /srv/jekyll

RUN gem install webrick