# Deploying with Ansible
* .yaml files are ansible, .yml files are k8s manifests
* envs.yaml contains most key settings used in the deployment

# StatefulSets
* This deployment uses StatefulSets and is set to 1 replica. You can scale this deployment after the following is completed
* Main DB, App and Licence is configured @ 1 replica
* JSD-0 is online and healthy
```kubectl scale sts/jira-servicedesk --replicas=2```

# Scaling Jira
* Ensure you meet clustering requirements including a decent amount of CPUs and Memory.
* Production clusters should have at least 8 CPUs
* Ensure to scale the XMX/XMS values
* Ensure you run on modern hardware
* 3-4 pods in the statefulset will be optimial, going above this is not recommended
* Increasing the max_connections for the postgres service will be needed to scale the connection pool
* Increase pool settings in the DBConfig Configmap
* Ensure you have adequate NFS performance 



# Quick Deploy
```ansible-playbook jira_deploy_playbook.yaml -e @envs.yaml```

# Customizing Options
This guide relies on NFS volumes and static node-port type load balancers. These can be changed. The Jira docker container accepts several ENV variables to configure JVM or Tomcat HTTP options. Listed Below:


##### Namespace
* Target K8s Namespace

```jira-ns```

##### Jiraservicename
* Service label used to gather objects 

```jira-service```

##### Appname
* Name of the application 

```jira713```

##### jvmlow
* Xms value. Recommended to set the name. Not too big, not too small.

```1536m```

##### jvmhigh
* Xmx. Set as Above

##### jirapv
* Jira Persistent Volume used in deployment

```jirapv```

##### Jiravolumeclaim
* K8s PVC object to claim the volume

```jiranfspvc```

##### Jiravolumename
* Used in Deployment

```jira-vol```

##### Storagesize
* Capacity in GB for the Jira Home 

```10Gi```

##### nfsserverip
* IP or FQDN for NFS Host

```10.1.1.22```

##### nfspath
* NFS Mount Path ( nfs export )

```/data/jirasd-prod/```

##### jirak8servicename
* used with k8s service and ingress controllers

```jirasd-svc```

##### nodeip1,2
* Used with local load balancers or node ports to expose services outside without ingress controllers
* typically takes the node-port of each node in the k8s cluster

```10.1.1.25```

##### Topcat properties
* tomcat properties are set with the following values in the envs.yaml

```PROXYNAME```


```PROXYSCHEME```


```PROXYSECURE```


* Proxy Name is your FQDN in which your reverse proxy/load balancer listens for the service, such as bamboo.company.com
* Proxy Scheme tells tomcat if this is HTTP or HTTPS
* Proxy Secure informs tomcat if SSL is in use and allows for better re-writing and security. This value is hard coded into the deployment.yml due to bugs between ansible and go templates not reading this value correctly. If HTTPS, set this to "true", if HTTP, set this to "false"

##### Additional Notes 
This deployment changes the service port for JSD from 8080 to 8081.