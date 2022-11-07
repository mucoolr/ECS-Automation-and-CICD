pipeline {
    agent any
    parameters {
        choice(name: 'Environment', choices: ['QA','Stage','Prod'], description: 'Setting this will deploy the application on selected environment')    
    }
    stages {
        stage('build docker image') {
            steps {
                sh 'docker build -t climate .'
             
                }
        }
        stage('push docker image to ecr') {
            steps {
                // enter the command specifc to testing account
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 02435#####.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker tag climate:latest 024354####.dkr.ecr.us-east-1.amazonaws.com/climate:latest'     
                sh 'docker push 024354#####.dkr.ecr.us-east-1.amazonaws.com/climate:latest'
                }
        }
        stage('QA_deployment'){
        when {
            expression {
            return ( (params.Environment  == 'QA'))
            }
        }            
            steps{
                // enter the image uri created in the testing account
                sh '''
                    cd IaaC
                    terraform init
                    terraform plan -var-file="values.tfvars" "-lock=false"
                    terraform apply -auto-approve \
                    -var-file="values.tfvars"  \
                    -var 'imageURI=0243543###.dkr.ecr.us-east-1.amazonaws.com/climate:latest "-lock=false" 
                   

                '''
            }
        }
        stage('Stage_deployment'){
        when {
            expression {
            return ( (params.Environment  == 'Stage'))
            }
        }              
            steps{
                // enter the image uri created in the testing account
                // Assuming stage account is different
                // change the AWS profile using AWS EXPORT command
                sh '''
                    export AWS_PROFILE=stage_creds
                    cd IaaC
                    terraform init
                    terraform plan -var-file="values.tfvars" "-lock=false"
                    terraform apply -auto-approve \
                    -var-file="values.tfvars"  \
                    -var 'imageURI=0243543###.dkr.ecr.us-east-1.amazonaws.com/climate:latest "-lock=false" 
                   

                '''
            }
        }
        stage('Prod_deployment'){
            expression {
            return ( (params.Environment  == 'Prod'))
            }
        }             
            steps{
                // enter the image uri created in the testing account
                // Assuming stage account is different
                // change the AWS profile using AWS EXPORT command         
                sh '''
                    export AWS_PROFILE=prod_creds
                    cd IaaC
                    terraform init
                    terraform plan -var-file="values.tfvars" "-lock=false"
                    terraform apply -auto-approve \
                    -var-file="values.tfvars"  \
                    -var 'imageURI=0243543###.dkr.ecr.us-east-1.amazonaws.com/climate:latest "-lock=false" 
                   

                '''
            }
        }                
    }       
