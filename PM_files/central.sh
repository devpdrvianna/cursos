#!/bin/bash



install_p ()
{
#####Install um programa

IFS=$(echo -en "\n\b")
cont=0

#clear;/bin/zenity --forms --text="Escolha abaixo para INSTALAR / ATUALIZAR / EXECUTAR UM SERVIÇO" --extra-button="ATUALIZAR" --cancel-label="INSTALAR" --ok-label="EXECUTAR SERVIÇO" --title="Central de Software" --modal --width=400 --height=100; echo $?

for com in $(grep "^%itau" ./epm | cut -d":" -f2- | grep '/bin/yum\ install' | cut -c2-)
	do
		let cont++
		lista="$lista $(echo $com | cut -d" " -f2,3 | sed 's/ /_/g') \"sudo $(echo $com -y)\""
		#lista="$lista $(echo $com | cut -d"#" -f2 | cut -c2-) \"sudo $(echo $com|cut -d"#" -f1)\""
 	done	
        clear	
	comando="yad --list --center --title=\"Instalar um software\" --column=\"SOFTWARE\" --column=\"COMANDO\" $lista --width=800 --height=400 --button="INSTALAR!gtk-ok":0 --button="VOLTAR!window-close":1 --text=\"Selecione e Execute\" --print-column=2"
clear
#echo ********comando: $comando
ex=$(eval $comando | tr -d "|")
#echo ********ex: $ex
if [ "$ex" != "" ]; then eval $ex | yad --list --center --title "Install Results" --text "installing files.." --column "Log" --button=sair:0 --buttons-layout=center --width=800 --height=400 --timeout=60;fi
#eval $ex
}
export -f install_p

update_p ()
{
#####Update de um programa

IFS=$(echo -en "\n\b")
cont=0

for com in $(grep "^%itau" ./epm | cut -d":" -f2- | grep '/bin/yum\ update' | cut -c2-)
        do
                let cont++
		lista="$lista $(echo $com | cut -d" " -f2,3 | sed 's/ /_/g') \"sudo $(echo $com -y)\""
                #lista="$lista $(echo $com | cut -d"#" -f2 | cut -c2-) \"sudo $(echo $com|cut -d"#" -f1)\""
        done
        clear
        comando="yad --list --center --title=\"Update de um software\" --column=\"SOFTWARE\" --column=\"COMANDO\" $lista --width=800 --height=400 --button="UPDATE!gtk-ok":0 --button="VOLTAR!window-close":1 --text=\"Selecione e Execute\" --print-column=2"
clear
#echo ********comando: $comando
ex=$(eval $comando | tr -d "|")
#echo ********ex: $ex
if [ "$ex" != "" ]; then eval $ex | yad --list --center --title "Update Results" --text "Updating files.." --column "Log" --button=sair:0 --buttons-layout=center --width=800 --height=400 --timeout=60;fi
}
export -f update_p


comando_p ()
{
#####Executar um programa

IFS=$(echo -en "\n\b")
cont=0

for com in $(grep "^%itau" ./epm | cut -d":" -f2- | grep '/sbin/\|systemctl' | cut -c2-)
        do
                let cont++
		lista="$lista $(echo Comando-$cont) \"sudo $(echo $com|cut -d"#" -f1)\""
                #lista="$lista $(echo $com | cut -d"#" -f2 | cut -c2-) \"sudo $(echo $com|cut -d"#" -f1)\""
        done
        clear
        comando="yad --list --center --title=\"Executar um comando\" --column=\"SOFTWARE\" --column=\"COMANDO\" $lista --width=800 --height=400 --button="EXECUTAR!gtk-ok":0 --button="VOLTAR!window-close":1 --text=\"Selecione e Execute\" --print-column=2"
clear
ex=$(eval $comando | tr -d "|")
if [ "$ex" != "" ]; then eval $ex | yad --list --center --title "Run Results" --text "Running files.." --column "Log" --button=sair:0 --buttons-layout=center --width=800 --height=400 --timeout=60;fi
}
export -f comando_p



sair ()
{
kill -15 $YAD_PID
}
export -f sair


yad --form --center --borders=10 --window-icon="./icon.ico" --title="$(date '+%D') - Central de Software" --columns=3 --no-buttons --buttons-layout=center --image-on-top \
--image=./itau.png \
--field="<b>Install</b>!gtk-ok!Instalar Software":fbtn "bash -c install_p" \
--field="<b>Update</b>!view-refresh!Atualizar Software":fbtn "bash -c update_p" \
--field="<b>Comando</b>!gtk-preferences!Executar um comando":fbtn "bash -c comando_p" \
--field="<b>Sair</b>!window-close!Sair":fbtn  'bash -c sair'
#--field="  System Upgrade!terminal":fbtn "ls -la" \
#--field="  rc.xml!text-editor":fbtn "leafpad $HOME/.config/openbox/rc.xml" \
#______________________________________
clear
#Here is the code for the script that the "System Upgrade" button is calling for...

##!/usr/bin/env bash
#pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY xterm -e "apt-get update&&apt-get dist-upgrade"
#install_p
