<h1>Containerization and CI/CD pipeline of deployment 5 </h1>

<h2>(1) Set up and configure your Jenkins environment and agents on an EC2 within default VPC.</h2>


- install and configure jenkins on an EC2 to listen on port 22 to be able to SSH into the EC2, and 8080 to access Jenkins' web interface. Access the web interface for Jenkins in your web browser and configure two Jenkins agents profiles. One agent profile for the Terraform EC2 and another Jenkins agent profile for the Docker EC2.


- Also On jenkins, configure the credentials for your AWS user where you would set up your aws_access_key and aws_private_key to allow you to build build your infrustructure via terraform. 
  Jenkins needs credentials that it will use in its pipeline so that Terraform is authorised to control the resources in the infrastructure.


  <h2>(2) Set up and configure two EC2's </h2>

  - On the first EC2 install Terraform to create the architecture via terraform and on the second EC2 install Docker to containerize the Flask application.


  <h2>(3) Create a Jenkinsfile </h2>

  - In this jenkinsfile all the steps on how to build, test, containerize the application, tag and push the image of the flask application to dockerhub. Also the Init, Plan, Apply and destroy stages will be added to build the infrustructure using terraform. The build stage will install of the dependencies needed for the application to run. The test stage test to see of a status code of <200> is received when the home page of the application. The Deploy stage downloads the python image, creates a container using that image, tags that image and puches it to dockerhub which will be used to deploy to ECS.
  The Init stage Initializes terraform create a state file
  which records the current state of the infrustructure. The plan stage will build out and blueprint of all the resources the you intend to create with AWS. The apply stage will actually start creating
  all the resources in AWS which was planned in the plan stage. Finally the destroy stage will delete all the recources that was created in AWS. 

  Please refer to the Jenkinsfile for the code (https://github.com/cceliuss187/Deployment-4/blob/main/Deployment_4-Documentation.md)


  <h2>(4) Create a Dockerfile </h2>
  - the docker file will contain a script of instructions that Docker will use to create a container image in order to containerize the python aplication.


  Please refer to the dockerfile for the code (https://github.com/cceliuss187/Deployment-4/blob/main/Deployment_4-Documentation.md)


  <h2>(5) Create a Role </h2>

  - On the AWS web platform, navigate to the IAM section and create a role called "AmazonECSTaskExecutionRolePolicy". This role grants the permissions that are needed by the Amazon ECS container agent and AWS Fargate container agents to make AWS API calls on your behalf. After get the ARN from the role and paste it on lines 55 and 56 of main.tf within the intTerrafrom folder. The ARNs or Amazon Resource Names uniquely are used to identify AWS resources. 



<h2>(6) Create a pipeline build in jenkins.</h2>

- This is where the steps on how to build, test,Deploy, Init, Plan, Apply and destroy the application's infrustructure will be defined and orchestrated.


  <h2>(7) Possible Errors.</h2>

Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied

<h4>Fix</h4>

- add the user to the docker group

```
sudo usermod -a -G docker $USER
sudo reboot
```

