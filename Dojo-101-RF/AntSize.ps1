function Get-AntSize {
        <#
    .SYNOPSIS
        λ = c/f

    .DESCRIPTION
        Conversion Frequence -> Longeur d'antenne Quart d'onde

    .PARAMETER frequency
        Frequence en Hz

    .OUTPUTS
        Longueur d'ondes en metre et  taille de l'antenne quart d'onde en cm.

    .EXAMPLE
        $antennaSize = Get-AntennaSize -frequency 915000000 # pour une fréquence de 915 MHz
    #>

    param (
        [Parameter(Mandatory=$true)]
        [double]$frequency
    )

    $speedOfLight = 299792458 # célérité
    $wavelength = $speedOfLight / $frequency # calculer la longueur d'onde
    $antennaSize = ($wavelength / 4) * 100 # pour une antenne quart d'onde et en centimtre

    Write-Host("λ (m) : $wavelength") -ForegroundColor DarkGray
    Write-Host("Ant (cm) : $antennaSize") -ForegroundColor White

}