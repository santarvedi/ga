#!/bin/bash-
#/bin/clear

AWS_REGION='us-east-2'
AWS_DEV_KEY=''
AWS_DEV_SECRET=''
AWS_PROD_KEY=''
AWS_PROD_SECRET=''

DEV_ECR_URL='111111111111.dkr.ecr.us-east-2.amazonaws.com'
PROD_ECR_URL='222222222222.dkr.ecr.us-east-2.amazonaws.com'

CHART_REPO='thermofisherky/helm-chart'
CHART_NAME='thermofisher-metachart'
CHART_VERSION='1.0.0-500'



CHECK_LOGIN(){
 echo $(aws sts get-caller-identity)
}

HELM_LOGIN(){
  local ECR_URL=$3

   export AWS_ACCESS_KEY_ID=$1
   export AWS_SECRET_ACCESS_KEY=$2
   export AWS_DEFAULT_REGION='us-east-2'

   LOGIN=$(aws ecr get-login-password  --region ${AWS_REGION}  | helm registry login  --username AWS  --password-stdin $ECR_URL >/dev/null 2>&1)
}


DOCKER_LOGIN(){
   local ECR_URL=$3

   export AWS_ACCESS_KEY_ID=$1
   export AWS_SECRET_ACCESS_KEY=$2
   export AWS_DEFAULT_REGION='us-east-2'
   LOGIN=$(aws ecr get-login-password  --region ${AWS_REGION} | docker login  --username AWS  --password-stdin $ECR_URL >/dev/null 2>&1)
}

#DEV
HELM_LOGIN "$AWS_DEV_KEY" "$AWS_DEV_SECRET" "$DEV_ECR_URL"

mkdir -v -p /tmp/${CHART_NAME}
cd /tmp/${CHART_NAME}
echo ""
echo "-----------------------------------------------------------------------------------"
echo "Pilling metachart - ${CHART_REPO}/${CHART_NAME}:${CHART_VERSION} from Dev ECR"
echo ""
helm pull oci://${DEV_ECR_URL}/${CHART_REPO}/${CHART_NAME}:${CHART_VERSION}
echo ""
echo "------------------------------------------------------------------------------------"


#PROD
HELM_LOGIN "$AWS_PROD_KEY" "$AWS_PROD_SECRET" "$PROD_ECR_URL"

#Push Metachart Version - If NOT EXISTS
echo ""
if aws ecr describe-images --repository-name ${CHART_REPO}/${CHART_NAME} --image-ids imageTag=${CHART_VERSION} >/dev/null 2>&1; then
  echo "Metachart - ${CHART_NAME}:${CHART_VERSION} - Found in PROD ECR; Skipping.."
else 
  echo "Metachart - ${CHART_NAME}:${CHART_VERSION} - NOT Found in PROD ECR; Pushing.."
helm push /tmp/${CHART_NAME}/${CHART_NAME}-${CHART_VERSION}.tgz oci://${PROD_ECR_URL}/${CHART_REPO}
fi

tar -xvf ${CHART_NAME}-${CHART_VERSION}.tgz >/dev/null 2>&1
cd ${CHART_NAME}

#LOOP
echo ""
echo "Charts:"
helm template . -f versions/version.yaml |egrep  "^\s+source" -A3|egrep -v "source|repoURL"|egrep -v "\-\-"|awk -F":" '{print $2}' |awk 'NF'|paste -d' ' - - |sort -u|while read -r repo_url tag;
do
#echo ""
#echo $repo_url:$tag;
#echo ""


helm pull oci://${DEV_ECR_URL}/${CHART_REPO}/$repo_url:$tag >/dev/null 2>&1

##Create Repository - If NOT EXISTS
if aws ecr describe-repositories --repository-name ${CHART_REPO}/"$repo_url" >/dev/null 2>&1; then
   :
   #echo "Repository - ${CHART_REPO}/$repo_url - Found in PROD ECR; Skipping.."
   #echo "" 
else
   aws ecr create-repository --repository-name ${CHART_REPO}/"$repo_url" --region "$AWS_REGION" >/dev/null 2>&1
fi


##Push Helm Chart version - If NOT EXISTS
if aws ecr describe-images --repository-name ${CHART_REPO}/"$repo_url" --image-ids imageTag=$tag >/dev/null 2>&1; then
   echo "Chart Version - ${CHART_REPO}/"$repo_url":$tag - Found in PROD ECR; Skipping.."
else
   helm push $repo_url:$tag.tgz oci://${PROD_ECR_URL}/${CHART_REPO}
fi

done

#--------------------------------------------------------------------------
#Images
echo ""
echo "Images:"
helm template . -f versions/version.yaml| grep "repository" -A 1 | grep -v "\-\-" |awk -F":" '{print $2}' | awk '{$1=$1};1' | paste -d ':' - -|sort -u >./.images_list

while IFS= read -r line;
do
  image=$(echo $line | awk -F":" '{print $1}')
  tag=$(echo $line |awk -F":" '{print $2}')
  #echo $image:$tag
  if aws ecr describe-images --repository-name $image --image-ids imageTag=$tag >/dev/null 2>&1; then
     echo "$image:$tag - Found in PROD ECR; Skipping.."
  else
     DOCKER_LOGIN "$AWS_DEV_KEY" "$AWS_DEV_SECRET" "$DEV_ECR_URL"
     echo "$image:$tag - Pull from DEV ECR.." 
     docker pull ${DEV_ECR_URL}/${image}:${tag}
     echo "$image:$tag - Tagging for PROD ECR"
     docker tag ${DEV_ECR_URL}/${image}:${tag} ${PROD_ECR_URL}/${image}:${tag}

     DOCKER_LOGIN "$AWS_PROD_KEY" "$AWS_PROD_SECRET" "$PROD_ECR_URL"
     echo "$image:$tag - Pushing to PROD ECR.." 
     docker push ${PROD_ECR_URL}/${image}:${tag}
     docker rmi ${PROD_ECR_URL}/${image}:${tag}
     docker rmi ${DEV_ECR_URL}/${image}:${tag}
  fi

done < ./.images_list
