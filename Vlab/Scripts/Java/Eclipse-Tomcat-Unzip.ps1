function unzipping
{
    [CmdletBinding()]

    param(
    [string]$path,
    [string]$destination
    )

    $shell_app = New-Object -com shell.application
    $files = Get-ChildItem -Path $path -Filter *.zip -Recurse

    foreach($file in $files)
    {
        $zip_file = $shell_app.namespace($file.FullName)

        $copyHere = $shell_app.namespace($destination)

        $copyHere.Copyhere($zip_file.items())
    }
}

unzipping "C:\Training\apache-tomcat-8.0.26-windows-x64.zip" "C:\Training\"
unzipping "C:\Training\eclipse-jee-galileo-SR2-win32.zip" "C:\Training\"
