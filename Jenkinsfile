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
	post {
		echo ${WORKSPACE}
		always {
			publishHTML (target : [
				allowMissing: false,
				alwaysLinkToLastBuild: true,
				keepAll: true,
				reportDir: 'reports',
				reportFiles: 'static_analysis/static_analysis.html'
			])
		}
	}
}
