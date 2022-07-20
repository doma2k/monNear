#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://domanodes.com/.well-known/logo.sh | bash && sleep 1
if grep -q avx2 /proc/cpuinfo; then
	  echo ""
else
	  echo -e "\e[31mInstallation is not possible, your server does not support AVX2, change your server and try again.\e[39m"
fi    

export NEAR_ENV=shardnet
echo 'export NEAR_ENV='\"${NEAR_ENV}\" >> $HOME/.bash_profile
echo -e '\n\e[42mYour chain :' $NEAR_ENV '\e[0m\n'
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile


sudo apt update && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install build-essential nodejs -y
PATH="$PATH"

sudo npm install -g near-cli -y
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python protobuf-compiler libssl-dev pkg-config clang llvm -y
sudo apt install python3-pip -y

USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"

sudo apt install clang build-essential make -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
source $HOME/.cargo/env


cd $HOME
git clone https://github.com/near/nearcore
cd nearcore
git fetch
git checkout 8448ad1ebf27731a43397686103aa5277e7f2fcf
cargo build -p neard --release --features shardnet
./target/release/neard --home ~/.near init --chain-id shardnet --download-genesis
rm ~/.near/config.json
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json

cd ~/.near
wget https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/genesis.json

sudo tee <<EOF >/dev/null $HOME/neard.service
[Unit]
Description=NEARd Daemon Service
After=network-online.target
[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME/.near
ExecStart=$HOME/nearcore/target/release/neard run
Restart=on-failure
RestartSec=30
KillSignal=SIGINT
TimeoutStopSec=45
KillMode=mixed
[Install]
WantedBy=multi-user.target
EOF

sudo mv $HOME/neard.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable neard
sudo systemctl restart neard
if [[ `service neard status | grep active` =~ "running" ]]; then
  echo -e "Your Neard node \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice neard status\e[0m or \e[7mjournalctl -u neard -f\e[0m"
else
  echo -e "Your Near node \e[31mwas not installed correctly\e[39m, please reinstall."
fi

