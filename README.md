# Overview

This repository contains the resources to launch [CloudBees Core](https://www.cloudbees.com/products/cloudbees-core) on EKS using CloudFormation. 

## Get Started

### Create the EKS Cluster and Deploy CloudBees Core

1. Click on the Launch button below to go to your CloudFormation console and create the stack. This will create a new EKS cluster and deploy CloudBees Core into the cluster. This uses the CloudFormation template in this repo, but located at the S3 location:

[create-eks-main.yaml](https://s3.amazonaws.com/core-aws-launcher/create-eks-main.yaml)

<a href="https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=cloudbees-core-1&amp;templateURL=https://s3.amazonaws.com/core-aws-launcher/create-eks-main.yaml"><img alt="Launch CloudBees Core Stack" src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"></a>

2. Click Next to go to the CloudFormation Details section to enter your input values.
3. Enter the following:

* **Stack name** (required) - This is the CloudFormation stack name and also the namespace name for CloudBees Core to be used below.
* **BootstrapArguments** (optional) - See files/bootstrap.sh in https://github.com/awslabs/amazon-eks-ami
* **ClusterName** (required) - This is the name of the new EKS cluster.
* **EKSRoleARN** (required) - This is the IAM role that EKS will use to access other AWS services. It must have AmazonEKSClusterPolicy and AmazonEKSServicePolicy.
* **KeyName** (required) - This is the key pair to use for SSH.
* **NodeAutoScalingGroupMaxSize, NodeAutoScalingGroupMinSize** (required) - This is the EC2 node autoscaling range.
* **NodeGroupName** (required) - Name of the EC2 node group.
* **NodeVolumeSize** (required) - The volume size to use for the nodes.

4. Click Next on the next steps and follow through to create the stack.
5. Monitor the status of the stack as the resources are created.
6. Go to the [EKS Console](https://console.aws.amazon.com/eks/) and wait for the EKS cluster to be created. This will take several minutes.
7. Go to the EC2 console and ensure that your EKS worker nodes are ready (running and checks complete).

![EC2 Console](https://s3.amazonaws.com/core-aws-launcher/EC2-EKS-nodes.png)

### Connect to the EKS Cluster
1. When completed and the EKS cluster shows *Active*, go to the [EC2 console](https://console.aws.amazon.com/ec2) to get the public IP of the EC2 controller node.
2. SSH to the controller node using the key pair that you specified.

`ssh -i <key.pem> <controller-node-ip>`

3. Set the kubeconfig.

`export KUBECONFIG=/home/ec2-user/.kube/config`

4. Set your kubernetes context.

`sudo aws eks update-kubeconfig --name <eks-cluster-name> --region <region> --kubeconfig $KUBECONFIG`

5. Execute the following to get the list of namespaces.

`kubectl get namespaces`

You should see something like this.

```
NAME               STATUS    AGE
cloudbees-core-1   Active    2m
default            Active    8m
ingress-nginx      Active    2m
kube-public        Active    8m
kube-system        Active    8m
```

6. Get the URL for CloudBees Core.

`kubectl -n ingress-nginx get svc ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'`

7. Get the initial admin password.

`kubectl exec -n <cloudformation stackname> cjoc-0 -- cat /var/jenkins_home/secrets/initialAdminPassword`

8. Enter that URL into your browser.
9. You will be presented with the CloudBees Core setup wizard. The first step is to enter the initial admin password. Enter it from above.
10. Complete the next steps of the setup wizard to install plugins and create your first user. You may request a trial license or enter a commercial license.

## Next Steps
### Create a Team and Connect a Repo
[Follow these steps to create a team and connect your repo.](https://go.cloudbees.com/docs/cloudbees-core/cloud-admin-guide/getting-started/#)

### HTTPS Setup
[Follow these steps to configure CloudBees Core for HTTPS.](https://go.cloudbees.com/docs/cloudbees-core/cloud-install-guide/eks-install/#_https_setup)

### DNS Setup
[Follow these steps to configure DNS for CloudBees Core](https://go.cloudbees.com/docs/cloudbees-core/cloud-install-guide/eks-install/#_dns_record)

## Licensing
Request a license by sending an email to info@cloudbees.com or support@cloudbees.com.

## CloudBees Support
[CloudBees Support](https://go.cloudbees.com/)

## Open Source Jenkins Dedicated Support
[Jenkins Support](https://www.cloudbees.com/products/cloudbees-jenkins-support)

## Additional Documentation
* [Using CloudBees Core on EKS](https://go.cloudbees.com/docs/cloudbees-core/cloud-install-guide/eks-install/)
* [Reference Architecture](https://go.cloudbees.com/docs/cloudbees-core/cloud-reference-architecture/ra-for-eks/)
* [Solution Brief](https://pages.cloudbees.com/l/272242/2018-06-26/9sjwj/272242/54721/cloudbees_core.pdf)