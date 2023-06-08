#!/bin/bash

docker compose up -d
docker compose exec -u root job service ssh start
sleep 1
docker compose exec -u root task1 service ssh start
sleep 1
docker compose exec -u root task2 service ssh start
echo "JOB SMP | http://localhost:52873/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=JOB"
echo "TASK SMP | http://localhost:52874/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK"
