pipeline{
    agent any
    environment{
				VERSION = "${BUILD_ID}"
				REPO_NAME = 'demo-test1'
				IMAGE_NAME = 'frontend'
				ECR_URL = '387637752303.dkr.ecr.us-east-1.amazonaws.com'
				GIT_URL = 'https://github.com/Chavhanshailesh/test1.git'
		
    }
    stages{
		stage('Git Checkout'){
			steps{
				git "${GIT_URL}"
				sh 'ls'
			}
		}

        stage('Docker Build'){
            steps{
				sh "docker build . -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} "
            }

        }
		stage('ECR Push'){
			steps{
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
					sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
					sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
					sh '$(aws ecr get-login --no-include-email --region us-east-1)'
					sh 'docker tag ${REPO_NAME}/${IMAGE_NAME}:${VERSION} ${ECR_URL}/${REPO_NAME}:${VERSION}'
					sh 'docker push ${ECR_URL}/${REPO_NAME}:${VERSION}'
					sh "docker pull 387637752303.dkr.ecr.us-east-1.amazonaws.com/${REPO_NAME}:${VERSION}"
				}
			}
				
			
		}
			
		stage('Deployment on K8s'){
				steps{
					sh "chmod +x changeTag.sh"
					sh "./changeTag.sh ${VERSION}"
					sh 'ls'
					sh "cat latest-deployment.yaml"
					withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'k8s-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){ 
						sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
						sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
						sh 'aws-iam-authenticator help'
						//sh 'kubectl get pods'
						//sh "kubectl apply -f latest-deployment.yaml"
						//sh "kubectl apply -f service.yaml"
					}
				}	
		}
				
	}
  
}