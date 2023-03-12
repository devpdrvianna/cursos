#Teste com Hash Table
Clear-Host
$servidores = [ordered] @{server1="127.0.0.1";server2="127.0.0.2";server3="127.0.0.3"}


	
#Adicionar
$servidores["server4"]="127.0.0.4"

#Remover
$servidores.remove("server1")
	
Test-connection $servidores.server3 -Count 2
Write-Host ""
	
#Exibir Valores
Write-host $servidores.Keys $servidores.Values

Write-Host " "

$servidores
