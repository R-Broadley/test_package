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
			junit 'reports/*junit.xml'
			script {
				def htmlFiles
				dir ('reports/html') {
					htmlFiles = findFiles glob: '*/unit_test.html'
					htmlFiles.add('static_analysis/static_analysis.html')
					htmlFiles.add('coverage/index.html')
				}
				publishHTML([
					reportDir: 'reports',
					reportFiles: htmlFiles.join(','),
					reportName: 'Reports',
					allowMissing: false,
					alwaysLinkToLastBuild: true,
					keepAll: true])
			}
		}
	}
}
