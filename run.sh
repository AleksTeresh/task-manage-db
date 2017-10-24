#! /bin/bash

docker stop task-manage-db
docker rm task-manage-db
docker build -t task-manage-db .
docker run --name task-manage-db -e POSTGRES_DB=task-manage -P -p 5432:5432 -d task-manage-db
