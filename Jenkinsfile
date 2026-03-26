pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = 'true'
  }

   tools {
        terraform 'terraform'
    }

  stages {

    stage('Checkout')  {
        steps {
          echo '=== Checking out code from Gitlab ===='
          checkout scm
        }
    }

    stage ('Tearrform init') {
        steps {
          echo '  ===== Initializing terraform   ====='
          bat 'terraform version'
          bar 'terraform init'
        }
    }

    stage ('Tearrform Apply') {
      steps {
          echo '  =======  Applying Terraform - NO plan stage, direct apply ===='
          bat 'terraform apply -auto-approve'
      }
    }

    stage ('Verify Deployment') {
       steps {
         echo '====== Verifying conatiner is running   ======='
         bat 'tearrform output'
         bat 'docker ps --filter "name=jenkins-terraform-ngnix"'
       }
    }
  }

  post {
    success {
      echo 'SUCCESS: ngnix container deployed via Terraform!'
      echo 'Visit http://localhost:8090 to see it running'
    }
    failure {
      echo 'FAILED: Check logs for above error'
      bat 'tearrform destroy -auto-approve || exit 0'
    }
  }
}
