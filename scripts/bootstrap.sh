#!/bin/bash

yum update -y
yum install jq -y
yum install git -y
#yum install openssl -y
JQ_COMMAND=/usr/bin/jq
WORKER_NODES_CFN=https://s3.amazonaws.com/core-aws-launcher/create-eks-workers.yaml

usage() {
    cat <<EOF
    Usage: $0 [options]
        -h print usage
        -c EKS_CLUSTER_NAME
        -r ROLE_ARN
        -s SUBNET_IDS
        -g SECURITY_GROUP
        -n STACK_NAME
EOF
    exit 1
}


# ------------------------------------------------------------------
#          Read all inputs
# ------------------------------------------------------------------


while getopts ":c:r:s:g:n:ns" o; do
    case "${o}" in
        h) usage && exit 0
            ;;
        c) EKS_CLUSTER_NAME=${OPTARG}
            ;;
        r) ROLE_ARN=${OPTARG}
            ;;
        n) STACK_NAME=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

chown ec2-user:ec2-user -R /home/ec2-user/ 
export PATH=${PATH}:/home/ec2-user/bin

pip install awscli --upgrade 
mkdir -p /home/ec2-user/bin
cd /home/ec2-user/bin

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
export PATH=/usr/local/bin/:${PATH}


export AWS_INSTANCE_IAM_ROLE=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/)
export AWS_ACCESSKEYID=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${AWS_INSTANCE_IAM_ROLE} | ${JQ_COMMAND} '.AccessKeyId'| sed 's/"//g')
export AWS_SECRETACCESSKEY=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${AWS_INSTANCE_IAM_ROLE} | ${JQ_COMMAND} '.SecretAccessKey' | sed 's/"//g')
export AWS_SESSION_TOKEN=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${AWS_INSTANCE_IAM_ROLE} | ${JQ_COMMAND} '.Token' | sed 's/"//g')
export AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document/ | grep region | awk -F' : ' '{print $2}' | sed 's/"//g' | sed 's/,//g')
export AWS_DEFAULT_REGION=${AWS_REGION}
export AWS_ACCESS_KEY_ID=${AWS_ACCESSKEYID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRETACCESSKEY}
export AWS_DEFAULT_REGION=${AWS_REGION}
export AWS_INSTANCE_IAM_ROLE_ARN=$(curl -s http://169.254.169.254/latest/meta-data/iam/info/ | ${JQ_COMMAND}  '.InstanceProfileArn' | sed 's/"//g')
export AWS_INSTANCE_ID=$(ec2-metadata  |grep instance-id | awk -F': ' '{print $2}')


SECURITY_GROUP=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region ${AWS_REGION} | jq '.Stacks[0].Outputs[0].OutputValue' | sed 's/"//g')
SUBNET_IDS=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region ${AWS_REGION} | jq '.Stacks[0].Outputs[3].OutputValue' | sed 's/"//g')
VPC_ID=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region ${AWS_REGION} | jq '.Stacks[0].Outputs[2].OutputValue' | sed 's/"//g')


curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
chmod +x aws-iam-authenticator
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl
chmod +x kubectl
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

echo "aws eks create-cluster --name ${EKS_CLUSTER_NAME} --role-arn  ${ROLE_ARN} --resources-vpc-config subnetIds=${SUBNET_IDS},securityGroupIds=${SECURITY_GROUP} --region ${AWS_DEFAULT_REGION}"

aws eks create-cluster --name ${EKS_CLUSTER_NAME} --role-arn  ${ROLE_ARN} --resources-vpc-config subnetIds=${SUBNET_IDS},securityGroupIds=${SECURITY_GROUP} --region ${AWS_DEFAULT_REGION}

EKS_STATUS=$(aws eks describe-cluster --name ${EKS_CLUSTER_NAME} --query cluster.status --region ${AWS_REGION} | sed 's/"//g')

while true; do
    EKS_STATUS=$(aws eks describe-cluster --name ${EKS_CLUSTER_NAME} --query cluster.status --region ${AWS_REGION} | sed 's/"//g')
    case "$EKS_STATUS" in
          *ACTIVE* ) break;;
    esac
    sleep 10
done


KEYNAME=$(ec2-metadata |grep keyname | awk -F':' '{print $2}')
SUBNET_IDS_DQ=\"${SUBNET_IDS}\"

WORKER_STACK_NAME=${STACK_NAME}-EKSWorkers
HEADNODE=${STACK_NAME}-ControlNode

aws ec2 create-tags --resources  ${AWS_INSTANCE_ID} --tags "Key=Name,Value=${HEADNODE}" --region ${AWS_REGION}


export KUBECONFIG=/home/ec2-user/.kube/config
mkdir -p /home/ec2-user/.kube
#echo aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION}
aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION} --kubeconfig $KUBECONFIG
/home/ec2-user/bin/kubectl get svc

AMI_ID=$(curl -s http://169.254.169.254/latest/meta-data/ami-id)

NODE_GROUP_NAME=Ecsworker${WORKER_STACK_NAME}


aws cloudformation create-stack --stack-name ${WORKER_STACK_NAME} --template-url ${WORKER_NODES_CFN} --parameters \
ParameterKey=ClusterName,ParameterValue=${EKS_CLUSTER_NAME} \
ParameterKey=KeyName,ParameterValue=${KEYNAME} \
ParameterKey=ClusterControlPlaneSecurityGroup,ParameterValue=${SECURITY_GROUP} \
ParameterKey=Subnets,ParameterValue=${SUBNET_IDS_DQ} \
ParameterKey=VpcId,ParameterValue=${VPC_ID} \
ParameterKey=NodeImageId,ParameterValue=${AMI_ID} \
ParameterKey=NodeGroupName,ParameterValue=${NODE_GROUP_NAME} \
ParameterKey=NodeIamInstanceProfile,ParameterValue=${AWS_INSTANCE_IAM_ROLE_ARN} \
--capabilities CAPABILITY_IAM 


aws cloudformation wait stack-create-complete --stack-name ${WORKER_STACK_NAME} 
sleep 60

export NODEINSTANCEROLE=$(aws cloudformation describe-stacks --stack-name ${WORKER_STACK_NAME} | jq '.Stacks[0].Outputs[0].OutputValue' | sed 's/"//g')

#export NODEINSTANCEROLE=${AWS_INSTANCE_IAM_ROLE_ARN}

curl -O https://s3.amazonaws.com/core-aws-launcher/aws-auth-cm.yaml
envsubst < aws-auth-cm.yaml > aws-auth-cm-mod.yaml
kubectl apply -f  aws-auth-cm-mod.yaml 


curl -O https://s3.amazonaws.com/core-aws-launcher/gp2-storage-class.yaml
kubectl create -f gp2-storage-class.yaml
kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get storageclass

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/service-l4.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/patch-configmap-l4.yaml

kubectl patch service ingress-nginx -p '{"spec":{"externalTrafficPolicy":"Local"}}' -n ingress-nginx

while [[ "$(kubectl -n ingress-nginx get svc ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')" = '' ]]; do sleep 3; done
    INGRESS_IP=$(kubectl -n ingress-nginx get svc ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' | sed 's/"//g')
    echo "NGINX INGRESS: $INGRESS_IP"
    CJEHOSTNAME=`echo $INGRESS_IP | sed "s/\"//g"`

kubectl create namespace ${STACK_NAME}
kubectl config set-context $(kubectl config current-context) --namespace=${STACK_NAME}

#curl -O https://raw.githubusercontent.com/CloudBees/core-aws-launcher/master/cert/server.config
#sed -i -e "s#cje.example.com#$CJEHOSTNAME#" "server.config"

#openssl req -config server.config -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr

#openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

#kubectl create secret tls cjoc-tls --cert=server.crt --key=server.key

curl -O https://raw.githubusercontent.com/CloudBees/core-aws-launcher/master/manifest/cloudbees-core.yml
sed -i -e "s#cje.example.com#$CJEHOSTNAME#" "cloudbees-core.yml"
kubectl apply -f cloudbees-core.yml
kubectl rollout status sts cjoc

#kubectl get nodes --watch



