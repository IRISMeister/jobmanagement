#!/bin/bash

# 下記のsftp経由でのputに相当する操作を実行。
#docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
#Connected to job.
#sftp> put 1.txt incoming/folder1/1.txt
#sftp> put 2.txt incoming/folder1/2.txt
#sftp> put 3.txt incoming/folder1/3.txt
#sftp> put 4.txt incoming/folder1/4.txt
#sftp> put done.txt incoming/common/done1.txt

docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder1/1.txt"
docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder1/2.txt"
docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder1/3.txt"
docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder1/4.txt"

docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder2/1.txt"
docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder2/2.txt"
docker compose exec task1 bash -c "echo 123 >> /home/sftp_user1/outgoing/folder2/3.txt"

# 上記の更新を伝えるセマフォファイルを作成
docker compose exec task1 bash -c "echo 123 >> /home/irisowner/outgoing/folder2/1.txt"
docker compose exec job bash -c 'echo "/home/sftp_user1/outgoing/folder1/" > /home/irisowner/outgoing/common/done1.sem'
docker compose exec job bash -c 'echo "/home/sftp_user1/outgoing/folder2/" > /home/irisowner/outgoing/common/done2.sem'
