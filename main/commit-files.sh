#!/bin/bash

# 下記のsftp経由でのputに相当する操作を実行。
#docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
#Connected to job.
#sftp> put 1.txt incoming/folder1/1.txt
#sftp> put 2.txt incoming/folder1/2.txt
#sftp> put 3.txt incoming/folder1/3.txt
#sftp> put 4.txt incoming/folder1/4.txt
#sftp> put done.txt incoming/common/done1.txt

docker compose exec job bash -c "echo 123 >> /home/sftp_user1/incoming/folder1/1.txt"
docker compose exec job bash -c "echo 123 >> /home/sftp_user1/incoming/folder1/2.txt"
docker compose exec job bash -c "echo 123 >> /home/sftp_user1/incoming/folder1/3.txt"
docker compose exec job bash -c "echo 123 >> /home/sftp_user1/incoming/folder1/4.txt"

docker compose exec job bash -c "echo 123 >> /home/sftp_user2/incoming/folder2/1.txt"
docker compose exec job bash -c "echo 123 >> /home/sftp_user2/incoming/folder2/2.txt"
docker compose exec job bash -c "echo 123 >> /home/sftp_user2/incoming/folder2/3.txt"

# 上記の更新を伝えるセマフォファイルを作成
docker compose exec job bash -c 'echo "/home/sftp_user1/incoming/folder1/" > /home/irisowner/incoming/common/sftp_user1/done1.txt'
docker compose exec job bash -c 'echo "/home/sftp_user2/incoming/folder2/" > /home/irisowner/incoming/common/sftp_user2/done2.txt'
