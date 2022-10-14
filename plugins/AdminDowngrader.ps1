clear-host

$elevated = ([Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)





function downgradestart {
    $user = "Enter Username to Downgrade"
    $group = "Enter ADmin group name to downgrade in your Lang: (Spanish: Administradores, English: Administrators)"
    Write-Warning "Ready to downgrade $user from $group"
    $continue = read-host "Type (downgrade) to continue"
    if ($continue -eq "downgrade") {
        Write-host "Downgrading..."
        net localgroup $group $user /delete
        if ($?) {
            Write-Host "Downgraded $user from $group"
        }
        else {
            Write-warning "Failed to downgrade $user from $group"
        }
    }
    else {
        Write-Warning "Downgrade Cancelled"
    }
}








$host.ui.rawui.WindowTitle = "Admin Downgrader"
if ($elevated) {
    Write-Host "You are an administrator" -ForegroundColor Green
    downgradestart
    $null = read-host "Enter any key to exit"
    exit
}
else {
    Write-Host "You are not an administrator" -ForegroundColor Yellow
    write-host "Execute as administrator" -ForegroundColor Yellow
}