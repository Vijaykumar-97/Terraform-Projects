pipeline {
    agent any

    parameters {
        string(name: 'TERRAFORM_INIT_CMD', defaultValue: 'init', description: 'Terraform Init Command')
        string(name: 'AZURE_SUBSCRIPTION_ID', description: 'Azure Subscription ID')
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
            steps {
                script {
                    // Load Azure credentials using withCredentials
                    withCredentials([
                        string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
                        string(credentialsId: 'azure-client-secret', variable: 'AZURE_CLIENT_SECRET'),
                        string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID')
                    ]) {
                        // Now you can use the variables AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID
                        sh "echo Azure Client ID: $AZURE_CLIENT_ID"
                        sh "echo Azure Client Secret: $AZURE_CLIENT_SECRET"
                        sh "echo Azure Tenant ID: $AZURE_TENANT_ID"

                        // Use the credentials and subscription ID in your Azure CLI commands
                        withAzureCLI(credentialsType: 'servicePrincipal', servicePrincipal: "${AZURE_CLIENT_ID}:${AZURE_CLIENT_SECRET}:${AZURE_TENANT_ID}:${AZURE_SUBSCRIPTION_ID}") {
                            sh "terraform ${TERRAFORM_INIT_CMD}"
                        }
                    }
                }
            }
        }

        // Add more stages as needed
    }
}
