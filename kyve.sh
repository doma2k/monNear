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
sleep 1 && curl -s https://api.nodes.guru/logo.sh | bash && sleep 1

if [ ! $STAKE ]; then
read -p "How many coins do you want to stake? " STAKE
echo 'export STAKE='\"${STAKE}\" >> $HOME/.bash_profile
fi
if [ ! $MNEMONIC ]; then
read -p "Paste your mnemonic: " MNEMONIC
echo 'export MNEMONIC='\"${MNEMONIC}\" >> $HOME/.bash_profile
fi
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile



apt update && apt install unzip -y
echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1
rm -rf $HOME/kyve
mkdir -p $HOME/kyve/service && cd $HOME/kyve
wget -O evm-linux.zip https://github.com/KYVENetwork/evm/releases/download/v1.0.3/evm-linux.zip
wget -O kyve-bitcoin-linux.zip https://github.com/kyve-org/bitcoin/releases/download/v0.0.0/kyve-bitcoin-linux.zip
wget -O kyve-solana-linux.zip https://github.com/kyve-org/solana/releases/download/v0.0.1/kyve-solana-linux.zip
wget -O kyve-zilliqa-linux.zip https://github.com/kyve-org/zilliqa/releases/download/v0.0.0/kyve-zilliqa-linux.zip
wget -O stacks-linux.zip https://github.com/kyve-org/stacks/releases/download/v0.0.2/stacks-linux.zip

unzip -o "*.zip"
chmod +x evm-linux kyve-solana-linux kyve-zilliqa-linux bitcoin-linux stacks-linux
mv evm-linux kyve-solana-linux kyve-zilliqa-linux bitcoin-linux stacks-linux /usr/local/bin/


echo "[Unit]
Description=Moonbeam
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which evm-linux) --poolId 0 --mnemonic \"$MNEMONIC\" --keyfile $HOME/arweave.json --initialStake $STAKE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/kyve/service/moonbeamd.service

echo "[Unit]
Description=Avalanche
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which evm-linux) --poolId 1 --mnemonic \"$MNEMONIC\" --keyfile $HOME/arweave.json --initialStake $STAKE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/kyve/service/avalanched.service

echo "[Unit]
Description=Stacks
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which stacks-linux) --poolId 2 --mnemonic \"$MNEMONIC\" --keyfile $HOME/arweave.json --initialStake $STAKE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/kyve/service/stacksd.service

echo "[Unit]
Description=Bitcoin
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which bitcoin-linux) --poolId 3 --mnemonic \"$MNEMONIC\" --keyfile $HOME/arweave.json --initialStake $STAKE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/kyve/service/bitcoind.service

echo "[Unit]
Description=Solana
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which kyve-solana-linux) --poolId 4 --mnemonic \"$MNEMONIC\" --keyfile $HOME/arweave.json --initialStake $STAKE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/kyve/service/solanad.service

echo "[Unit]
Description=Zilliqa
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which kyve-zilliqa-linux) --poolId 5 --mnemonic \"$MNEMONIC\" --keyfile $HOME/arweave.json --initialStake $STAKE
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/kyve/service/zilliqad.service

mv $HOME/kyve/service/* /etc/systemd/system/
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl daemon-reload
sudo systemctl restart systemd-journald
