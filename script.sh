sudo apt-get update
sudo apt-get -y upgrad

wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
sudo tar -xvf go1.11.4.linux-amd64.tar.gz
sudo mv go /usr/local

mkdir $HOME/gopath

echo "export GOROOT=/usr/local/go" >> $HOME/.bashrc
echo "export GOPATH=$HOME/gopath" >> $HOME/.bashrc
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> $HOME/.bashrc

source ~/.bashrc

wget https://dist.ipfs.io/go-ipfs/v0.4.18/go-ipfs_v0.4.18_linux-amd64.tar.gz 
tar xvfz go-ipfs_v0.4.18_linux-amd64.tar.gz 
sudo mv go-ipfs/ipfs /usr/local/bin/ipfs 
ipfs init 

ipfs bootstrap rm --all
ipfs bootstrap add /ip4/192.46.239.84/tcp/4001/ipfs/Qmds9TWY4L52a5moqh44RaM2F85psY1fVGHM2sy4tYArbJ
export LIBP2P_FORCE_PNET=1

echo "/key/swarm/psk/1.0.0/" >> $HOME/.ipfs/swarm.key
echo "/base16/" >> $HOME/.ipfs/swarm.key
echo "c508a99a0677008eab7198d737f3e3e7736ce0f0a0bbd1cc221a4d79adf8f5b5" >> $HOME/.ipfs/swarm.key

echo "[Unit]" >> /etc/systemd/system/ipfs.service
echo " Description=IPFS Daemon" >> /etc/systemd/system/ipfs.service
echo " After=syslog.target network.target remote-fs.target nss-lookup.target" >> /etc/systemd/system/ipfs.service
echo " [Service]" >> /etc/systemd/system/ipfs.service
echo " Type=simple" >> /etc/systemd/system/ipfs.service
echo " ExecStart=/usr/local/bin/ipfs daemon --enable-namesys-pubsub" >> /etc/systemd/system/ipfs.service
echo " User=root" >> /etc/systemd/system/ipfs.service
echo " [Install]" >> /etc/systemd/system/ipfs.service
echo " WantedBy=multi-user.target" >> /etc/systemd/system/ipfs.service

sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl start ipfs
sudo systemctl status ipfs

wget https://dist.ipfs.io/ipfs-cluster-ctl/v0.9.0/ipfs-cluster-ctl_v0.9.0_linux-amd64.tar.gz 
tar xvfz ipfs-cluster-ctl_v0.9.0_linux-amd64.tar.gz
sudo mv ipfs-cluster-ctl/ipfs-cluster-ctl /usr/local/bin/ipfs-cluster-ctl

wget https://dist.ipfs.io/ipfs-cluster-service/v0.9.0/ipfs-cluster-service_v0.9.0_linux-amd64.tar.gz
tar xvfz ipfs-cluster-service_v0.9.0_linux-amd64.tar.gz
sudo mv ipfs-cluster-service/ipfs-cluster-service /usr/local/bin/ipfs-cluster-service

export CLUSTER_SECRET=31073f47e04112f1edfc7e399774225d7c3ee71d067b597f567307f6bac7880b
source ~/.bashrc

ipfs-cluster-service init
 
echo "[Unit]" >> /etc/systemd/system/ipfs-cluster.service
echo "Description=IPFS-Cluster Daemon" >> /etc/systemd/system/ipfs-cluster.service
echo "[Service]" >> /etc/systemd/system/ipfs-cluster.service
echo "ExecStart=/usr/local/bin/ipfs-cluster-service daemon --bootstrap /ip4/192.46.239.84/tcp/9096/ipfs/QmNzTTEoxAkwW1sVAaX1kwU7ZnM2PNZtcTbcbMhjnaSzyN" >> /etc/systemd/system/ipfs-cluster.service
echo "Restart=always" >> /etc/systemd/system/ipfs-cluster.service
echo "User=root" >> /etc/systemd/system/ipfs-cluster.service
echo "Group=root" >> /etc/systemd/system/ipfs-cluster.service
echo "[Install]" >> /etc/systemd/system/ipfs-cluster.service
echo "WantedBy=multi-user.targetc" >> /etc/systemd/system/ipfs-cluster.service


sudo systemctl daemon-reload 
sudo systemctl enable ipfs-cluster 
sudo systemctl start ipfs-cluster 
sudo systemctl status ipfs-cluster















