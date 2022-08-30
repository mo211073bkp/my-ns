#!/bin/sh

sudo docker run hello-world

#Ставим и запускаем Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

echo Итак, немного настроек
echo
echo Введите имя пациента:
read title
echo "NS_TITLE=$title" >> .env
echo

echo
echo API secret, не менее 12 латинские буквы и цифры:
read secret
echo "NS_SECRET=$secret" >> .env
echo

curl https://raw.githubusercontent.com/mo211073bkp/test/docker-compose.yml --output docker-compose.yml
sudo docker-compose up -d

echo "Ваш секретный ключ для доступа к Nightscout (запишите!):"
echo "secret: $secret"
