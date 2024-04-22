#!/bin/bash


# $1: usuario
# $2: clave
login_cookie(){
    curl -s 'https://g3w.uns.edu.ar/guarani3w/acceso?auth=form'         \
    --data-raw "usuario=${1}&password=${2}"                   \
    --compressed                                                        \
    --cookie-jar /tmp/guarani > /dev/null 2>&1

    COOKIE=$(tail -n 1 /tmp/guarani | awk '{print $7}') 
}
