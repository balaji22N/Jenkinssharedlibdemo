@Library('Myfirstshlibs') _
pipeline {
  agent  any
  parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javapp')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'nishamoorthy')
  }
  stages {
    stage( 'Gitcheckout') {
      when { expression {  params.action == 'create' } }
      steps {
        script {
          gitCheckout(
                branch: "main",
                url: "https://github.com/balaji22N/Jenkinssharedlibdemo.git"
          )
        }
      }
    }
    stage( 'Mavenunittest') {
      when { expression {  params.action == 'create' } }
      steps {
        script {
          mvnTest()
        }
      }
    }
    stage('Integration Test maven'){
      when { expression {  params.action == 'create' } }
      steps{
        script{    
          mvnIntegrationTest()
        }
      }
    }
    stage('Static code analysis: Sonarqube'){
      when { expression {  params.action == 'create' } }
      steps{
        script{
          def SonarqubecredentialsID = 'sonarqubeapi'
          statiCodeAnalysis(SonarqubecredentialsID)
        }
      }
    }
    stage('QualityGateStatus: Sonarqube'){
      when { expression {  params.action == 'create' } }
      steps{
        script{
          def SonarqubecredentialsID = 'sonarqubeapi'
          QualityGateStatus(SonarqubecredentialsID)
        }
      }
    }
    stage( 'Mavenbuild : maven') {
      when { expression {  params.action == 'create' } }
      steps {
        script {
          mvnBuild()
        }
      }
    }
    stage('Docker Image Build'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   dockerBuild("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
 }
}
