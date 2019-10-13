# Deploying with Ansible
* .yaml files are ansible, .yml files are k8s manifests
* envs.yaml contains most key settings used in the deployment

# Notes:
This deployment has been updated to use the official [Atlassian Jira Software Images](https://hub.docker.com/r/atlassian/jira-software). There's a few changes included in these from the prior images. As such, the configmaps are not required and do have some problems with how permissions are managed, but using ENVs & secrets is more secure. 

The k8s objects have been split into several files, this helps with troubleshooting as it makes identifcation of failures in each file more apparent. 

A example envs.yml file has been provided, this contains nearly all configurable options and tweaks. Feel free to extend this further by using Ansible {{}} jinja format. 

You should use an IngressController to properly manage sticky sessions and load balance traffic between pods.

# Mapping custom files
You may have a custom dbconfig.xml or server.xml requirements. This repo includes basic support to map these files in such as the server.xml for HTTP2 support. Please note that due to how permissions are managed, this may cause start-up failures until bugs are resolved. 

##### HTTP2 Support:
* HTTP2 support has been added as an example in jira_http2_configmap.yml which adds an upgrade connector ```<UpgradeProtocol className="org.apache.coyote.http2.Http2Protocol"/>``` use this as an example to map objects into the container. You could use this to configure log4j properties too. 

# StatefulSets
* This deployment uses [StatefulSets](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/) and is set to 1 replica. You can scale this deployment after the following is completed
* Main DB, App and Licence is configured @ 1 replica
* Jira8-0 is online and healthy
```kubectl scale sts/jira8 --replicas=2```

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

# ZDU Upgrades
ZDU is super simple and can be automagically mangaged with simple scripts or using a CI/CD tool or simple scripts.
1. Use the API to put the cluster into upgrade mode
2. Perform a rolling upgrade of the containers ( ie 8.4.1 > 8.4.2 ) and let k8s replace each member
3. Finalise the upgrade in Jira
4. Done. 

# Customizing Options
This guide relies on NFS volumes and static node-port type load balancers. These can be changed. The Jira docker container accepts several ENV variables to configure JVM or Tomcat HTTP options, these are documented in the official atlassian jira images as linked above. 

# Kubernetes Specific:

##### Namespace
* Target K8s Namespace. You may have development, test and production namespaces for your services and applications. 

```test```

##### Jiraservicename
* Service label used to gather objects. This is an object used to direct traffic and manage the k8s objects easily.

```jira8```

##### Appname
* Name of the application. A friendly name for the application

```jira8-dev```

##### Jiravolumeclaim
* K8s PVC object to claim the volume

```jiranfspvc```

##### Jiravolumename
* Used in Deployment

```jira-vol```

##### jirapv
* Jira Persistent Volume used in deployment

```jirapv```

##### Storagesize
* Capacity in GB for the Jira Home. This value must match everywhere! 

```10Gi```

##### nfsserverip
* IP or FQDN for NFS Host

```10.1.1.22```

##### nfspath
* NFS Mount Path ( nfs export )

```/data/jira-prod/```

##### jirak8servicename
* used with k8s service and ingress controllers.

```jira-svc```

##### nodeip1,2
* Used with local load balancers or node ports to expose services outside without ingress controllers
* typically takes the node-port of each node in the k8s cluster
* Production services should use Ingress controllers with session affinity support

```10.1.1.25```

# Jira/Tomcat/JVM
##### jvm
* Xms/Xmx value. Recommended to set the name. Not too big, not too small.

```2048m```

##### Topcat properties
* tomcat properties are set with the following values in the envs.yaml

```PROXYNAME```


```PROXYSCHEME```


```PROXYSECURE```


* Proxy Name is your FQDN in which your reverse proxy/load balancer listens for the service, such as bamboo.company.com
* Proxy Scheme tells tomcat if this is HTTP or HTTPS
* Proxy Secure informs tomcat if SSL is in use and allows for better re-writing and security. This value is hard coded into the deployment.yml due to bugs between ansible and go templates not reading this value correctly. If HTTPS, set this to "true", if HTTP, set this to "false"
