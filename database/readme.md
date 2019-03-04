# Deploying with Ansible
* .yaml files are ansible, .yml files are k8s manifests
* envs.yaml contains most key settings used in the deployment


# Quick Deploy
```ansible-playbook ansible-postgres.yaml -e @envs.yaml```

##### Namespace
* Target K8s Namespace

```devops-postgres-ns```

##### servicename
* K8s Service Name

```postgres-atlas```

##### Volumes:
These can be re-named as you like. Nothing to see here...

##### Storage
Adjust the sotrage for the database as required. 5GB is enough to demo and deploy most applications!

##### NFS Server and Paths
Specify your NFS Server and Mount paths. 