Start-PodeServer {
    Add-PodeEndpoint -Address * -Port 80 -Protocol Http
    Set-PodeViewEngine -Type PSHTML -Extension PS1 -ScriptBlock {
        param($path, $data)
        return (. $path $data)
    }
    Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
        Write-PodeViewResponse -Path "index.ps1"
    }
}