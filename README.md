## ShardNet node & monitoring installation: <br /> 
Input in commandline:

```
sudo apt update && sudo apt install git -y #install git
export NEAR_ENV=shardnet # set var
git clone https://github.com/doma2k/monNear.git  #Clone repo
chmod +x $HOME/monNear/shardnet.sh #Add permission 
~/monNear/shardnet.sh #Start script
```

<img width="220" alt="Screen Shot 2022-07-21 at 9 18 43" src="https://user-images.githubusercontent.com/79820904/180143201-da262fac-8ff9-4ec4-830c-c7b5930fd33a.png"> <br />
<br />
Usefull links:

*  Explorer: https://explorer.shardnet.near.org/
*  Wallet: https://wallet.shardnet.near.org/
*  Node activation guide : https://github.com/near/stakewars-iii/blob/main/challenges/002.md#activating-the-node-as-validator
*  Mounting a staking pool : https://github.com/near/stakewars-iii/blob/main/challenges/003.md#3-mounting-a-staking-pool

## Monitoring tool description:

* prometheus: exposing port: 9095
* grafana: exposing port: 3000 (login: admin pass: admin) 
* near-explorer: exposing port: 9333 

Alertbot: 
* create bot with https://t.me/botfather and use token for installation
* get chat id with https://t.me/RawDataBot and use token for installation

Bot will notify about critical events with network and server.

<img width="1438" alt="Screen Shot 2022-07-21 at 16 07 16" src="https://user-images.githubusercontent.com/79820904/180241361-4532166c-4f8b-4b65-abf2-f1690d71fd14.png">

## Shardnet indexer and custom bucket guide:
* Download near-lake-indexer and build binary:
```
cd $HOME
git clone https://github.com/near/near-lake-indexer.git
cd $HOME/near-lake-indexer && cargo build --release
```
* Configure near-lake-indexer:
```
./target/release/near-lake --home ~/.near init --chain-id shardnet --download-config --download-genesis

rm ~/.near/config.json
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json

rm ~/.near/genesis.json
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/genesis.json
```
* Setup and run Custom S3 storage:
```
cd $HOME/near-lake-indexer
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
mkdir -p /data/ && MINIO_ROOT_USER=admin MINIO_ROOT_PASSWORD=password ./minio server /data
```
* Login to console and set 
Buckets => Summary => Access Policy = public
Configuration => Server Location = eu-central-1

* Set credentials in ~/.aws/credentials:
```
[default]
aws_access_key_id=admin
aws_secret_access_key=password
```
* run near-lake-indexer
```
cd $HOME/near-lake-indexer
./target/release/near-lake --home ~/.near run --endpoint http://127.0.0.1:9000 --bucket near-lake-custom --region eu-central-1 sync-from-latest
```

Contacts:
###### Telegram: https://t.me/domanodes Discord: https://discord.com/users/doma2k#4006
