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
			script {
				def htmlFiles
				dir ('reports') {
					htmlFiles = findFiles glob: '*.html'
				}
				publishHTML([
					reportDir: 'reports',
					reportFiles: htmlFiles.join(','),
					reportName: 'Test',
					allowMissing: false,
					alwaysLinkToLastBuild: true,
					keepAll: true])
			}
		}
	}
}
