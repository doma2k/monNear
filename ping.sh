#!/bin/sh
# Ping call to renew Proposal added to crontab
exists()
{
  command -v "$1" >/dev/null 2>&1
}

if exists crontab; then
echo ''
else
  sudo apt update && sudo apt install crontab -y < "/dev/null"
fi

if [ ! $USER_ID ]; then
  read -p "Enter system user name: " USER_ID
  echo 'export USER_ID='\"${USER_ID}\" >> $HOME/.bash_profile
fi
echo -e '\n\e[42mYour chain :' $USER_ID '\e[0m\n'

if [ ! $YOUR_ACCOUNT_ID ]; then
  read -p "Enter account id: " YOUR_ACCOUNT_ID
  echo 'export YOUR_ACCOUNT_ID='\"${YOUR_ACCOUNT_ID}\" >> $HOME/.bash_profile
fi
  echo -e '\n\e[42mYour chain :' $YOUR_ACCOUNT_ID '\e[0m\n'

if [ ! $YOUR_POOL_ID ]; then
  read -p "Enter your pool id: " YOUR_POOL_ID
  echo 'export YOUR_POOL_ID='\"${YOUR_POOL_ID}\" >> $HOME/.bash_profile
fi
  echo -e '\n\e[42mYour chain :' $YOUR_POOL_ID '\e[0m\n'

export NEAR_ENV=shardnet
export LOGS=/home/$USER_ID/logs
export POOLID=$YOUR_POOL_ID
export ACCOUNTID=$YOUR_ACCOUNT_ID
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile



echo "---" >> $LOGS/all.log
date >> $LOGS/all.log
near call $POOLID.factory.shardnet.near ping '{}' --accountId $ACCOUNTID.shardnet.near --gas=300000000000000 >> $LOGS/all.log
near proposals | grep $POOLID >> $LOGS/all.log
near validators current | grep $POOLID >> $LOGS/all.log
near validators next | grep $POOLID >> $LOGS/all.log
