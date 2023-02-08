Install-WindowsFeature FS-Resource-Manager -IncludeManagementTools
#Install-Module FileServerResourceManagement -IncludeManagementTools
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName "fsrm.ihf.com" -DomainMode Default -ForestMode Default -DomainNetbiosName "FSRM" -DatabasePath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -LogPath "C:\Windows\NTDS"

Sleep (10)
Restart-Computer -Force 

#Criando as OUs
New-ADOrganizationalUnit "VENDAS" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit "ADM" -ProtectedFromAccidentalDeletion $true

#Criando os Grupos
New-ADGroup -Name "G_VENDAS_AUDITORIA" -GroupScope Global -Path "ou=VENDAS,dc=FSRM,dc=ihf,dc=com" 
New-ADGroup -Name "G_VENDAS_VAZIO"-GroupCategory Distribution -GroupScope Global -Path "ou=VENDAS,dc=FSRM,dc=ihf, dc=com" 
New-ADGroup -Name "G_ADM_ANTIGO"  -GroupCategory Distribution -GroupScope Global -Path "ou=ADM,dc=FSRM,dc=ihf, dc=com" 
New-ADGroup -Name "G_ADM_NOVO" -GroupCategory Distribution -GroupScope Global -Path "ou=ADM,dc=FSRM,dc=ihf, dc=com" 

#Criando os Usuários
$PSW = Read-Host "Senha" -AsSecureString
New-ADUser -Name "Mariana Goncalves" -SamAccountName margonc -AccountPassword $PSW -ChangePasswordAtLogon $true -EmailAddress "mariana.goncalves@fsrm.com.br" -Path "ou=VENDAS,dc=FSRM,dc=ihf,dc=com" 
New-ADUser -Name "Caio Felipe" -SamAccountName caifelp -AccountPassword $PSW -ChangePasswordAtLogon $true -EmailAddress "caio.felipe@fsrm.com.br" -Path "ou=VENDAS,dc=FSRM,dc=ihf,dc=com" 
New-ADUser -Name "Inner Wave - Guest" -SamAccountName innergue -AccountPassword $PSW -ChangePasswordAtLogon $true -Path "ou=ADM,dc=FSRM,dc=ihf,dc=com" 
New-ADUser -Name "Daniel Francisco" -SamAccountName danfran -AccountPassword $PSW -ChangePasswordAtLogon $true -EmailAddress "danfran@fsrm.com.br" -Path "ou=ADM,dc=FSRM,dc=ihf,dc=com" 
New-ADUser -Name "Larry Casanova" -SamAccountName casanova -AccountPassword $PSW -ChangePasswordAtLogon $true -EmailAddress "casasnovass@fsrm.com.br" -Path "ou=ADM,dc=FSRM,dc=ihf,dc=com" 

#Colocando os Usuários nos devidos grupos
Add-ADGroupMember -Identity "G_VENDAS_AUDITORIA" -Members margonc, caifelp
Add-ADGroupMember -Identity "G_ADM_ANTIGO" -Members innergue
Add-ADGroupMember -Identity "G_ADM_NOVO" -Members casanova, danfran

#Criando a pasta para usar no lab
New-Item -Path "c:\" -Name "PASTA_FSRM" -ItemType "directory"
New-Item -Path "c:\PASTA_FSRM" -Name "ADM" -ItemType "directory"
New-Item -Path "c:\PASTA_FSRM" -Name "VENDAS" -ItemType "directory"
New-Item -Path "C:\PASTA_FSRM\VENDAS" -Name "AUTOMACAO" -ItemType "directory"
New-Item -Path "c:\PASTA_FSRM" -Name "BRASIL_CORRESPONDENCIA" -ItemType "directory"
New-Item -Path "C:\PASTA_FSRM\ADM" -Name "PINK" -ItemType "directory"