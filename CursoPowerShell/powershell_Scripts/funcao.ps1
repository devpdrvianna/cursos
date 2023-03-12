#Exemplo Função Soma
function soma
{
  param ($a , $b)   
#  (Chama o script com os 2 parametros)
  $resultado = $a + $b
  Write-Host $a e $b
  Write-Host "A resposta é $resultado"
}
function teste
{Param ($a,$b)
$re = $a + $b
Write-host Funcionou $re}
