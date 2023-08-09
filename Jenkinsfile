// pipeline {
//     agent any

//     parameters {
//         choice(name: 'TERRAFORM_ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Select Terraform action')
//         string(name: 'AZURE_SUBSCRIPTION_ID', description: 'Azure Subscription ID')
//     }

//     environment {
//     AZURE_CLIENT_ID = credentials('azure-client-id')
//     AZURE_CLIENT_SECRET = credentials('secret_value')
//     AZURE_TENANT_ID = credentials('azure-tenant-id')
//     PATH = "${PATH}:/opt/homebrew/bin/az"
//     // Other environment variables...
//     }

//     stages {
//         stage('Checkout Code') {
//             steps {
//                 checkout([$class: 'GitSCM',
//                           branches: [[name: '*/main']],
//                           userRemoteConfigs: [[url: 'https://github.com/Vijaykumar-97/Terraform-Projects.git']],
//                           credentialsId: 'Github_secret'])
//             }
//         }

//         stage('Terraform Init') {
//             steps {
//                 script {
//                     withCredentials([
//                         string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
//                         string(credentialsId: 'secret_value', variable: 'AZURE_CLIENT_SECRET'),
//                         string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID')
//                     ]) {
//                         def azureClientSecret = credentials('secret_value')
//                         sh """
//                             /opt/homebrew/bin/az login --service-principal --username \$AZURE_CLIENT_ID --password \$AZURE_CLIENT_SECRET --tenant \$AZURE_TENANT_ID
//                             /opt/homebrew/bin/terraform init
//                             /opt/homebrew/bin/az logout
//                         """
//                     }
//                 }
//             }
//         }
//         stage('Terraform Command') {
//             steps {
//                 script {
//                     withCredentials([
//                         string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
//                         string(credentialsId: 'secret_value', variable: 'AZURE_CLIENT_SECRET'),
//                         string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID')
//                     ]) {
//                         def azureClientSecret = credentials('secret_value')
//                         sh """
//                             /opt/homebrew/bin/az login --service-principal --username \$AZURE_CLIENT_ID --password \$AZURE_CLIENT_SECRET --tenant \$AZURE_TENANT_ID
//                             /opt/homebrew/bin/terraform ${params.TERRAFORM_ACTION}
//                             /opt/homebrew/bin/az logout
//                         """
//                     }
//                 }
//             }
//         }

//     }
// }


pipeline {
    agent any

    parameters {
        choice(name: 'TERRAFORM_ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Select Terraform action')
    }

    environment {
        PATH = "${PATH}:/opt/homebrew/bin/az"
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

        stage('Azure Login') {
            steps {
                script {
                    sh "/opt/homebrew/bin/az login"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                environment {
                    PATH = "${PATH}:/opt/homebrew/bin/az"
                    // Other environment variables...
                }
                script {
                    sh "/opt/homebrew/bin/terraform init"
                }
            }
        }
        
        stage('Terraform Command') {
            steps {
                script {
                    sh "/opt/homebrew/bin/terraform ${params.TERRAFORM_ACTION}"
                }
            }
        }

        stage('Azure Logout') {
            steps {
                script {
                    sh "/opt/homebrew/bin/az logout"
                }
            }
        }
    }
}
