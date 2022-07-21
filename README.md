## ShardNet node & monitoring installation 
1.Option: *Installing all dependencies,neard and near cli with latest genesis and config files.* <br />
2.Option: *Installing and configuring ping script for crontab, to ping pool every 5 minut.* <br />
3.Option: *Installing monitoring tools(prometheus,alertmanager,near-explorer,grafana,alertbot for telegram)* <br />

!!Near login and keys managment will be done manualy.

## Installation:
<img width="220" alt="Screen Shot 2022-07-21 at 9 18 43" src="https://user-images.githubusercontent.com/79820904/180143201-da262fac-8ff9-4ec4-830c-c7b5930fd33a.png">

sudo apt update && sudo apt install git -y
git clone https://github.com/doma2k/monNear.git
chmod +x $HOME/monNear/shardnet.sh
