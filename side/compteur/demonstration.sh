#!/bin/bash

# SCRIPT DE DEMONSTRATION GKE

j=0

echo "RESET DE L'ENVIRONNEMENT DE DEMO"
kubectl delete deployments site-rouge
kubectl delete deployments site-bleu
kubectl delete service front
sleep 1
echo "ENVIRONNEMENT NEUTRE"

echo "##########  SELECTIONNEZ LE CHIFFRE CORRESPONDANT A VOTRE DEMONSTRATION  ##########"
select i in CANARY-AUTO CANARY ROLLING-AUTO ROLLING BLUE-GREEN-AUTO BLUE-GREEN; do
        if [ "$i" = "CANARY-AUTO" ]; then
                echo "### Deployment Canary automatique selectionné ###"
		sleep 1
		cd ./Canary
		kubectl apply -f ./service-frontend.yml
                echo "Création du service ..."
		sleep 90
		echo "Création terminée !"
		sleep 1
		SERVICE_IP=$(kubectl get service/front --output=json | jq -r '.status.loadBalancer.ingress[0].ip')
		echo "l'adresse IP du service est : "
		echo $SERVICE_IP
		sleep 1
		echo "Création du deployment site-bleu ..."
		kubectl apply -f ./demo-deployment-bleu.yml
		echo "Création terminée !"
		sleep 1
		echo "Création du deployment site-rouge ..."
		kubectl apply -f ./demo-deployment-rouge.yml
		echo "Création terminée !"
		sleep 1
		echo "services : "
		kubectl get services
		sleep 1
		echo "deployments : "
		kubectl get deployments
		while [ $j -le 19 ]
		do
        		curl http://$SERVICE_IP
                	sleep 1
			((j++))
		done
		echo "Suppression des deployments ..."
		kubectl delete deployments site-rouge
		kubectl delete deployments site-bleu
		sleep 1
		echo "Deployments supprimés !"
		echo "Suppression du service ..."
		kubectl delete service front
		sleep 1
		echo "Service supprimé !"
		sleep 1
		echo "Fin de la démonstration Canary !"
		cd ..
		break
	elif [ "$i" = "CANARY" ]; then
                echo "### Deployment Canary selectionné ###"
                sleep 1
                cd ./Canary
                kubectl apply -f ./service-frontend.yml
                echo "Création du service ..."
                sleep 90
                echo "Création terminée !"
                sleep 1
                SERVICE_IP=$(kubectl get service/front --output=json | jq -r '.status.loadBalancer.ingress[0].ip')
                echo "l'adresse IP du service est : "
                echo $SERVICE_IP
                sleep 1
                echo "Création du deployment site-bleu ..."
                kubectl apply -f ./demo-deployment-bleu.yml
                echo "Création terminée !"
                sleep 1
                echo "Création du deployment site-rouge ..."
                kubectl apply -f ./demo-deployment-rouge.yml
                echo "Création terminée !"
                sleep 1
                echo "services : "
                kubectl get services
                sleep 1
		break
        elif [ "$i" = "ROLLING-AUTO" ]; then
		echo "### Deployment Rolling automatique selectionné ###"
                sleep 1
                cd ./Rolling
                kubectl apply -f ./service-frontend.yml
                echo "Création du service ..."
                sleep 90
                echo "Création terminée !"
                sleep 1
                SERVICE_IP=$(kubectl get service/front --output=json | jq -r '.status.loadBalancer.ingress[0].ip')
                echo "l'adresse IP du service est : "
                echo $SERVICE_IP
                sleep 1
                echo "Création du deployment site-bleu ..."
                kubectl apply -f ./demo-deployment-bleu.yml
                echo "Création terminée !"
                sleep 1
                echo "services : "
                kubectl get services
                sleep 1
		echo "Replicaset avant Rolling Update : "
		kubectl get replicaset
		sleep 1
		curl http://$SERVICE_IP
                sleep 1
		kubectl edit deployment site-bleu
		sleep 10
		echo "Replicaset après Rolling Update : "
		kubectl get replicaset
		sleep 10
		curl http://$SERVICE_IP
		sleep 1
		echo "Roll Back du notre Rolling Update ..."
		kubectl rollout undo deployment/site-bleu
		sleep 10
		echo "Replicaset après Roll Back de notre Rolling Update : "
                kubectl get replicaset
                sleep 10
		curl http://$SERVICE_IP
                sleep 1
		echo "Suppression des deployments ..."
                kubectl delete deployments site-bleu
                sleep 1
                echo "Deployments supprimés !"
                sleep 1
		echo "Suppression du service ..."
                kubectl delete service front
                sleep 1
                echo "Service supprimé !"
                sleep 1
                echo "Fin de la démonstration Rolling automatique !"
                cd ..
                break
	elif [ "$i" = "ROLLING" ]; then
                echo "### Deployment Rolling automatique selectionné ###"
                sleep 1
                cd ./Rolling
                kubectl apply -f ./service-frontend.yml
                echo "Création du service ..."
                sleep 90
                echo "Création terminée !"
                sleep 1
                SERVICE_IP=$(kubectl get service/front --output=json | jq -r '.status.loadBalancer.ingress[0].ip')
                echo "l'adresse IP du service est : "
                echo $SERVICE_IP
                sleep 1
                echo "Création du deployment site-bleu ..."
                kubectl apply -f ./demo-deployment-bleu.yml
                echo "Création terminée !"
                sleep 1
                echo "services : "
                kubectl get services
                sleep 1
                echo "Replicaset avant Rolling Update : "
                kubectl get replicaset
                sleep 1
		break
	elif [ "$i" = "BLUE-GREEN-AUTO" ]; then
                echo "### Deployment Blue-Green automatique selectionné ###"
                sleep 1
                cd ./Blue-Green
		kubectl apply -f ./service-bleu.yml
                echo "Création du service ..."
                sleep 90
                echo "Création terminée !"
                sleep 1
                SERVICE_IP=$(kubectl get service/front --output=json | jq -r '.status.loadBalancer.ingress[0].ip')
                echo "l'adresse IP du service est : "
                echo $SERVICE_IP
                sleep 1
                echo "Création du deployment site-bleu ..."
                kubectl apply -f ./demo-deployment-bleu.yml
		sleep 1
		echo "Création du deployment site-rouge ..."
                kubectl apply -f ./demo-deployment-rouge.yml
                sleep 1
		echo "services : "
                kubectl get services
		sleep 1
		echo "Deployments : "
		kubectl get deployments
                sleep 10
                curl http://$SERVICE_IP
		sleep 10
		echo "application du service v2"
		kubectl apply -f ./service-rouge.yml
		sleep 10
		echo "services : "
		sleep 1
		kubectl get service
		curl http://$SERVICE_IP
                sleep 1
		echo "Suppression des deployments ..."
                kubectl delete deployments site-bleu
                kubectl delete deployments site-rouge
		sleep 1
                echo "Deployments supprimés !"
                sleep 1
                echo "Suppression du service ..."
                kubectl delete service front
                sleep 1
                echo "Service supprimé !"
                sleep 1
                echo "Fin de la démonstration Blue-Green automatique !"
                cd ..  

		break
	elif [ "$i" = "BLUE-GREEN" ]; then
                echo "### Deployment Blue-Green selectionné ###"
                sleep 1
                cd ./Blue-Green
                kubectl apply -f ./service-bleu.yml
                echo "Création du service ..."
                sleep 90
                echo "Création terminée !"
                sleep 1
                SERVICE_IP=$(kubectl get service/front --output=json | jq -r '.status.loadBalancer.ingress[0].ip')
                echo "l'adresse IP du service est : "
                echo $SERVICE_IP
                sleep 1
                echo "Création du deployment site-bleu ..."
                kubectl apply -f ./demo-deployment-bleu.yml
                sleep 1
                echo "Création du deployment site-rouge ..."
                kubectl apply -f ./demo-deployment-rouge.yml
                sleep 1
                echo "services : "
                kubectl get services
                sleep 1
                echo "Deployments : "
                kubectl get deployments
                sleep 10
		curl http://$SERVICE_IP
                sleep 10
                break
        else
                echo "VOTRE REPONSE EST INCORRECTE, VEUILLEZ RELANCER LE PROGRAMME"
		break
        fi
done
