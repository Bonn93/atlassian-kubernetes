pipeline {
  agent any
  stages {
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

    stage('Deploy Jira Data Center') {
      steps {
        withKubeConfig(clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'k8scfg', namespace: 'test', serverUrl: 'https://10.0.0.30:6443') {
          sh '''ansible-playbook -v jira/jira_deploy_playbook.yaml \\
-e "namespace=test" \\
-e "jiraservicename=jira8" \\
-e "appname=jira8" \\
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
-e "databasename=jira_prod" \\
-e "databaseport=5432" \\
-e "dbuser=jira_prod" \\
-e "dbpass=jira_prod" \\
-e "version=8.6.0-jdk11" \\
-e "podcpu=3" \\
-e "podmemory=3Gi"'''
        }

      }
    }

  }
}