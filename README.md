# Overview

This repository contains the AWS EKS Marketplace deployment resources to launch [CloudBees Core](https://www.cloudbees.com/products/cloudbees-core) on EKS. 

## Get Started

### Create the EKS Cluster and Deploy CloudBees Core

1. Click on the Launch button below to go to your CloudFormation console and create the stack. This will create a new EKS cluster and deploy CloudBees Core into the cluster. This uses the CloudFormation template in this repo, but located at the S3 location:

[create-eks-main.yaml](https://s3.amazonaws.com/core-aws-launcher/create-eks-main.yaml)

<a href="https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=cloudbees-core-1&amp;templateURL=https://s3.amazonaws.com/core-aws-launcher/create-eks-main.yaml"><img alt="Launch CloudBees Core Stack" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQ0IiBoZWlnaHQ9IjI3IiB2aWV3Qm94PSIwIDAgMTQ0IDI3IiB4bWxucz0i%0D%0AaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjx0aXRsZT5MYXVuY2ggU3RhY2s8L3RpdGxlPjxk%0D%0AZWZzPjxsaW5lYXJHcmFkaWVudCB4MT0iNTAlIiB5MT0iMCUiIHgyPSI1MCUiIHkyPSIxMDAlIiBp%0D%0AZD0iYSI+PHN0b3Agc3RvcC1jb2xvcj0iI0ZGRTRCMiIgb2Zmc2V0PSIwJSIvPjxzdG9wIHN0b3At%0D%0AY29sb3I9IiNGNzk4MDAiIG9mZnNldD0iMTAwJSIvPjwvbGluZWFyR3JhZGllbnQ+PGxpbmVhckdy%0D%0AYWRpZW50IHgxPSI0NS4wMTclIiB5MT0iMTAwJSIgeDI9IjY4LjA4MiUiIHkyPSIzLjMyJSIgaWQ9%0D%0AImIiPjxzdG9wIHN0b3AtY29sb3I9IiMxNTE0NDMiIG9mZnNldD0iMCUiLz48c3RvcCBzdG9wLWNv%0D%0AbG9yPSIjNkQ4MEIyIiBvZmZzZXQ9IjEwMCUiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48ZyBm%0D%0AaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik0yIDV2MTdjMCAxLjY2IDEu%0D%0AMzQgMyAzIDNoMTI1LjVjNi4zNDggMCAxMS41LTUuMTUgMTEuNS0xMS41QzE0MiA3LjE0OCAxMzYu%0D%0AODUyIDIgMTMwLjUgMkg1QzMuMzQgMiAyIDMuMzQgMiA1eiIgZmlsbD0idXJsKCNhKSIvPjxwYXRo%0D%0AIGQ9Ik0yIDV2MTdjMCAxLjY2IDEuMzQgMyAzIDNoMTI1LjVjNi4zNDggMCAxMS41LTUuMTUgMTEu%0D%0ANS0xMS41QzE0MiA3LjE0OCAxMzYuODUyIDIgMTMwLjUgMkg1QzMuMzQgMiAyIDMuMzQgMiA1ek0w%0D%0AIDVjMC0yLjc2MiAyLjIzMy01IDUtNWgxMjUuNWM3LjQ1NiAwIDEzLjUgNi4wNDMgMTMuNSAxMy41%0D%0AIDAgNy40NTYtNi4wNSAxMy41LTEzLjUgMTMuNUg1Yy0yLjc2MiAwLTUtMi4yMzItNS01VjV6IiBm%0D%0AaWxsPSIjMDA1OEE1Ii8+PGNpcmNsZSBmaWxsPSJ1cmwoI2IpIiBjeD0iMTI5LjUiIGN5PSIxMy41%0D%0AIiByPSI5LjUiLz48cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTMzIDEzLjVsLTUgNC41VjkiLz48cGF0%0D%0AaCBkPSJNMTguMTM2IDE5aDYuNHYtMS42NDhoLTQuNDMyVjguMjE2aC0xLjk2OFYxOXptMTQuMDY4%0D%0AIDBjLS4wOC0uNDgtLjExMi0xLjE2OC0uMTEyLTEuODcydi0yLjgxNmMwLTEuNjk2LS43Mi0zLjI4%0D%0ALTMuMjE2LTMuMjgtMS4yMzIgMC0yLjI0LjMzNi0yLjgxNi42ODhsLjM4NCAxLjI4Yy41MjgtLjMz%0D%0ANiAxLjMyOC0uNTc2IDIuMDk2LS41NzYgMS4zNzYgMCAxLjU4NC44NDggMS41ODQgMS4zNnYuMTI4%0D%0AYy0yLjg4LS4wMTYtNC42MjQuOTc2LTQuNjI0IDIuOTQ0IDAgMS4xODQuODggMi4zMiAyLjQ0OCAy%0D%0ALjMyIDEuMDA4IDAgMS44MjQtLjQzMiAyLjMwNC0xLjA0aC4wNDhsLjEyOC44NjRoMS43NzZ6bS0y%0D%0ALjAzMi0yLjczNmMwIC4xMjgtLjAxNi4yODgtLjA2NC40MzItLjE3Ni41Ni0uNzUyIDEuMDcyLTEu%0D%0ANTM2IDEuMDcyLS42MjQgMC0xLjEyLS4zNTItMS4xMi0xLjEyIDAtMS4xODQgMS4zMjgtMS40ODgg%0D%0AMi43Mi0xLjQ1NnYxLjA3MnptMTEuMDc2LTUuMDU2SDM5LjI4djQuNzA0YzAgLjIyNC0uMDQ4LjQz%0D%0AMi0uMTEyLjYwOC0uMjA4LjQ5Ni0uNzIgMS4wNTYtMS41MDQgMS4wNTYtMS4wNCAwLTEuNDU2LS44%0D%0AMzItMS40NTYtMi4xMjh2LTQuMjRIMzQuMjR2NC41NzZjMCAyLjU0NCAxLjI5NiAzLjM5MiAyLjcy%0D%0AIDMuMzkyIDEuMzkyIDAgMi4xNi0uOCAyLjQ5Ni0xLjM2aC4wMzJMMzkuNTg0IDE5aDEuNzI4Yy0u%0D%0AMDMyLS42NC0uMDY0LTEuNDA4LS4wNjQtMi4zMzZ2LTUuNDU2ek00My40NzYgMTloMS45ODR2LTQu%0D%0ANTc2YzAtLjIyNC4wMTYtLjQ2NC4wOC0uNjQuMjA4LS41OTIuNzUyLTEuMTUyIDEuNTM2LTEuMTUy%0D%0AIDEuMDcyIDAgMS40ODguODQ4IDEuNDg4IDEuOTY4VjE5aDEuOTY4di00LjYyNGMwLTIuNDY0LTEu%0D%0ANDA4LTMuMzQ0LTIuNzY4LTMuMzQ0LTEuMjk2IDAtMi4xNDQuNzM2LTIuNDggMS4zNDRoLS4wNDhs%0D%0ALS4wOTYtMS4xNjhoLTEuNzI4Yy4wNDguNjcyLjA2NCAxLjQyNC4wNjQgMi4zMlYxOXptMTQuNzA4%0D%0ALTEuNjk2Yy0uMzg0LjE2LS44NjQuMzA0LTEuNTUyLjMwNC0xLjM0NCAwLTIuMzg0LS45MTItMi4z%0D%0AODQtMi41MTItLjAxNi0xLjQyNC44OC0yLjUyOCAyLjM4NC0yLjUyOC43MDQgMCAxLjE2OC4xNiAx%0D%0ALjQ4OC4zMDRsLjM1Mi0xLjQ3MmMtLjQ0OC0uMjA4LTEuMTg0LS4zNjgtMS45MDQtLjM2OC0yLjcz%0D%0ANiAwLTQuMzM2IDEuODI0LTQuMzM2IDQuMTYgMCAyLjQxNiAxLjU4NCAzLjk2OCA0LjAxNiAzLjk2%0D%0AOC45NzYgMCAxLjc5Mi0uMjA4IDIuMjA4LS40bC0uMjcyLTEuNDU2ek02MC4wMTIgMTloMS45ODR2%0D%0ALTQuNjU2YzAtLjIyNC4wMTYtLjQzMi4wOC0uNTkyLjIwOC0uNTkyLjc1Mi0xLjEwNCAxLjUyLTEu%0D%0AMTA0IDEuMDg4IDAgMS41MDQuODQ4IDEuNTA0IDEuOTg0VjE5aDEuOTY4di00LjU5MmMwLTIuNDk2%0D%0ALTEuMzkyLTMuMzc2LTIuNzItMy4zNzYtLjQ5NiAwLS45Ni4xMjgtMS4zNDQuMzUyLS40MTYuMjI0%0D%0ALS43MzYuNTI4LS45NzYuODk2aC0uMDMyVjcuNjRoLTEuOTg0VjE5em0xMi4yNjQtLjUxMmMuNTky%0D%0ALjM1MiAxLjc3Ni42NzIgMi45MTIuNjcyIDIuNzg0IDAgNC4wOTYtMS41MDQgNC4wOTYtMy4yMzIg%0D%0AMC0xLjU1Mi0uOTEyLTIuNDk2LTIuNzg0LTMuMi0xLjQ0LS41Ni0yLjA2NC0uOTQ0LTIuMDY0LTEu%0D%0ANzc2IDAtLjYyNC41NDQtMS4yOTYgMS43OTItMS4yOTYgMS4wMDggMCAxLjc2LjMwNCAyLjE0NC41%0D%0AMTJsLjQ4LTEuNTg0Yy0uNTYtLjI4OC0xLjQyNC0uNTQ0LTIuNTkyLS41NDQtMi4zMzYgMC0zLjgw%0D%0AOCAxLjM0NC0zLjgwOCAzLjEwNCAwIDEuNTUyIDEuMTM2IDIuNDk2IDIuOTEyIDMuMTM2IDEuMzc2%0D%0ALjQ5NiAxLjkyLjk3NiAxLjkyIDEuNzkyIDAgLjg4LS43MDQgMS40NzItMS45NjggMS40NzItMS4w%0D%0AMDggMC0xLjk2OC0uMzItMi42MDgtLjY4OGwtLjQzMiAxLjYzMnptOS4wNzYtOS4wNHYxLjc2aC0x%0D%0ALjEydjEuNDcyaDEuMTJ2My42NjRjMCAxLjAyNC4xOTIgMS43MjguNjA4IDIuMTc2LjM2OC40Ljk3%0D%0ANi42NCAxLjY5Ni42NC42MjQgMCAxLjEzNi0uMDggMS40MjQtLjE5MmwtLjAzMi0xLjUwNGMtLjE3%0D%0ANi4wNDgtLjQzMi4wOTYtLjc2OC4wOTYtLjc1MiAwLTEuMDA4LS40OTYtMS4wMDgtMS40NHYtMy40%0D%0ANGgxLjg3MnYtMS40NzJoLTEuODcyVjguOTg0bC0xLjkyLjQ2NHpNOTIuODkyIDE5Yy0uMDgtLjQ4%0D%0ALS4xMTItMS4xNjgtLjExMi0xLjg3MnYtMi44MTZjMC0xLjY5Ni0uNzItMy4yOC0zLjIxNi0zLjI4%0D%0ALTEuMjMyIDAtMi4yNC4zMzYtMi44MTYuNjg4bC4zODQgMS4yOGMuNTI4LS4zMzYgMS4zMjgtLjU3%0D%0ANiAyLjA5Ni0uNTc2IDEuMzc2IDAgMS41ODQuODQ4IDEuNTg0IDEuMzZ2LjEyOGMtMi44OC0uMDE2%0D%0ALTQuNjI0Ljk3Ni00LjYyNCAyLjk0NCAwIDEuMTg0Ljg4IDIuMzIgMi40NDggMi4zMiAxLjAwOCAw%0D%0AIDEuODI0LS40MzIgMi4zMDQtMS4wNGguMDQ4bC4xMjguODY0aDEuNzc2em0tMi4wMzItMi43MzZj%0D%0AMCAuMTI4LS4wMTYuMjg4LS4wNjQuNDMyLS4xNzYuNTYtLjc1MiAxLjA3Mi0xLjUzNiAxLjA3Mi0u%0D%0ANjI0IDAtMS4xMi0uMzUyLTEuMTItMS4xMiAwLTEuMTg0IDEuMzI4LTEuNDg4IDIuNzItMS40NTZ2%0D%0AMS4wNzJ6bTkuNTU2IDEuMDRjLS4zODQuMTYtLjg2NC4zMDQtMS41NTIuMzA0LTEuMzQ0IDAtMi4z%0D%0AODQtLjkxMi0yLjM4NC0yLjUxMi0uMDE2LTEuNDI0Ljg4LTIuNTI4IDIuMzg0LTIuNTI4LjcwNCAw%0D%0AIDEuMTY4LjE2IDEuNDg4LjMwNGwuMzUyLTEuNDcyYy0uNDQ4LS4yMDgtMS4xODQtLjM2OC0xLjkw%0D%0ANC0uMzY4LTIuNzM2IDAtNC4zMzYgMS44MjQtNC4zMzYgNC4xNiAwIDIuNDE2IDEuNTg0IDMuOTY4%0D%0AIDQuMDE2IDMuOTY4Ljk3NiAwIDEuNzkyLS4yMDggMi4yMDgtLjRsLS4yNzItMS40NTZ6bTMuNzk2%0D%0ALTkuNjY0aC0xLjk2OFYxOWgxLjk2OHYtMi42NTZsLjY3Mi0uNzg0IDIuMjQgMy40NGgyLjQxNmwt%0D%0AMy4yOTYtNC42MDggMi44OC0zLjE4NGgtMi4zNjhsLTEuODg4IDIuNTEyYy0uMjA4LjI3Mi0uNDMy%0D%0ALjYwOC0uNjI0LjkxMmgtLjAzMlY3LjY0eiIgZmlsbD0iIzAwMCIvPjwvZz48L3N2Zz4="></a>

2. Click Next to go to the CloudFormation Details section to enter your input values.
3. Enter the following:

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

### Connect to the EKS Cluster
1. When completed, go to the [EC2 console](https://console.aws.amazon.com/ec2) to get the public IP of the EC2 controller node.
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
`kubectl exec cjoc-0 -- cat /var/jenkins_home/secrets/initialAdminPassword`
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