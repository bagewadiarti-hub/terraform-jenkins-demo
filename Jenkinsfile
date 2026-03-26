pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = 'true'
  }

  tools {
    terraform 'terraform'
  }

  stages {

    stage('Checkout') {
      steps {
        echo '=== Checking out code ===='
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        echo '===== Initializing Terraform ====='
        bat 'terraform init'
      }
    }

    stage('Terraform Apply') {
      steps {
        echo '===== Applying Terraform (No Plan) ====='
        bat 'terraform apply -auto-approve'
      }
    }

    stage('Verify Deployment') {
      steps {
        echo '===== Verifying container is running ====='
        bat 'terraform output'
        bat 'docker ps'
      }
    }
  }

  post {
    success {
      echo 'SUCCESS: nginx container deployed via Terraform!'
      echo 'Visit http://localhost:8090'
    }
    failure {
      echo 'FAILED: Check logs'
      bat 'terraform destroy -auto-approve || exit 0'
    }
  }
}
