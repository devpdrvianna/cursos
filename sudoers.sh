#/bin/bash
#comando=$(zenity --hide-column 2 --print-column 2 --list --column "APP" --column "Comando" "APP1" "ls -la" "APP2" "df -h" "APP3" "comando3" --title="SUDOERS" --width=500 --ok-label=EXECUTAR --cancel-label=CANCELAR --text="Selecione e Execute")
clear
comando=$(zenity --hide-column 2 --print-column 2 --list --column "APP" --column "Comando" "Code" "yum install code" "Volumes" "df -h" "Memory" "free -h" --title="SUDOERS" --width=500 --ok-label=INSTALL --extra-button=UPDATE --cancel-label=SAIR --text="Selecione e Execute")
echo A Saida do Zenity : $?
echo Comando: $comando
echo -e "*********************************************"
echo "o comando é: $(grep "#" lista.txt | cut -d"#" -f1)"
echo "o item é: $(grep "#" lista.txt | cut -d"#" -f2)"
echo Comando antes do IF: $comando
if [ "$comando" = "UPDATE" ]; then comando=`echo $comando | sed s/UPDATE/yum\ update\ code/g`; fi
echo comando depois do if: $comando
#$comando
