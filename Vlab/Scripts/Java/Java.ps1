param(
[string]$templateFile,
[string]$getUsername,
[string]$getPassword
)

$username=$getUsername
$password=$getPassword |ConvertTo-SecureString -AsPlainText -Force

$cred = new-object -typename System.Management.Automation.PSCredential -ArgumentList $username , $password


$colComputer = Get-Content C:\Vlab\MachineList\Machineslist.txt

$templateData = Get-Content C:\Vlab\Templates\$templateFile

$SharedFolderComputer = Get-Content C:\Vlab\MachineList\SharedFolderComputer.txt

Foreach ($strComputer in $colComputer) {
 
 #If the target directory doesn't exist, create it
 If (!(Test-Path \\$strComputer\c$\Training\)) {
 mkdir \\$strComputer\c$\Training\
 }

 [xml]$softwares = $templateData 
 
 foreach($location in $softwares.Softwares.Software.File)
    {
        #Copy-Item $location "\\$strComputer\c$\Training\"
    }

    Invoke-Command -ComputerName $strComputer -Credential $cred -Authentication Credssp -ScriptBlock{param($sharedpath) & cmd.exe /C "net use Z: \\$sharedpath\Softwares"} -ArgumentList $SharedFolderComputer
   $output = Invoke-Command -ComputerName $strComputer -Credential $cred -Authentication Credssp -ScriptBlock{ & cmd.exe /C "Z:\Java\jdk-8u60-windows-x64.exe"}
    if($output.ExitCode -eq 0)
    {
        Write-Host "JDK has been installed successfully on $strComputer"
    }
    else
    {
        Write-Host "JDK has not installed on $strComputer"
    }
    
    Invoke-Command -ComputerName $strComputer -Credential $cred -Authentication Credssp -ScriptBlock{ & cmd.exe /C "net use Z: /delete /Y"}

    #Invoke-Command -ComputerName $strComputer -Credential $cred -FilePath C:\Vlab\Scripts\Java\Eclipse-Tomcat-Unzip.ps1

    #Invoke-Command -ComputerName $strComputer -Credential $cred -ScriptBlock { [Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_60\", "Machine") 
     #[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";C:\Program Files\Java\jdk1.8.0_60\bin\", "Machine")}
}