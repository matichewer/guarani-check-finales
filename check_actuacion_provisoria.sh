#!/bin/bash

# Cargo datos de login
source .env

# ID de Arqui
ID_MATERIA=5561

# Me logueo en Guarani
source login_cookie.sh
login_cookie

curl -s 'https://g3w.uns.edu.ar/guarani3w/actuacion_provisoria_examen' \
    -H "Cookie: siu_sess_guarani3w_UNS=${COOKIE}; _ga=GA1.3.268626716.1615387490; _gid=GA1.3.985118667.1618352284" \
| grep "Sin resultado"

if [ $? -eq 0 ]; then
    MSG="HAY NOTA DE ARQUI"
    echo "${MSG}"
    telegram "${MSG}" > /dev/null
else
    MSG="Nota Arqui: Sin resultado"
    echo "${MSG}"
    telegram "${MSG}" > /dev/null
fi