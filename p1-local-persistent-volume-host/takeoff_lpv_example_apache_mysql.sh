#!/bin/bash
# 180626: 7392 Reza Farrahi (imriss@yahoo.com)

#
lproot_number=$(cat /proc/self/mountinfo | grep 'lpvroot ' | awk -F':' '{print $1}' | awk -F' ' '{print $3}'); echo $lproot_number; docker exec kube-node-1 bash -c '[ -b /dev/xvdf ] >/tmp/tmp7392tmp && echo "Already there" || mknod --mode 0600 /dev/xvdf b "$lproot_number" 1; mkdir /lpvclient; mount /dev/xvdf /lpvclient; ls /lpvclient;'

#
cd ~/workspace/kubeadm-dind-cluster-ws; ps -ef | grep -v 'color' | grep '443:' | awk -F' ' '{print $2}' | tr -d '\n' | xargs -0 kill -9; kubectl delete -f lpv_apache_mysql_generic.yaml; repeat_cycle=true; while [ $repeat_cycle = true ]; do time_seconds=$((11)); while [ $time_seconds -gt 0 ]; do echo -ne "$time_seconds\033[K\r"; sleep 1; : $((time_seconds--)); done; kubectl get persistentvolume 2>&1 | grep -i "No resources found">/tmp/tmp7392tmp && { repeat_cycle=false; echo "Done!"; } ||  echo "Wait for PV terminated"; done; kubectl create -f lpv_apache_mysql_generic.yaml; repeat_cycle=true; while [ $repeat_cycle = true ]; do time_seconds=$((11)); while [ $time_seconds -gt 0 ]; do echo -ne "$time_seconds\033[K\r"; sleep 1; : $((time_seconds--)); done; kubectl get pod | grep apache | grep -i 'Running'>/tmp/tmp7392tmp && { repeat_cycle=false; echo "Done!"; } ||  echo "Wait for Pod ready"; done; kubectl port-forward $(kubectl get pod | grep apache | awk '{getline; print; exit}' | awk '{print $1}') 443:30443 &

#
kubectl get events --sort-by='{.metadata.name}';

#
kubectl exec -it $(kubectl get pod | grep 'apache' | awk -F' ' '{print $1}') touch /var/log/apache2/foobar; docker exec kube-node-1 ls /lpvclient/apache-logs;
