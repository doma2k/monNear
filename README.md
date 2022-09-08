## ShardNet node & monitoring installation: <br /> 
Input in commandline:

```
sudo apt update && sudo apt install git -y #install git
export NEAR_ENV=shardnet # set var
git clone https://github.com/doma2k/monNear.git  #Clone repo
chmod +x $HOME/monNear/shardnet.sh #Add permission 
~/monNear/shardnet.sh #Start script
```
<img width="387" alt="Screen Shot 2022-09-08 at 16 11 28" src="https://user-images.githubusercontent.com/79820904/189130858-06402248-76c4-44ba-8d45-b25f5a531b98.png">
Usefull links:

*  Explorer: https://explorer.shardnet.near.org/
*  Wallet: https://wallet.shardnet.near.org/
*  Node activation guide : https://github.com/near/stakewars-iii/blob/main/challenges/002.md#activating-the-node-as-validator
*  Mounting a staking pool : https://github.com/near/stakewars-iii/blob/main/challenges/003.md#3-mounting-a-staking-pool
*  Near-Lake-Indexer : https://github.com/near/near-lake-indexer

Ports description:

* prometheus: exposing port: 9095
* grafana: exposing port: 3000 (login: admin pass: admin) 
* near-explorer: exposing port: 9333 
* custom S3 storage port: 9000

Alertbot: 
* create bot with https://t.me/botfather and use token for installation
* get chat id with https://t.me/RawDataBot and use token for installation

Bot will notify about critical events with network and server.

<img width="1440" alt="Screen Shot 2022-09-07 at 13 02 30" src="https://user-images.githubusercontent.com/79820904/188851418-42ffaba6-2696-4423-8eba-5b5efab24eb2.png">



Contacts:
###### Telegram: https://t.me/domanodes Discord: https://discord.com/users/doma2k#4006
