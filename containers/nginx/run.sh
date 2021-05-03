#!/bin/bash
docker build --rm -t nginx-local . 
docker run -it --rm -d -p 80:80 --name nginx-local nginx-local
start chrome nginx.local