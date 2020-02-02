pipeline {
  agent any
  stages {
    stage('Remove existing objects') {
      steps {
        withKubeConfig(clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'k8scfg', namespace: 'test', serverUrl: 'https://10.0.0.30:6443') {
          sh '''kubectl -n test delete sts/jira8
kubectl -n test delete sts/postgres-atlas'''
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

  }
}