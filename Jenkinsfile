pipeline{
    agent any
    environment{
				VERSION = "${BUILD_ID}"
				REPO_NAME1 = 'demo-test1'
				REPO_NAME1 = 'demo-test2'
				IMAGE_NAME1 = 'be1'
				IMAGE_NAME1 = 'be2'
				ECR_URL = '387637752303.dkr.ecr.us-east-1.amazonaws.com'
				GIT_URL = 'https://github.com/Chavhanshailesh/test1.git'
		
    }
    stages{
        stage('Docker Build'){
            steps{
				sh 'cd docker1'
				sh "docker build . -t ${REPO_NAME1}/${IMAGE_NAME1}:${VERSION}"
				sh 'cd ..'
				sh 'cd docker2'
				sh "docker build . -t ${REPO_NAME2}/${IMAGE_NAME2}:${VERSION}"
				sh 'cd ..'
            }

        }
		stage('ECR Push'){
			steps{
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
					sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
					sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
					sh '$(aws ecr get-login --no-include-email --region us-east-1)'
					sh 'docker tag ${REPO_NAME1}/${IMAGE_NAME1}:${VERSION} ${ECR_URL}/${REPO_NAME1}:${VERSION}'
					sh 'docker push ${ECR_URL}/${REPO_NAME1}:${VERSION}'
					
					sh 'docker tag ${REPO_NAME2}/${IMAGE_NAME2}:${VERSION} ${ECR_URL}/${REPO_NAME1}:${VERSION}'
					sh 'docker push ${ECR_URL}/${REPO_NAME2}:${VERSION}'
					
					sh "docker pull 387637752303.dkr.ecr.us-east-1.amazonaws.com/${REPO_NAME1}:${VERSION}"
					sh "docker pull 387637752303.dkr.ecr.us-east-1.amazonaws.com/${REPO_NAME2}:${VERSION}"
				}
			}
				
			
		}
				
	}
  
}