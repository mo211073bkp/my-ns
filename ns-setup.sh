#!/bin/sh

sudo docker run hello-world

echo Итак, немного настроек
echo
echo Введите имя домена, на котором ваш Nightscout будет доступен:
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
