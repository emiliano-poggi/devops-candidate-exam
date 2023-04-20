pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                echo "test"
                sh 'terraform init -migrate-state'
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
                sh 'aws lambda invoke --function-name devopsexam_lambda --log-type Tail response.txt
            }
        }
    }
}
