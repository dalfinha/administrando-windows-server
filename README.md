# 💡 Usando o PowerShell para Administrar Servidores Windows

Administrar servidores Windows pode ser uma tarefa desafiadora, especialmente quando se lida com um grande número de servidores. Uma maneira de padronizar e economizar tempo ao realizar ajustes é usar scripts com o PowerShell. 

Nesta coleção, você encontrará alguns scripts que desenvolvi para otimizar o trabalho daqueles que administram esses ambientes (incluindo eu!)

## A Magia do PowerShell ⭐

### configurando-active-directory-fsrm.ps1

Este script realiza as seguintes ações:

- Instala a função FS-Resource-Manager.
- Instala a função AD-Domain-Services.
- Configura uma nova floresta no Active Directory.
- Reinicia o server.
- Cria Unidades Organizacionais (OUs) protegidas contra exclusão acidental.
- Cria grupos no Active Directory.
- Cria usuários no Active Directory com senhas definidas.
- Adiciona os usuários aos grupos apropriados no Active Directory.
- Cria uma estrutura de diretórios no sistema de arquivos.


🚨 É importante mencionar que ele **REINICIA** a máquina assim que cria a floresta no Active Directory, visto que é necessária essa ação para implementar a forest.

### monitorando-shares-schedule-smb.ps1

Este script automatiza a monitoração de compartilhamentos de arquivos em um servidor Windows. Ele realiza as seguintes etapas:

- Cria a estrutura de diretórios necessária.
- Monitora os arquivos abertos.
- Implementa um agendamento para execução periódica.
- Permite a remoção da tarefa agendada, se necessário.