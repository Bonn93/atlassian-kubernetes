# Deploying with Ansible
* .yaml files are ansible, .yml files are k8s manifests
* envs.yaml contains most key settings used in the deployment


# Quick Deploy
```ansible-playbook bamboo_deploy.yaml -e @envs.yaml```

# Customizing Options
This guide relies on NFS volumes and static node-port type load balancers. These can be changed. The Bamboo docker container accepts several ENV variables to configure JVM or Tomcat HTTP options. Listed Below:


##### Namespace
* Target K8s Namespace

```devops-bamboo-ns```

##### Bambooservicename
* Service label used to gather objects 

```devops-bamboo-service```

##### Appname
* Name of the application 

```bamboo67```

##### jvmlow
* Xms value. Recommended to set the name. Not too big!

```1536m```

##### jvmhigh
* Xmx. Set as Above

##### Bamboopv
* Bamboo Persistent Volume used in deployment

```bamboopv```

##### Bamboovolumeclaim
* K8s PVC object to claim the volume

```bamboonnfspvc```

##### Bamboovolumename
* Used in Deployment

```bamboo-vol```

##### Storagesize
* Capacity in GB for the Bamboo Home 

```10Gi```

##### nfsserverip
* IP or FQDN for NFS Host

```10.1.1.22```

##### nfspath
* NFS Mount Path ( nfs export )

```/data/bamboo-prod/```

##### bambook8servicename
* used with k8s service and ingress controllers

```devops-bamboo-svc```

##### nodeip1,2
* Used with local load balancers or node ports to expose services outside without ingress controllers
* typically takes the node-port of each node in the k8s cluster

```10.1.1.25```
