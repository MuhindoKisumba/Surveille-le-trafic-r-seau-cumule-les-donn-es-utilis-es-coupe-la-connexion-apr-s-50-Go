# Limite en Go
$limitGB = 50
$limitBytes = $limitGB * 1GB

# Interface réseau (adapter si besoin)
$interface = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1

if (-not $interface) {
    Write-Host "Aucune interface active trouvée."
    exit
}

Write-Host "Surveillance de l'interface :" $interface.Name

# Compteur initial
$startStats = Get-NetAdapterStatistics -Name $interface.Name
$startBytes = $startStats.ReceivedBytes + $startStats.SentBytes

while ($true) {
    Start-Sleep -Seconds 5

    $stats = Get-NetAdapterStatistics -Name $interface.Name
    $currentBytes = $stats.ReceivedBytes + $stats.SentBytes

    $usedBytes = $currentBytes - $startBytes
    $usedGB = [math]::Round($usedBytes / 1GB, 2)

    Write-Host "Consommation :" $usedGB "GB"

    if ($usedBytes -ge $limitBytes) {
        Write-Host "Limite atteinte ($limitGB GB). Déconnexion..."

        # Désactiver l'interface réseau
        Disable-NetAdapter -Name $interface.Name -Confirm:$false

        break
    }
}