pipeline {
    agent any

    parameters {
        string(name: 'TERRAFORM_INIT_CMD', defaultValue: 'init', description: 'Terraform Init Command')
        string(name: 'AZURE_SUBSCRIPTION_ID', description: 'Azure Subscription ID')
    }

    environment {
    AZURE_CLIENT_ID = credentials('azure-client-id')
    AZURE_CLIENT_SECRET = credentials('azure-client-secret')
    AZURE_TENANT_ID = credentials('azure-tenant-id')
    // Other environment variables...
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/Vijaykumar-97/Terraform-Projects.git']],
                          credentialsId: 'Github_secret'])
            }
        }

        stage('Terraform Init') {
            withCredentials([
                string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
                string(credentialsId: 'azure-client-secret', variable: 'AZURE_CLIENT_SECRET'),
                string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID')
                 ]) {
                  script {
                    def azureClientSecret = credentials('azure-client-secret')
                     withAzureCLI(credentialsType: 'servicePrincipal', servicePrincipal: "${AZURE_CLIENT_ID}:${azureClientSecret}:${AZURE_TENANT_ID}:${AZURE_SUBSCRIPTION_ID}") {
                        sh "terraform ${params.TERRAFORM_INIT_CMD}"
                    }

                }
            }
        }





        // Add more stages as needed
    }
}
