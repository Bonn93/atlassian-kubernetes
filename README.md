# atlassian-kubernetes
All things Atlassian and Kubernetes!

This repo is to show a general idea on how to deploy the entire Atlassian stack on Kubernetes.

Future releases will be via Helm Charts, Support for DataCenter Versions will come later.

This is not a Production Ready Service. You will need to build your own deployments and use the correct resources.
* NFSv4 is not supported for Shared File Systems on Atlassian Applications especially Git
* NFS is not supported for Jira/Lucene Indexes

### Getting Started ###
You will need:
* A Kubernetes Cluster
* A Valid kubectl config file & Context (~/home/.kube )
* At least 8GB~ of Memory in the Cluster
* NFS Volumes or Persistent Disk Backing (https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes)
* A Node IP or Elastic IP (GKE) to expose the services outside the cluster

This has been tested with:
* GKE
* Kubernetes 1.11 on vSphere
* Rancher

### Understating Persistence in K8s ###
Unless properly backed by a volume, your data will not persist. Each service has the following;
* K8S Volume
* K8S Volume Claim
* Deployment Volume Mount ( consumer of the above )

You can edit the volume.yml files to use any Disk backing supported by K8s, however please note that performance items need to be considered. Git volumes especially.

# Create a Namespace
All the services will live within one namespace, test or production. All services are deployed to this namespaces explicitly.
You may need to define your kubectl context such as "kubectl apply -f foo.yml --namespace=test" 


