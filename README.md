## ShardNet node & monitoring installation: <br /> 
Input in commandline:

```
sudo apt update && sudo apt install git -y #install git
export NEAR_ENV=shardnet # set var
git clone https://github.com/doma2k/monNear.git  #Clone repo
chmod +x $HOME/monNear/shardnet.sh #Add permission 
~/monNear/shardnet.sh #Start script
```
<img width="407" alt="Screen Shot 2022-07-27 at 13 54 07" src="https://user-images.githubusercontent.com/79820904/181230474-3248bcf3-9b25-4e55-9950-a9a8796de171.png">
 <br />
<br />
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

<img width="1438" alt="Screen Shot 2022-07-21 at 16 07 16" src="https://user-images.githubusercontent.com/79820904/180241361-4532166c-4f8b-4b65-abf2-f1690d71fd14.png">


Contacts:
###### Telegram: https://t.me/domanodes Discord: https://discord.com/users/doma2k#4006
