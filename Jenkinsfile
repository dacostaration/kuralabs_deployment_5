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
                # git clone https://github.com/dacostaration/kuralabs_deployment_5.git 
                # cd kuralabs_deployment_5
                # cd /home/ubuntu/dep5_docker/workspace/Deployment05_main
                # create tarball of deployment directory
                tar -cvf tarball.tar.gz .                
                # stop and remove "deploy05" container if it exists
                if [ "$(sudo docker ps -aq -f name=deploy05)" ]; then
                   sudo docker rm --force deploy05
                fi
                sudo docker build -t deploy05:v1.0 .
                '''
              }
            }
            stage ('DockerPush') { 
                agent {
                    label 'awsDocker'
                } 
                steps {
                    sh '''#!/bin/bash
                    sudo docker tag deploy05:v1.0 dacostar/deploy05:latest
                    sudo docker push dacostar/deploy05
                    '''
                }
            }
        }
}
