#!/bin/bash

#################################################################################################
#												#
#  Faz a leitura do EPM no Sudoers.d  e disponibiliza para executar em um form Zenity		#
#												#
#################################################################################################

IFS=$(echo -en "\n\b")

cont=0

#####TELA INICIAL
#clear;/bin/zenity --forms --text="Escolha abaixo para INSTALAR / ATUALIZAR / EXECUTAR UM SERVIÇO" --extra-button="ATUALIZAR" --cancel-label="INSTALAR" --ok-label="EXECUTAR SERVIÇO" --title="Central de Software" --modal --width=400 --height=100; echo $?



for com in $(grep "^%itau" ./epm | cut -d":" -f2- | grep '/bin/yum\|/sbin/\|systemctl' | cut -c2-)
	do
	 let cont++
	# if [$(echo $com | cut -c1) == ""]; then com=$(echo $com | cut -c2-); fi
	 #echo "Item$cont - $com"

	#lista="$lista  Item$cont  \"sudo $com\""
	lista="$lista $(echo $com | cut -d"#" -f2 | cut -c2-) \"sudo $(echo $com|cut -d"#" -f1)\""


 	done	
        clear	
	comand="/bin/zenity --list --title=\"CENTRAL DE SOFTWARE\" --column=\"SOFTWARE\" --column=\"COMANDO\" $lista --width=800 --height=400 --ok-label=EXECUTE --cancel-label=SAIR --text=\"Selecione e Execute\" --print-column=2"

# Parametros para utilizar mais de uma opção. Basta adicionar ao final do comando Zenity --checklist --separator=";"
clear
ex=$(eval $comand)
eval $ex
#echo $ex
