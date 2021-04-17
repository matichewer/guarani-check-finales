#!/bin/bash


solicitar_lu() {
	echo -n "Escriba su LU: "
	read USUARIO
}

solicitar_clave() {
	PROMPT="Introduzca su password: "
	while IFS= read -p "$PROMPT" -r -s -n 1 char; do
    	if [[ $char == $'\0' ]]; then
        	break
    	fi
    	PROMPT='*'
    	CLAVE+="$char"
	done
	echo
}

solicitar_materia() {
	echo -n "Escriba el codigo de la materia: "
	read ID_MATERIA
}



# Solicito la info
solicitar_lu
solicitar_clave
solicitar_materia


# Logueo y guardado de cookie
curl -s 'https://g3w.uns.edu.ar/guarani3w/acceso?auth=form' \
  --data-raw "usuario=${USUARIO}&password=${CLAVE}" \
  --compressed --cookie-jar /tmp/guarani > /dev/null 2>&1

COOKIE=$(tail -n 1 /tmp/guarani | awk '{print $7}') 



# Consulto las mesas de examen
curl -s 'https://g3w.uns.edu.ar/guarani3w/examen_inscripcion?co=1' \
  -H "Cookie: siu_sess_guarani3w_UNS=${COOKIE}; _ga=GA1.3.268626716.1615387490; _gid=GA1.3.985118667.1618352284" \
  --compressed | grep "${ID_MATERIA}" > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Si hay mesa de examen"
else
  echo "No hay mesa de examen"
fi
