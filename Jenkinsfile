@Library('Myfirstshlibs') _
pipeline {
  agent  any
  stages {
    stage( Gitcheckout) {
      steps {
        script {
          gitCheckout(
                branch: "main",
                url: "https://github.com/balaji22N/Jenkinssharedlibdemo.git"
          )
        }
      }
    }
    stage( Mavenunittest) {
      steps {
        script {
          mvnTest()
        }
      }
    }
    stage('Static code analysis: Sonarqube'){
      steps{
        script{
          def SonarqubecredentialsID = 'sonarqubeapi'
          statiCodeAnalysis(SonarqubecredentialsID)
        }
      }
    }
    stage('QualityGateStatus: Sonarqube'){
      steps{
        script{
          def SonarqubecredentialsID = 'sonarqubeapi'
          QualityGateStatus(SonarqubecredentialsID)
        }
      }
    }
    stage( Mavenbuild) {
      steps {
        script {
          mvnBuild()
        }
      }
    }
 }
}
