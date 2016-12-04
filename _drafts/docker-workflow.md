---
layout: post
title: Docker Workflow
description: TODO description
---

I have a my little routine with docker, i have few scripts so i don’t have to type the same things over and over, and it just works, and i have i little things that might be useful to you
My workflow changed i lot since i started with docker, at the begining i aws using docker-compose and loving it, but since we stated deployning containers docker-compose was not the best aprroach
Docker Compose
“Compose is a tool for defining and running multi-container Docker applications”
It works finne
Simple tip:
At the top of the, declare things that wont likely change
Keep the middle for things that will change often with the build
Things that will happend everytime you run a buiild


Docker compose doesn’t play well with deploying containers
Docker compose makes links containers easy, it simplifies orcastration

https://github.com/yurifrl/boilerplate
{% highlight shell %}
./q
./production.yml
./Dockerfile
./work.log
./TODO.md
./init.sh
./deploy.sh
./kube.yaml
./VERSION
{% endhighlight %}

Let's take a look at my work environment,  this is basically every one of my projects, i will go through every file.


{% highlight shell %}
# ./docker-compose.yml
version: '2'
services:
  web:
    image: mhart/alpine-node
    ports:
      - 81:81
    working_dir: /web
    command: npm run start
    volumes:
      - ./:/web
      - node_modules:/app/node_modules

volumes:
  node_modules:
    driver: local
{% endhighlight %}


This is probably my favorite file, here i use a alpine image to run my node apps, i just run a `docker-compose run --rm web npm install`, and that will fetch my dependencies, at the first run it will ask to create the volumes and you simply run `docker volume create --name=node_modules`




{% highlight shell %}
# ./init.sh
#!/bin/bash

# Use deploy directory as working directory
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
cd "$parent_path"

# halt on any error
set -e

dg() {
  docker run --rm -ti -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    --volumes-from gcloud-config yurifl/gcloud $@
}

/usr/bin/vim ../VERSION

VERSION=$(cat ../VERSION)

Docker-compose -f production.yml build

docker tag docker-workflow "gcr.io/yebo-project/docker-workflow:latest"
dg gcloud docker push "gcr.io/yebo-project/docker-workflow:latest"

echo "dg kubectl create -f ./config/kube.yaml"
echo "dg kubectl delete -f ./config/kube.yaml"

dg kubectl get svc
dg kubectl get rc
{% endhighlight %}





