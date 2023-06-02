#!/bin/bash

docker compose exec job touch /home/irisowner/incoming/folder1/1.txt
docker compose exec job touch /home/irisowner/incoming/folder1/2.txt
docker compose exec job touch /home/irisowner/incoming/folder1/3.txt
docker compose exec job touch /home/irisowner/incoming/folder1/4.txt
docker compose exec job touch /home/irisowner/incoming/folder2/1.txt
docker compose exec job touch /home/irisowner/incoming/folder2/2.txt
docker compose exec job touch /home/irisowner/incoming/folder2/3.txt

docker compose exec job bash -c 'echo "/home/irisowner/incoming/folder1/" > /home/irisowner/incoming/common/1.txt'
docker compose exec job bash -c 'echo "/home/irisowner/incoming/folder2/" > /home/irisowner/incoming/common/2.txt'
