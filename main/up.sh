#!/bin/bash

docker compose up -d
echo "JOB SMP | http://localhost:9203/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=JOB"
echo "TASK SMP | http://localhost:9204/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK"
