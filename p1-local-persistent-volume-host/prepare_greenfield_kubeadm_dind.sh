#!/bin/bash
# 180626: 7392 Reza Farrahi (imriss@yahoo.com)

#
mkdir -p ~/workspace/kubeadm-dind-cluster-ws; cd ~/workspace/kubeadm-dind-cluster-ws; ../kubeadm-dind-cluster/fixed/dind-cluster-v1.10.sh down; ../kubeadm-dind-cluster/fixed/dind-cluster-v1.10.sh clean;

#
cd ~/workspace; rm -rf ~/workspace/kubeadm-dind-cluster; git clone https://github.com/Mirantis/kubeadm-dind-cluster.git;

#
cd ~/workspace/kubeadm-dind-cluster-ws; EXTRA_PORTS="30443:30443" NUM_NODES=1 ../kubeadm-dind-cluster/fixed/dind-cluster-v1.10.sh up; export PATH="$HOME/.kubeadm-dind-cluster:$PATH";

#
kubectl create secret docker-registry genericregistrykey --docker-username=<<myname>> --docker-password=<<mypass> --docker-email=<<myemail>>

#
cat /etc/fstab | grep 'lpvroot'>/tmp/tmp7392tmp && echo "Already there" || `mkfs.ext4 /dev/xvdf; mount /dev/xvdf /lpvroot; echo '/dev/xvdf /lpvroot ext4 defaults 0 0'>>/etc/fstab;`
