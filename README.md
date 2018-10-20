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
* At least 10GB~ of Memory in the Cluster
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

You can edit the volume.yml files to use any Disk backing supported by K8s, however please note that performance items need to be considered. Volumes hosting Git repos especially.

# Create a Namespace
All the services will live within one namespace, test or production. All services are deployed to this namespaces explicitly.
You may need to define your kubectl context such as "kubectl apply -f foo.yml --namespace=test" 

```kubectl create -f production/prod_namespace.yml```

# Create Volumes
Create volumes such as the below for each product
```kubectl -n production create -f production/bamboo/production_volume_bamboo.yml```

# Create Volume Claims 
This exposes the volume object to the Kube API for consumption by a pod or deployment. The volume is not mounted yet during this stage.
```kubectl -n production create -f production/bamboo/production_volume_bamboo_claim.yml```

# Create an Database Application Deployment
It's best to deploy the database first, this may be automated in the App setup in the future. But prepare this first.

I have included a pre-built demo database to support both test, and production deployments. This is found here: https://hub.docker.com/r/mbern/postgres-atlas-all/ 
* Includes default demo credentials for all products as jira:jira:jira or jira_prod:jira_prod:jira:prod
* Includes default demo databases for each of the above
This is only a demo database, this is not a production or secure deployment service!
 ```kubectl -n create -f production/database/prod_database.yml```

# Expose the Postgres Backend Service
We need to expose the database service internally to the namespace. We do this with a service deployment:
```kubectl -n create -f production/database/prod_database_service_be.yml```
Postgres should now be available at the following address: postgres-atlas.production:5432

Note that cluster-dns and networking must be working to ensure pods, nodes and deployments can resolve these address spaces.

# Start the application deployments as desired:
```kubectl -n production create -f production/bamboo/prod_bamboo_deployment.yml```

```kubectl -n production create -f production/jira/prod_jira_deployment.yml```

```kubectl -n production create -f production/crowd/prod_crowd_deployment.yml```

# Expose your services with your desired ingress controller
This demo repo uses a single Kube NODE address. Clusters may have dedicated ingress controllers such as:
* Traefic
* Nginx
* GKE Elastic Address

```kubectl -n production create -f production/crowd/prod_crowd_service_fe.yml```

# Configure the Applications:
As the deployments start up, you can simple configure them via the Web UI for each product pointing them to the desired database and start using them! 


