# atlassian-kubernetes
All things Atlassian and Kubernetes!

This repo is to show a general idea on how to deploy the entire Atlassian stack on Kubernetes.

Future releases will be via Helm Charts, Support for DataCenter Versions will come later.

This is not a Production Ready Service. You will need to build your own deployments and use the correct resources.
* NFSv4 can be problematic, with correct tuning for each workload, this can be a viable option, though NFSv3 is recommended still

# This is work in progress. Changes are drastic and frequent! 

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

### Understating Persistence in K8s ###
Unless properly backed by a volume, your data will not persist. Each service has the following;
* K8S Volume
* K8S Volume Claim
* Deployment Volume Mount ( consumer of the above )

You can edit the volume.yml files to use any Disk backing supported by K8s, however please note that performance items need to be considered. Volumes hosting Git repos especially.

# Create a Namespace
All the services will live within one namespace, test or production. All services are deployed to this namespaces explicitly.
You may need to define your kubectl context such as "kubectl apply -f foo.yml --namespace=test" 

```kubectl create -f production/prod_namespace.yml```

```kubectl create ns production```

# Edit Volumes
Volumes are created and configured in ${product}/prod_volume*.yml
* Samples used a NFS Server
* Most settings are part of ${product}/envs.yaml
* Adjust these volumes to suit your needs


# Create an Database Application Deployment
It's best to deploy the database first, this may be automated in the App setup in the future. But prepare this first.

I have included a pre-built demo database to support both test, and production deployments. This is found here: https://hub.docker.com/r/mbern/postgres-atlas-all/ 
* Includes default demo credentials for all products as jira:jira:jira or jira_prod:jira_prod:jira:prod
* Includes default demo databases for each of the above
This is only a demo database, this is not a production or secure deployment service!
 ```kubectl -n $namespace create -f database/prod_database.yml```

# Expose the Postgres Backend Service
We need to expose the database service internally to the namespace. We do this with a service deployment:
```kubectl -n $namespace create -f database/prod_database_service_be.yml```
Postgres should now be available at the following address: postgres-atlas.production:5432

Note that cluster-dns and networking must be working to ensure pods, nodes and deployments can resolve these address spaces.


# Deploy product via Ansible:
Bamboo: https://github.com/Bonn93/atlassian-kubernetes/blob/master/bamboo/readme.md
Jira:
Confluence:
Bitbucket:
Crowd:
FeCru:


