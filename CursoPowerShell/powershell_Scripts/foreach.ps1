#Exemplo FOREACH
Clear-Host
foreach ($numeros in 1,2,3,4,5,6,7,8) {echo $numeros}
foreach ($arquivos in Get-ChildItem) {
 if ($arquivos.IsReadOnly) {
	Write-Host $arquivos.FullName
 }
}

