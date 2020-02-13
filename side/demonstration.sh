#!/bin/bash

# SCRIPT DE DEMONSTRATION GKE

echo "SELECTIONNEZ LE CHIFFRE CORRESPONDANT A VOTRE DEMONSTRATION"
select i in CANARY ROLLING BLUE-GREEN; do
        if [ "$i" = "CANARY" ]; then
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
		echo "deployments : "
		kubectl get deployments
		curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
		sleep 1
		curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
                sleep 1
                curl http://$SERVICE_IP
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
        elif [ "$i" = "ROLLING" ]; then
                echo "Bonjour Rolling"
                break
	elif [ "$i" = "BLUE-GREEN" ]; then
                echo "Bonjour Blue-Green"
                break
        else
                echo "VOTRE REPONSE EST INCORRECTE, VEUILLEZ RELANCER LE PROGRAMME"
		break
        fi
done
