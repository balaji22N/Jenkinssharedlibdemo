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
    stage( Gitcheckout) {
      steps {
        script {
          mvnTest()
        }
      }
    }
 }
}
