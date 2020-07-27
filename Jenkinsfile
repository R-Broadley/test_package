pipeline {
    agent { label 'pypackage' }

    stages {
        stage('Tox') {
            steps {
                echo 'Building..'
								sh 'make'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
