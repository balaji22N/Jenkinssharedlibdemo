@Library('Myfirstshlibs') _
pipeline {
  agent  any
  parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javapp')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'nishamoorthy')
        string(name: 'cluster', description: "name of the EKS Cluster", defaultValue: 'demo-cluster1')
        
  }
  environment{

        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
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
    stage('Docker Image scanner'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
    stage('Docker Image : push'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   dockerImagePush("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
    #stage('Docker Image : cleanup'){
         #when { expression {  params.action == 'create' } }
            #steps{
               #script{
                   #dockerImageCleanup("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               #}
            #}
        #}
    stage('Create EKS Cluster : Terraform'){
            when { expression {  params.action == 'create' } }
            steps{
                script{

                    dir('eks_module') {
                      sh """
                          
                          terraform init 
                          terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file=./config/terraform.tfvars
                          terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file=./config/terraform.tfvars --auto-approve
                      """
                  }
                }
            }
        }
        stage('Connect to EKS '){
            when { expression {  params.action == 'create' } }
        steps{

            script{

                sh """
                aws configure set aws_access_key_id "$ACCESS_KEY"
                aws configure set aws_secret_access_key "$SECRET_KEY"
                aws configure set region "${params.Region}"
                aws eks --region ${params.Region} update-kubeconfig --name ${params.cluster}
                """
            }
        }
        } 
        stage('Deployment on EKS Cluster'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                  
                  def apply = false

                  try{
                    input message: 'please confirm to deploy on eks', ok: 'Ready to apply the config ?'
                    apply = true
                  }catch(err){
                    apply= false
                    currentBuild.result  = 'UNSTABLE'
                  }
                  if(apply){

                    sh """
                      kubectl apply -f .
                    """
                  }
                }
            }
        }
 }
}
