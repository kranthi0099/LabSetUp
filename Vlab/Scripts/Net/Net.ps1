param(
[string]$templateFile,
[string]$getUsername,
[string]$getPassword
)

$username=$getUsername
$password=$getPassword |ConvertTo-SecureString -AsPlainText -Force                                                       #Admin credentials for remote machine

$cred = new-object -typename System.Management.Automation.PSCredential -ArgumentList $username , $password              #Creating a credential object with username & password


$colComputer = Get-Content C:\Vlab\MachineList\Machineslist.txt                                                        #Get list of machines

$templatePath = Get-Content C:\Vlab\Templates\$templateFile

$controller = Get-Content C:\Vlab\MachineList\Controller.txt                                                                 #Template selection
 
Foreach ($strComputer in $colComputer) {

    Invoke-Command -ComputerName $strComputer -Credential $cred -ScriptBlock {& cmd.exe /c "Z:\Net\VS2010\Setup\setup.exe /q /norestart /unattendfile Z:\Net\VS2010\Setup\unattend.ini"}      #Install VS2010 without SQL server using the *.ini file
}