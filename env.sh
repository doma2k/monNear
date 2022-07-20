#!/bin/bash

echo -e "\e[31mGet bot token https://t.me/botfather .\e[39m"
read -p "Enter telegram token: " TELEGRAMTOKEN
echo 'export TELEGRAMTOKEN='\"${TELEGRAMTOKEN}\" >>$HOME/.bash_profile
echo -e '\n\e[42mYour bot token :' $TELEGRAMTOKEN '\e[0m\n'
echo -e "\e[31mInvite https://t.me/getidsbot or https://t.me/RawDataBot to your group and get your group id from the chat id field .\e[39m"
read -p "Enter chat id : " CHATID
echo 'export TELEGRAMTOKEN='\"${CHATID}\" >>$HOME/.bash_profile
echo -e '\n\e[42mYour chat id :' $CHATID '\e[0m\n'
echo 'source $HOME/.bashrc' >>$HOME/.bash_profile
. $HOME/.bash_profile
