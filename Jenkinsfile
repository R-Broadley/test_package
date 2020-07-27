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
		always {
			publishHTML (target : [
				allowMissing: false,
				alwaysLinkToLastBuild: true,
				keepAll: true,
				reportDir: 'reports',
				reportFiles: 'static_analysis/static_analysis.html, 3.6/unit_test.html, 3.7/unit_test.html, 3.8/unit_test.html, coverage/index.html'
			])
		}
	}
}
