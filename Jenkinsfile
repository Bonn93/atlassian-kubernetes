pipeline {
  agent any
  stages {
    stage('Remove existing objects') {
      steps {
        withKubeConfig(clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'k8scfg', namespace: 'test', serverUrl: 'https://10.0.0.30:6443') {
          sh '''set +e
kubectl -n test delete sts/jira
kubectl -n test delete sts/postgres-atlas
kubectl -n test delete svc/jira
sleep 1s'''
        }

      }
    }

    stage('Clean NFS') {
      steps {
        node(label: 'nfs') {
          sh '''rm -rf /nfs/psql_prod/*
rm -rf /nfs/jira_prod/*'''
        }

      }
    }

    stage('Deploy Postgres') {
      steps {
        withKubeConfig(clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'k8scfg', namespace: 'test', serverUrl: 'https://10.0.0.30:6443') {
          sh '''ansible-playbook -v database/ansible-postgres.yaml \\
-e "namespace=test" \\
-e "appname=postgres-atlas" \\
-e "volume=postgresatlaspv" \\
-e "volumeclaim=postgresatlas" \\
-e "volumename=postgresatlas" \\
-e "storagesize=5Gi" \\
-e "nfsserverip=10.0.0.22" \\
-e "nfspath=/root/nfs/psql_prod" \\
-e "podcpu=2" \\
-e "podmemory=2Gi"'''
        }

      }
    }

    stage('Deploy Jira') {
      steps {
        withKubeConfig(clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'k8scfg', namespace: 'test', serverUrl: 'https://10.0.0.30:6443') {
          sh '''ansible-playbook -v jira/jira_deploy_playbook.yaml \\
-e "namespace=test" \\
-e "jiraservicename=jira" \\
-e "appname=jira" \\
-e "jvm=2048m" \\
-e "jiravolume=jirapv" \\
-e "jiravolumeclaim=jira" \\
-e "jiravolumename=jira" \\
-e "storagesize=5Gi" \\
-e "nfsserverip=10.0.0.22" \\
-e "nfspath=/root/nfs/jira_prod" \\
-e "jirak8sservicename=jira-svc" \\
-e "nodeip1=10.0.0.30" \\
-e "nodeip2=10.0.0.31" \\
-e "proxyname=jira.pandanet.xyz" \\
-e "proxyscheme=https" \\
-e "postgresserver=postgres-atlas" \\
-e "version=8.5.3-jdk11" \\
-e "podcpu=3" \\
-e "podmemory=3Gi"'''
        }

      }
    }

    stage('Get Kube Objects') {
      steps {
        withKubeConfig(serverUrl: 'https://10.0.0.30:6443', namespace: 'test', credentialsId: 'k8scfg', contextName: 'kubernetes-admin@kubernetes', clusterName: 'kubernetes') {
          sh '''kubectl -n test get po
kubectl -n test get svc
kubectl -n test get sts
sleep 40s
kubectl -n test logs jira-0'''
        }

      }
    }

  }
}