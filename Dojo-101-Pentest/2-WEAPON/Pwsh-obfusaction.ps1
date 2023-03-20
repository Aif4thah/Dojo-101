function Invoke-Shellingan{
    <#
    .SYNOPSIS
        Simple Recursive Powershell Command Obfuscation

    .DESCRIPTION
        Simple Recursive Powershell Command Obfuscation along the uCShiwa reverseShell

    .PARAMETER cmd
        command (mandatory)

    .PARAMETER iex
        add invoke-expression (usefull to execute your commands)

    .PARAMETER recurse
        number of obfuscation loop (increase output length!)

    .OUTPUTS
        Then you just have to copy-paste the output where you want execute it.

    .EXAMPLE
        Invoke-Shellingan -cmd 'write helloworld' -iex $true -recurse 1

    .NOTES
        TO DO: Pipe, sleep time

    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string] $cmd,

        [Parameter(Mandatory=$false, Position=1)]
        [System.Boolean] $iex = $true,

        [Parameter(Mandatory=$false, Position=2)]
        [int] $recurse
    
    )begin{

        if(-not $rot){
            Write-Verbose "<cmd> : $cmd" 
            Write-Verbose "<iex> : $iex" 
            Write-Verbose "<rec> : $recurse"
        }

        function rul($in){
            Write-Verbose "<0> Randomnize Case..."
            $array = $in.Toupper(),$in.ToLower()
            for($i=0; $i -lt $in.length; $i++){
                $output += ($array[(get-random -min 0 -max 2)][$i]).ToString()
            }
            return $output
        }


    }Process{

        Write-Verbose "<0> Bytes Rotation..."
        [byte[]] $scriptBytes = [system.Text.Encoding]::UTF8.GetBytes((rul($cmd)))
        $rot = Get-Random -Maximum 254 -Minimum 5
        $derot = 255 - $rot
        $rotedbytes = [system.Text.Encoding]::UTF8.GetBytes('')
        $scriptBytes |%{ $rotedbytes += ($_ + $rot)%255}

        Write-Verbose "<0> Back to [string]..."
        $output = ""
        $rotedbytes |%{$output += $_.tostring() + ","}
        $output = $output -replace ".$"

        Write-Verbose "<0> Payload Generation..."
        $rand1 = Get-Random -Maximum 254 -Minimum 5 ; $rand2 = Get-Random -Maximum 254 -Minimum 5 ; $rand3 = Get-Random -Maximum 254 -Minimum 5
        $output =  "`$$rand2=255;`$$rand1=[sYsTeM.TeXT.eNcOdInG];`$$rand3=`$$rand1::utF8.gEtbYtES('');`$$rand1::utf8.gEtsTRiNG(`$(([bYtE]" + $output + ")|%{`$$rand3+=(`$_+(`$$rand2+$derot))%`$$rand2};`$$rand3))"
    
    }end{   

        if($iex){$output+= "|iex"}
        if($recurse -gt 1){Invoke-Shellingan $output $iex ($recurse-=1)  }
        else{
            return rul($output)
        }
    }
}