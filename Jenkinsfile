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
				}
				htmlFiles = [
					'static_analysis/static_analysis.html',
					htmlFiles.join(','),
					'coverage/index.html'
				]
				publishHTML([
					reportDir: 'reports/html',
					reportFiles: htmlFiles.join(','),
					reportName: 'Reports',
					allowMissing: false,
					alwaysLinkToLastBuild: true,
					keepAll: true])
			}
		}
	}
}
