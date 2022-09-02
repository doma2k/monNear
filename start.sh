#!/bin/bash
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${my_root_password}; echo ${my_root_password}) | passwd root
service ssh restart
runsvdir -P /etc/service &
nodepid=0
t=1
sleep 5
if [[ -e ~/.near/validator_key.json ]]
then
	while [[ "$t" -eq 1 ]]
	do
		SYNH
		date
		sleep 5m
	done
fi

apt update && apt upgrade -y
apt install sudo nano -y
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install build-essential nodejs -y
PATH="$PATH"
node -v
npm -v
sudo npm install -g near-cli
export NEAR_ENV=testnet
echo 'export NEAR_ENV=testnet' >> ~/.bashrc
near proposals

echo  ===================near установлен ===================

sleep 10
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo
sudo apt install python3-pip -y
USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"
sudo apt install clang build-essential make -y
curl "https://sh.rustup.rs" -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup update stable
source $HOME/.cargo/env
sleep 20
cd /root/
git clone "https://github.com/near/nearcore"
sleep 5
cd nearcore
git fetch
git checkout 1.29.0-rc.1
echo  ================= Начинаю сборку ==================
echo  =================== Start build ===================
sleep 5
cargo build -p neard --release --features shardnet
cp /root/nearcore/target/release/neard /usr/bin/
cd /root/
echo  =================== Завершена сборка ====================
echo  =================== Build s completed ===================
neard init --chain-id shardnet --download-genesis
ls /root/ -a 
ls /root/.near -a 
ls / -a 
echo  ======================= nearcore установлен =====================
echo  =================== install nearcore complete ===================
sleep 10
cd .near
rm config.json
wget -O /root/.near/config.json "https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/testnet/config.json"
sleep 5
sudo apt-get install awscli -y
pwd
sleep 10
cd /root/.near/
rm /root/.near/genesis.json
wget https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/testnet/genesis.json
sleep 10
aws s3 --no-sign-request cp s3://near-protocol-public/backups/testnet/rpc/latest .
LATEST=$(cat latest)
aws s3 --no-sign-request cp --no-sign-request --recursive s3://near-protocol-public/backups/testnet/rpc/$LATEST ~/.near/data
sleep 10
cd /root/.near/
pip3 install awscli --upgrade
echo все ОК
sleep 20
if  [[  -z $link_key  ]]
then
tail -200 /var/log/$binary/current
echo ====================================================================================================
echo ====== validator_key.json not found, please create and completed of registration your account ======
echo ====================================================================================================
echo ==== validator_key.json не обнаружен, пожалуйста создайте и завершите регистрацию вашего аккаунта ==
echo ====================================================================================================
echo ===================================================================================================================================
echo ===== Refer to instructions to address https://github.com/Dimokus88/near/blob/main/Guide_EN.md#create-and-register-a-validator ====
echo ===================================================================================================================================
echo === Обратитесь к инструкции по адресу https://github.com/Dimokus88/near/blob/main/Guide_RU.md#создаем-и-регистрируем-валидатора ===
echo ===================================================================================================================================
sleep infinity
fi
echo ===============================================================
echo ====== validator_key.json is found, start validator node ======
echo ===============================================================
echo ==== validator_key.json  обнаружен, запускаю ноду валидатора ==
echo ===============================================================
rm /root/.near/validator_key.json
wget -O /root/.near/validator_key.json $link_key 

#===========ЗАПУСК НОДЫ============
echo =Run node...=
cd /
binary=neard
mkdir /root/$binary
mkdir /root/$binary/log
    
cat > /root/$binary/run <<EOF 
#!/bin/bash
exec 2>&1
exec $binary run
EOF

chmod +x /root/$binary/run
LOG=/var/log/$binary

cat > /root/$binary/log/run <<EOF 
#!/bin/bash
mkdir $LOG
exec svlogd -tt $LOG
EOF

chmod +x /root/$binary/log/run
ln -s /root/$binary /etc/service
sleep 20
tail -200 /var/log/$binary/current
sleep 20
#===========================================================
while [[ "$t" -eq 1 ]]
do
tail -200 /var/log/$binary/current
date
sleep 5m
done
