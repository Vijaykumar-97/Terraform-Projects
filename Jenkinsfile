pipeline {
    agent any

    environment {
        AZURE_CLIENT_ID = credentials('azure-client-id')
        AZURE_CLIENT_SECRET = credentials('azure-client-secret')
        AZURE_TENANT_ID = credentials('azure-tenant-id')
        AZURE_SUBSCRIPTION_ID = 'e4c32755-3f69-43a0-be4b-e067634c6a89'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Vijaykumar-97/Terraform-Projects.git'
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    echo "terraform action from the parameter is --> ${action}"
                    withAzureCLI(credentialsType: 'servicePrincipal', servicePrincipal: "${AZURE_CLIENT_ID}:${AZURE_CLIENT_SECRET}:${AZURE_TENANT_ID}:${AZURE_SUBSCRIPTION_ID}") {
                        sh ("terraform ${action}")
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    echo "terraform action from the parameter is --> ${action}"
                    withAzureCLI(credentialsType: 'servicePrincipal', servicePrincipal: "${AZURE_CLIENT_ID}:${AZURE_CLIENT_SECRET}:${AZURE_TENANT_ID}:${AZURE_SUBSCRIPTION_ID}") {
                        sh ("terraform ${action}")
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    echo "terraform action from the parameter is --> ${action}"
                    withAzureCLI(credentialsType: 'servicePrincipal', servicePrincipal: "${AZURE_CLIENT_ID}:${AZURE_CLIENT_SECRET}:${AZURE_TENANT_ID}:${AZURE_SUBSCRIPTION_ID}") {
                        sh ("terraform ${action} -auto-approve")
                    }
                }
            }
        }
        stage('Terraform Destroy') {
            steps {
                script {
                    echo "terraform action from the parameter is --> ${action}"
                    withAzureCLI(credentialsType: 'servicePrincipal', servicePrincipal: "${AZURE_CLIENT_ID}:${AZURE_CLIENT_SECRET}:${AZURE_TENANT_ID}:${AZURE_SUBSCRIPTION_ID}") {
                        sh ("terraform ${action} -auto-approve")
                    }
                }
            }
        }

    }
}
