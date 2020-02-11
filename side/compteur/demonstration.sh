#!/bin/bash

# SCRIPT DE DEMONSTRATION GKE

echo "SELECTIONNEZ LE CHIFFRE CORRESPONDANT A VOTRE DEMONSTRATION"
select i in CANARY ROLLING BLUE-GREEN; do
        if [ "$i" = "CANARY" ]; then
                echo "Bonjour Canary"
		cd Canary
		kubectl apply -f ./service-frontend.yml
                break
        elif [ "$i" = "ROLLING" ]; then
                echo "Bonjour Rolling"
                break
	elif [ "$i" = "BLUE-GREEN" ]; then
                echo "Bonjour Blue-Green"
                break
        else
                echo "mauvaise reponse"
		break
        fi
done
