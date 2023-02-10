#Criando a pasta usada de exemplo
New-Item -ItemType Directory -Path "C:\Pasta_Compartilhada\Estruturação"

#Criando a pasta para ser usada como repositório do relatório 
New-Item -ItemType Directory -Path "C:\ShareMon"
New-SmbShare -Path "C:\Pasta_Compartilhada\Estruturação" -Name "Estruturação" 

#Mapeando o Share como unidade de rede
New-PSDrive -Name "D" -Root "\\Server\Estruturação" -Persist -PSProvider FileSystem -Credential (Get-Credential -Credential Administrator)

#Monitoração - Salvar em um script separado 
cls
Write-Host "Iniciando Monitoração de Share" -ForegroundColor Yellow
$ArquivoAberto = Get-SmbOpenFile #| Where {$.Path -like "C:\Pasta_Compartilhada*"}
$Server = hostname 
foreach($Arquivo in $ArquivoAberto){
    cls
    $Local = ($Arquivo.Path).Remove(0,2)
    $IPRequisicao = ($Arquivo.ClientComputerName)
    $User = ($Arquivo.ClientUserName)
    $Perm = (((Get-Acl -Path $Arquivo.Path).Access).IdentityReference).Value
    $Data = Get-Date -Format "dd/MM/yyyy HH:mm" 
    Write-Host "Gravando..." -ForegroundColor Green
    $Server+";"+$Local+";"+$User+";"+$Perm+";"+$IPRequisicao+";"+$Data | Out-File -Append "C:\ShareMon\Monitoracao.csv"
}
Write-Host "Finalizando Monitoração de Share" -ForegroundColor Yellow

#Configuração e implementação do Schedule - Implementar num script separado ou no terminal.
$ExecutaScript = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\ShareMon\MonAccess.ps1"
$Recorrencia = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration (New-TimeSpan -Days 7) 
$Tarf = New-ScheduledTask -Action $ExecutaScript -Trigger $Recorrencia  -Description "Monitoração de arquivos abertos no servidor" 
Register-ScheduledTask -TaskName "Monitoracao-SMB" -Action $ExecutaScript -Trigger $Recorrencia 
Write-Host "A criação do Scheduled foi um sucesso!" -ForegroundColor Green

#Apaga a tarefa
Unregister-ScheduledTask -TaskName "Monitoracao-SMB"

#Pesquisa se a tarefa está schedulada
Get-ScheduledTask | Where {$_.TaskName -like "Monitoracao-SMB"}
