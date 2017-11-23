set-executionpolicy bypass -force
Enable-PSRemoting -force
set-item  wsman:\localhost\client\trustedhosts -value * -force
restart-service winrm
Enable-WSManCredSSP -Role Server
