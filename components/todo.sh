#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=msarathkumar.online

OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG
Stat $?

Head "Adding user and changing directory"
useradd -m -s /bin/bash app &>>$LOG
cd /home/app/
Stat $?

Head "Downloading Component"
DOWNLOAD_COMPONENT
cd todo/
Stat $?

Head "Installing NPM"
npm install --save-dev  --unsafe-perm node-sass &>>$LOG
Stat $?

Head "pass the EndPoints in Service File"
sed -i -e "s/REDIS_ENDPOINT/redis.msarathkumar.online/" systemd.service
Stat $?

Head "Setup the systemd Service"
mv systemd.service /etc/systemd/system/todo.service &>>$LOG
systemctl daemon-reload && systemctl start todo && systemctl enable todo &>>$LOG
Stat $?