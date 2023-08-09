pipeline {
    agent any

    parameters {
        choice(name: 'TERRAFORM_ACTION', choices: ['init', 'plan', 'apply', 'destroy'], description: 'Select Terraform action')
        string(name: 'AZURE_SUBSCRIPTION_ID', description: 'Azure Subscription ID')
    }

    environment {
    AZURE_CLIENT_ID = credentials('azure-client-id')
    AZURE_CLIENT_SECRET = credentials('secret_value')
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
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
                        string(credentialsId: 'azure-client-secret', variable: 'AZURE_CLIENT_SECRET'),
                        string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID')
                    ]) {
                        def azureClientSecret = credentials('secret_value')
                        sh """
                            /opt/homebrew/bin/az login --service-principal --username \$AZURE_CLIENT_ID --password \$AZURE_CLIENT_SECRET --tenant \$AZURE_TENANT_ID
                            terraform ${params.TERRAFORM_ACTION}
                            az logout
                        """
                    }
                }
            }
        }

    }
}
