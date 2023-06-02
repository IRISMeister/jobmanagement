#!/bin/bash

./add-files.sh
docker compose exec job bash -c 'echo "/home/irisowner/incoming/folder1/" > /home/irisowner/incoming/common/1.txt'
docker compose exec job bash -c 'echo "/home/irisowner/incoming/folder2/" > /home/irisowner/incoming/common/2.txt'
