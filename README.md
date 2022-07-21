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
Install node and cli: <br />

Create wallet: <br /> 
https://wallet.shardnet.near.org/

Follow instractions "on Activating the node as validator" : <br />
https://github.com/near/stakewars-iii/blob/main/challenges/002.md#activating-the-node-as-validator

2.Option: **Installing and configuring ping script for crontab, for contract call every 5 minut.** <br />
3.Option: **Installing monitoring tools(prometheus,alertmanager,near-explorer,grafana,alertbot for telegram)** <br />



