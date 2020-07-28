pipeline {
	agent { label 'pypackage' }

	stages {
		stage('Setup Build') {
			steps {
				sh 'make clean'
			}
		}
		stage('Lint Code') {
			steps {
				sh 'make lint'
			}
		}
		stage('Test Python 3.6') {
			steps {
				sh 'make py36'
			}
		}
		stage('Test Python 3.7') {
			steps {
				sh 'make py37'
			}
		}
		stage('Test Python 3.8') {
			steps {
				sh 'make py38'
			}
		}
		stage('Coverage Report') {
			steps {
				sh 'make coverage_report'
			}
		}
		stage('Build Docs') {
			steps {
				sh 'make Docs'
			}
		}
		stage('Deploy') {
			steps {
				sh 'make package'
				echo 'TODO - deploy package'
			}
		}
	}
	post {
		always {
			junit 'reports/*junit.xml'
			cobertura(
				coberturaReportFile: "reports/coverage.xml",
				onlyStable: false,
				failNoReports: true,
				failUnhealthy: false,
				failUnstable: false,
				autoUpdateHealth: true,
				autoUpdateStability: true,
				zoomCoverageChart: true,
				maxNumberOfBuilds: 0,
				lineCoverageTargets: '80, 80, 80',
				conditionalCoverageTargets: '80, 80, 80',
				classCoverageTargets: '80, 80, 80',
				fileCoverageTargets: '80, 80, 80',
			)
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
