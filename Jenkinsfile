pipeline {
    agent any

    parameters {
        // choice(name: 'ENV', choices: ['sandbox-ocp', 'sandbox-iks', 'dev-iks', 'dev-iks-latest', 'stage-iks', 'production-iks'], description: 'Deployment environment')
        string defaultValue: 'HEAD', description: 'Repository Commit', name: 'COMMIT', trim: true
    }

    stages {
        stage('Setup env') {
            environment {
				DOCKER_CREDS = credentials('dockerhub')
                ICR_CREDS = credentials('jenkins-ibm-cloud-cr-api-key')
			}
            steps {
                sh label: 'Checkout commit', script: 'git checkout $COMMIT'
                sh label: 'Docker Login', script: 'echo $DOCKER_CREDS_PSW | docker --config ./ login -u=$DOCKER_CREDS_USR --password-stdin docker.io'
                sh label: 'ICR Login', script: 'echo $ICR_CREDS_PSW | docker --config ./ login -u=$ICR_CREDS_USR --password-stdin us.icr.io'
            }
        }

        stage('Build') {
            // when {
            //     environment name: 'IMAGE_EXISTS', value: '1'
            // }
            steps {
                sh label: 'Build', script: "docker --config ./ build -t  us.icr.io/apihub-cr/dev-pg/developer-container-utilities:latest ."
                sh label: 'Push Image', script: "docker --config ./ push  us.icr.io/apihub-cr/dev-pg/developer-container-utilities:latest"
            }
        }
    }

    post { 
        always {
            cleanWs()
        }
    }
}
