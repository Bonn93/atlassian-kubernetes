# atlassian-kubernetes
All things Atlassian and Kubernetes!

This repo is to show a general idea on how to deploy the entire Atlassian stack on Kubernetes.

Future releases will be via Helm Charts, Support for Data Center Versions will come later.

This is not a Production Ready Service. You will need to build your own deployments and use the correct resources.
* NFSv4 can be problematic with Git workloads, with correct tuning for each workload, this can be a viable option, though NFSv3 is recommended via HostPaths for performance environments! 

# This is work in progress!

### Getting Started ###
You will need:
* A Kubernetes Cluster
* Ansible
* A Valid kubectl config file & Context (~/home/.kube )
* At least 16GB~ of Memory in the Cluster
* NFS Volumes or Persistent Disk Backing (https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes)
* A Node IP or Elastic IP (GKE) to expose the services outside the cluster

This has been tested with:
* GKE
* Kubernetes 1.13 on vSphere
* HAProxy L4/L7 Ingress

### Understating Persistence in K8s ###
Unless properly backed by a volume, your data will not persist. Each service has the following;
* K8S Volume
* K8S Volume Claim
* Deployment Volume Mount ( consumer of the above )

You can edit the volume.yml files to use any Disk backing supported by K8s, however please note that performance items need to be considered. Volumes hosting Git repos especially.

# Create a Namespace
All the services will live within one namespace, test or production. All services are deployed to this namespaces explicitly.
You may need to define your kubectl context such as "kubectl apply -f foo.yml --namespace=test" 

```kubectl create ns my-namespace```

# Edit Volumes
Volumes are created and configured in ${product}/prod_volume*.yml
* Samples used a NFS Server
* Most settings are part of ${product}/envs.yaml
* Adjust these volumes to suit your needs


# Create an Database Application Deployment
Deploy a sample Postgres instance: https://github.com/Bonn93/atlassian-kubernetes/tree/master/database

I've built a quick database to use for this sample deployment found here: https://cloud.docker.com/u/mbern/repository/docker/mbern/postgres-atlas-all

This has several databases included which can be used with each application deployment below.

Production deployments are still best of using Managed SQL services like Cloud SQL, RDS or real database deployments for sake of sanity and protection. If you understand how databases, docker and kubernetes works, then fire away!
 


# Deploy product via Ansible:
### Bamboo: https://github.com/Bonn93/atlassian-kubernetes/blob/master/bamboo/readme.md
### Jira: Coming Soon!
### Confluence: Coming Soon!
### Bitbucket: https://github.com/Bonn93/atlassian-kubernetes/blob/master/bitbucket/readme.md
### Crowd: Coming Soon!
### FeCru: Coming Soon!

# Configure products:
* After a successful deployment, each application should be available via HTTP internally and externally
* Configure applications, the database EP is: postgres-atlas.${namespace}:5432



# Tips:
### Access the services without ingress using kubectl proxy:
```kubectl proxy```

```curl -v http://localhost:${product_port}```


### Get deployment:
```kubectl -n $namespace get deploy/bamboodeployment```



### Get pod and Pod details:
```kubectl -n $namespace get po```

```kubectl -n $namespace describe po <podname>```


### Container Shell:
```kubectl -n $namespace exec -it <podname> /bin/bash```

# Data Center Versions:
Running stateful applications like the above can be tricky with Kubernetes. Whilst we can use stateful sets, the applications here require some advanced setup and tweaks in-order to perform "simple deployments". I'm working on this, but if you have experience with Statefulsets and these products, I'd like to hear from you! 
