#!/usr/bin/env bash

export GKE1=gke-1-prod
export GKE3=gke-3-prod
export GKE1_ZONE=us-west2
export GKE3_ZONE=us-central1
export SVC_1_PROJECT=$(gcloud projects list --filter svc1 --format="value(PROJECT_ID)")
export SVC_2_PROJECT=$(gcloud projects list --filter svc2 --format="value(PROJECT_ID)")
touch asm-kubeconfig && export KUBECONFIG=`pwd`/asm-kubeconfig
gcloud container clusters get-credentials ${GKE3} --zone ${GKE3_ZONE} --project ${SVC_2_PROJECT}
gcloud container clusters get-credentials ${GKE1} --zone ${GKE1_ZONE} --project ${SVC_1_PROJECT}
kubectl ctx ${GKE1}=gke_${SVC_1_PROJECT}_${GKE1_ZONE}_${GKE1}
kubectl ctx ${GKE3}=gke_${SVC_2_PROJECT}_${GKE3_ZONE}_${GKE3}
istioctl x create-remote-secret \
--context=${GKE1} \
--name=${GKE1} > secret-kubeconfig-${GKE1}.yaml
istioctl x create-remote-secret \
--context=${GKE3} \
--name=${GKE3} > secret-kubeconfig-${GKE3}.yaml
kubectl --context=${GKE1} -n istio-system apply -f secret-kubeconfig-${GKE3}.yaml
kubectl --context=${GKE3} -n istio-system apply -f secret-kubeconfig-${GKE1}.yaml
export ASM_LABEL=asm-1-10
for CTX in ${GKE1} ${GKE3}
do
  kubectl create --context=${CTX} namespace sample
  kubectl label --context=${CTX} namespace sample \
    istio.io/rev=${ASM_LABEL}
  kubectl create --context=${CTX} \
    -f samples/helloworld.yaml \
    -l app=helloworld -l service=helloworld -n sample
done
for CTX in ${GKE1} ${GKE3}
do
  kubectl create --context=${CTX} \
    -f samples/helloworld.yaml \
    -l app=helloworld -l version=v1 -n sample
done
for CTX in ${GKE1} ${GKE3}
do
  kubectl apply --context=${CTX} \
    -f samples/sleep.yaml -n sample
done
export GKE1_SLEEP_POD=$(kubectl get pod -n sample -l app=sleep --context=${GKE1} -o jsonpath='{.items[0].metadata.name}')
export GKE3_SLEEP_POD=$(kubectl get pod -n sample -l app=sleep --context=${GKE3} -o jsonpath='{.items[0].metadata.name}')
sleep 30
istioctl --context $GKE1 -n sample pc ep $GKE1_SLEEP_POD | grep helloworld
for i in {1..15}
  do kubectl exec -it -n sample -c sleep --context=${GKE1} $GKE1_SLEEP_POD -- curl helloworld.sample:5000/hello
done
