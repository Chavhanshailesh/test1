pipeline{
    agent any
    environment{
				VERSION = "${BUILD_ID}"
				REPO_NAME = 'smtip-admin-frontend'
				IMAGE_NAME = 'frontend-demo'
				ECR_URL = '754178572197.dkr.ecr.us-east-1.amazonaws.com'
				
		
    }
    stages{
	
        stage('Docker Build'){
            steps{
				sh "docker build . -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} "
            }
        }
		stage('ECR Push'){
			steps{
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'cicd-user', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
					sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
					sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
					sh "$(aws ecr get-login --no-include-email --region us-east-1)"
					//sh "docker tag ${REPO_NAME}/${IMAGE_NAME}:${VERSION} ${ECR_URL}/${REPO_NAME}:${VERSION}"
					//sh "docker push ${ECR_URL}/${REPO_NAME}:${VERSION}"	
				}
			}
		}
		stage('Deployment on K8s'){
				steps{
					sh "chmod +x changeTag.sh"
					sh "./changeTag.sh ${VERSION}"
					sh 'ls'
					sh "cat latest-deployment.yaml"
					withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'cicd-user', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
						sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
						sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
						//sh 'mkdir -p ~/bin'
						//sh 'curl -o ~/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator'
						//sh 'chmod a+x ~/bin/aws-iam-authenticator'
						//sh 'export PATH=~/bin:$PATH'
						//sh label: '', script: 'echo \'export PATH=~/bin:$PATH\' >> ~/.bashrc'
						//echo "$PATH"
						//sh 'aws-iam-authenticator help'
						sh "export ECR_PASSWORD=$(aws ecr get-login --no-include-email | awk '{print $6}')"
						sh "kubectl delete secret aws-ecr || true"
						sh "kubectl create secret docker-registry aws-ecr --docker-server=https://${ECR_URL} --docker-username=AWS --docker-password=${ECR_PASSWORD}"
						sh "kubectl get secret aws-ecr
						//sh "kubectl apply -f latest-deployment.yaml"
						//sh "kubectl apply -f service.yaml"
						sh 'kubectl get pods'
					}
				}	
		}				
	}
  
}