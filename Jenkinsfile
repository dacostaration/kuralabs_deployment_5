pipeline {
    agent any
        stages {
            stage ('Build') {
                steps {
                    sh '''#!/bin/bash
                    python3 -m venv test3
                    source test3/bin/activate
                    pip install pip --upgrade
                    pip install -r requirements.txt
                    export FLASK_APP=application
                    flask run &
                    '''
                }
            }
            stage ('test') {
                steps {
                    sh '''#!/bin/bash
                    source test3/bin/activate
                    py.test --verbose --junit-xml test-reports/results.xml
                    '''
                   }
                post{
                    always {
                    junit 'test-reports/results.xml'
                    }
                }
            }
             stage ('DockerCreateContainer') {
              agent{label 'awsDocker'}
              steps {
                sh '''#!/bin/bash
                git clone https://github.com/dacostaration/kuralabs_deployment_5.git cd kuralabs_deployment_5
                # create tarball of deployment directory
                tar -cvf tarball.tar.gz .                
                # stop and remove "deploy05" container if it exists
                if [ ! "$(docker ps -q -f name=deploy05)" ]; then
                    docker rm --force deploy05
                fi
                docker-compose up
                '''
              }
            }
        }
}
