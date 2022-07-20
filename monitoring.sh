#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}

if exists docker; then
echo 'docker already installed'
else
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

cd $HOME
sudo git clone https://github.com/doma2k/monNear.git

IPADDR=$(curl ifconfig.me)

if [ ! $TELEGRAMTOKEN ]; then
echo -e "\e[31mGet bot token https://t.me/botfather .\e[39m"
read -p "Enter telegram token: " TELEGRAMTOKEN
echo 'export TELEGRAMTOKEN='\"${TELEGRAMTOKEN}\" >> $HOME/.bash_profile
fi
echo -e '\n\e[42mYour bot token :' $TELEGRAMTOKEN '\e[0m\n'

if [ ! $CHATID ]; then
echo -e "\e[31mInvite https://t.me/getidsbot or https://t.me/RawDataBot to your group and get your group id from the chat id field .\e[39m"
read -p "Enter chat id : " CHATID
echo 'export TELEGRAMTOKEN='\"${CHATID}\" >> $HOME/.bash_profile
fi
echo -e '\n\e[42mYour chat id :' $CHATID '\e[0m\n'
