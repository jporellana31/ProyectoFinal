Start-PodeServer  {
    Add-PodeEndpoint -Address * -Port 3000 -Protocol Http
    Add-PodeRoute -Method Get -Path '/food-menu' -ScriptBlock {
        Write-PodeJsonResponse -Value $( & .\routes\food-menu.ps1)
    }
}