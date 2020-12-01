pipeline {
   agent any
   
   environment {
       DEMO='1.3'
   }

   stages {
      stage('Lint') {
         steps {
            sh '''
                  make lint
            '''
         }
      }
      stage('Integration') {
         steps {
            sh '''
               chmod +x ./scripts/integration/build.sh
               ./scripts/integration/build.sh
            '''
         }
      }
      stage('Deploy') {
         steps {
            sh '''
               chmod +x ./scripts/deploy/deploy.sh
               ./scripts/deploy/deploy.sh
            '''
         }
      }
   }
}
