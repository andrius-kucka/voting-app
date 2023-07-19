<p align="center">  Home Assignment - to deploy Example Voting App with Terraform to AWS</p>

#### Instructions on how to install voting application:

I have used same k8s-specifications folder as in [example-voting-app](https://github.com/dockersamples/example-voting-app). It can just be pulled from the given link and with given tf files the application get deployed to AWS as well.

##### Prerequisites

 Install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli), [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), [kubectl](https://kubernetes.io/docs/tasks/tools/) and AWS Account ready.

1. Clone this repo (or use all terraform files and copy them to parent folder of original voting app that is given in the home assignment).

2. Get or create an IAM User on your AWS Account with following access rights:
 **AdministratorAccess** and **AmazonEKSClusterPolicy** 

3. From the region that will be used get two different subnet id's. Add them in the `values.tfvars` file at the root of this project (replace `subnet-id1` and `subnet-id2`).

4. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environement variables.

5. From CLI in the root directory of this repo:
  - `terraform init`
  - `terraform plan -var-file=values.tfvars`. 
**This concludes the dry-run. Next step start creating resources in the AWS account**
  - `terraform apply -var-file=values.tfvars`.

6. We have deployed an EKS cluster to AWS, now we need to link our kubectl installation to the cluster: 
`aws eks update-kubeconfig --region eu-central-1 --name eks_cluster_voting_app` **(region can be different)**.
Once done, run `kubectl get pods -A`, if it working you've done with your fresh EKS cluster.

7. From CLI in the root directory of this repo:
  - `kubectl create namespace vote`
  - `kubectl apply -f k8s-specifications --namespace=vote`

8. Now you can access application. Use "Public IPv4 address" that is given to the created EC2 instance and put it in your browser. For Vote App use [ip_Address]:31000 and for Result App use [ip_Address]:31001
