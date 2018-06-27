180626: Reza Farrahi (imriss@yahoo.com)

# Local Persistent Volume for Pods on the Host (example)

## Requirements:
1. Docker access (for possibly private container images).
   - Please update prepare_greenfield_kubeadm_dind.sh
2. A spare storage device on the host.
   - It is assumed that it is /dev/xvdf
3. kubeadm-dind and Docker are being used to spin Kubernetes nodes.
   - kubeadm-dind: https://github.com/kubernetes-sigs/kubeadm-dind-cluster

## Procedure:
1. Bring up the nodes on the host:
   - ./prepare_greenfield_kubeadm_dind.sh
2. Bring up the service and pods:
   - ./takeoff_lpv_example_apache_mysql.sh
3. Check:
   - The contents of volumized dicrectories are at /lpvroot on the host.
     - The test file should be at: /lpvroot/apache-logs/foobar
