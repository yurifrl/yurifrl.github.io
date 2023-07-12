FROM jekyll/jekyll:pages

WORKDIR /srv/jekyll

RUN gem install webrick

CMD ["jekyll", "serve", "--watch", "--drafts", "--host", "0.0.0.0"]