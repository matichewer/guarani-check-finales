#!/bin/bash

cd "$(dirname "$0")" || exit

LOG_FILE="log-file.log"
timestamp=$(date +"%Y-%m-%d, %H:%M:%S")

# Cargo datos de login
source .env

# Me logueo en Guarani
source login_cookie.sh
login_cookie "${LU}" "${PASSWORD}"

curl -s 'https://g3w.uns.edu.ar/guarani3w/actuacion_provisoria_examen' \
    -H "Cookie: siu_sess_guarani3w_UNS=${COOKIE}; _ga=GA1.3.268626716.1615387490; _gid=GA1.3.985118667.1618352284" \
| grep "Sin resultado"

if [ $? -eq 0 ]; then
    MSG="${timestamp},HAY NOTA DE ARQUI"
    telegram "${MSG}" >> "${LOG_FILE}"
else
    MSG="${timestamp},Nota Arqui: Sin resultado"
fi

echo "${MSG}"
echo "${MSG}" >> "${LOG_FILE}"
