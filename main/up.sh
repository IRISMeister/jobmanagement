#!/bin/bash

docker compose up -d
echo "JOB SMP | http://localhost:52873/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=JOB"
echo "TASK SMP | http://localhost:52874/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK"
