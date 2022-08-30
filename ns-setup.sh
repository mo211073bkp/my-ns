#!/bin/sh

sudo apt-get update
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo docker run hello-world
sudo systemctl status docker

#Ставим и запускаем Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1
docker ps

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

#curl https://raw.githubusercontent.com/mo211073bkp/test/main/docker-compose.yml --output docker-compose.yml
#docker-compose up -d

echo "Ваш секретный ключ для доступа к Nightscout (запишите!):"
echo "secret: $secret"
