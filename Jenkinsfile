pipeline {
    agent any
    stages {
        stage('Build and Test') {
            steps {
			    sh "mvn --quiet --batch-mode install"
                sh "docker build -t afalko/dockerfile-image-update:${BUILD_ID} ."
            }
        }
        stage('Publish') {
		    environment { 
                DOCKER_PASSWORD = credentials('DOCKER_PASSWORD') 
            }
			when {
              	expression {
                	BRANCH_NAME == "master"
              	}
            }
            steps {
			    sh "docker login -u afalko -p ${DOCKER_PASSWORD}"
                sh "docker push afalko/dockerfile-image-update:${BUILD_ID}"
            }
        }
        stage('Update Docker Images') {
		    environment {
				git_api_url = 'https://api.github.com'
				git_api_token = credentials('DOCKERFILE_IMAGE_UPDATE_TOKEN')
				image_map_store = 'docker-tag-store-df17-demo'
			}
            steps {
                sh "docker run --rm -e git_api_token -e git_api_url \
					salesforce/dockerfile-image-update --org afalko \
					parent afalko/hello-world-app ${BUILD_ID} ${image_map_store}"
            }
        }
    }
}
