## ShardNet node & monitoring installation: <br /> 
Clone repo and start script:

```
sudo apt update && sudo apt install git -y #install git
git clone https://github.com/doma2k/monNear.git  #Clone repo
chmod +x $HOME/monNear/shardnet.sh #Add permission 
~/monNear/shardnet.sh #Start script
```

<img width="220" alt="Screen Shot 2022-07-21 at 9 18 43" src="https://user-images.githubusercontent.com/79820904/180143201-da262fac-8ff9-4ec4-830c-c7b5930fd33a.png"> <br />
<br />
Usfull links:

*  Explorer: https://explorer.shardnet.near.org/
*  Wallet: https://wallet.shardnet.near.org/
*  Node activation guide : https://github.com/near/stakewars-iii/blob/main/challenges/002.md#activating-the-node-as-validator
*  Mounting a staking pool : https://github.com/near/stakewars-iii/blob/main/challenges/003.md#3-mounting-a-staking-pool

## Monitoring tool description:

* prometheus: exposing port: 9095
* grafana: exposing port: 3000
* near-explorer: exposing port: 9333 

Alertbot: 
* requires to create own bot with https://t.me/botfather and use token for installation
