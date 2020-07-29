def index = 'none'

pipeline {
	agent { label 'pypackage' }

	stages {
		stage('Setup Build') {
			steps {
				sh 'make image'
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
				sh 'make docs'
			}
		}
		stage('Publish') {
			steps {
				sh 'make package'
				withCredentials([usernamePassword(
					credentialsId: 'devpi_stage',
					passwordVariable: 'passwd',
					usernameVariable: 'username')
				]) {
					script {
						def ver_regex = 'v(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)'
						if (env.TAG_NAME && env.TAG_NAME ==~ ver_regex) {
							index = 'prod'
						} else {
							index = 'stage'
						}
						sh "buildscripts/start_container.sh -e DEVPI_USER=$username -e DEVPI_PASSWD=$passwd -e DEVPI_INDEX=${index} test_package tox -e publish"
					}
				}
			}
		}
	}
	post {
		always {
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
		}
	}
}
