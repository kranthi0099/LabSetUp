Set-ExecutionPolicy bypass -Force
Enable-PSRemoting -Force
Set-Item  WSMan:\localhost\Client\TrustedHosts -Value * -Force
Restart-Service winrm
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force