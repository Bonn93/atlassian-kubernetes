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

  }
}