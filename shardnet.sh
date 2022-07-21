#!/bin/bash
exists() {
  command -v "$1" >/dev/null 2>&1
}

if exists curl; then
  echo ''
else
  sudo apt update && sudo apt install curl -y <"/dev/null"
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

function setupNode {

  export NEAR_ENV=shardnet
  echo 'export NEAR_ENV='\"${NEAR_ENV}\" >>$HOME/.bash_profile
  echo -e '\n\e[42mYour chain :' $NEAR_ENV '\e[0m\n'
  echo 'source $HOME/.bashrc' >>$HOME/.bash_profile
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
  sudo tee $HOME/neard.service <<EOF >/dev/null
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
  if [[ $(service neard status | grep active) =~ "running" ]]; then
    echo -e "Your Neard node \e[32minstalled and works\e[39m!"
    echo -e "You can check node status by the command \e[7mservice neard status\e[0m or \e[7mjournalctl -u neard -f\e[0m"
  else
    echo -e "Your Near node \e[31mwas not installed correctly\e[39m, please reinstall."
  fi

}

function setupPing {

  if exists crontab; then
    echo ''
  else
    sudo apt update && sudo apt install crontab -y <"/dev/null"
  fi
  sudo mkdir -p $HOME/monNear
  read -p "Enter account id : " YOUR_ACCOUNT_ID
  echo 'export YOUR_ACCOUNT_ID='\"${YOUR_ACCOUNT_ID}\" >>$HOME/.bash_profile
  echo -e '\n\e[42mYour chain :' $YOUR_ACCOUNT_ID '\e[0m\n'

  read -p "Enter your pool id: " YOUR_POOL_ID
  echo 'export YOUR_POOL_ID='\"${YOUR_POOL_ID}\" >>$HOME/.bash_profile
  echo -e '\n\e[42mYour chain :' $YOUR_POOL_ID '\e[0m\n'

  sudo tee $HOME/monNear/ping.sh <<EOF >/dev/null
  near call $YOUR_POOL_ID.factory.shardnet.near ping '{}' --accountId $YOUR_ACCOUNT_ID.shardnet.near --gas=300000000000000 
EOF
  sudo chmod +x $HOME/monNear/ping.sh
  (
    crontab -l 2>/dev/null
    echo "*/5 * * * * $HOME/monNear/ping.sh"
  ) | crontab -

}

function installMonitoring {

  if exists docker; then
    echo 'docker already installed'
  else
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  fi

  cd $HOME/monNear

  IPADDR=$(curl ifconfig.me)
  echo 'export IPADDR='\"${IPADDR}\" >>$HOME/.bash_profile

  echo -e "\e[31mGet bot token https://t.me/botfather .\e[39m"
  read -p "Enter telegram token: " TELEGRAMTOKEN
  echo 'export TELEGRAMTOKEN='\"${TELEGRAMTOKEN}\" >>$HOME/.bash_profile
  echo -e '\n\e[42mYour bot token :' $TELEGRAMTOKEN '\e[0m\n'

  echo -e "\e[31mInvite https://t.me/getidsbot or https://t.me/RawDataBot to your group and get your group id from the chat id field .\e[39m"
  read -p "Enter chat id : " CHATID
  echo 'export CHATID='\"${CHATID}\" >>$HOME/.bash_profile
  echo -e '\n\e[42mYour chat id :' $CHATID '\e[0m\n'

  echo 'source $HOME/.bashrc' >>$HOME/.bash_profile
  . $HOME/.bash_profile

  sed -i "s/IPADDR/"$IPADDR"/g" $HOME/monNear/prometheus/prometheus.yml
  cd $HOME/monNear
  
  read -p "Enter account id : " YOUR_ACCOUNT_ID
  echo 'export YOUR_ACCOUNT_ID='\"${YOUR_ACCOUNT_ID}\" >>$HOME/.bash_profile

  sudo docker run -dit \
    --restart always \
    --name near-exporter \
    --network=host \
    -p 9333:9333 \
    masknetgoal634/near-prometheus-exporter:latest /dist/main -accountId $YOUR_ACCOUNT_ID.shardnet.near

  docker-compose up -d

}

PS3='Please enter your choice (input your option number and press enter): '
options=("Install Node and CLI" "Install Ping" "Install monitoring and alertbot")
select opt in "${options[@]}"; do
  case $opt in
  "Install Node and CLI")
    echo -e '\n\e[42mYou choose install...\e[0m\n' && sleep 1
    setupNode
    break
    ;;
  "Install Ping")
    echo -e '\n\e[33mYou choose Install Ping...\e[0m\n' && sleep 1
    setupPing
    echo -e '\n\e[33mYour node pinged!\e[0m\n' && sleep 1
    break
    ;;
  "Install monitoring and alertbot")
    echo -e '\n\e[33mYou choose Install monitoring and alertbot...\e[0m\n' && sleep 1
    installMonitoring
    echo -e '\n\e[33mYour node is monitored!\e[0m\n' && sleep 1
    break
    ;;
  esac
done
