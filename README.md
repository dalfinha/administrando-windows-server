# Observações e Dicas
> Alguns scripts em PowerShell que criei para administração dedicada no Windows Server.
## Schedule + SMB 
###### Ambiente utilizado: Windows Server 2019 Base - Padrão AWS - Disco de 30gb. <br>

Observações:<br>
*Não foi necessário instalar nenhum módulo no servidor. <br>
*Não é necessário usar as linhas 1-9 caso você utilize o script em uma arquitetura já configurada. <br>
*É importante que o bloco 10-26 seja criado em outro script, para que ao agendar a task ele não crie outras tarefas com o mesmo nome (com certeza dará erro).<br>
*Utilize a linha 36 para excluir o schedule e a 39 para consultar se o mesmo continua ativo. <br>
*Você pode acompanhar ou testar a task diretamente no Administrative Tools usando o Task Schedule. <br>
*Quando a task é executada ela chama o terminal do PowerShell, isso significa que não foi configurada para rodar em segundo plano.<br>
