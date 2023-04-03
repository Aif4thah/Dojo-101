<# 

Chiffrement d'un message avant envoi:

utilisation:

$aes = Generer-cle
$iv = generer-iv                                      
$msgchiffre = Chiffrer-message -Message "test" -Key $aes -IVs $iv
$msgchiffre
Dechiffrer-message -EncryptedString $msgchiffre -Key $aes -IVs $iv

/!\ attention: contrairement à la clé les IV ne devrait pas être réutilisés.

#>



function Generer-cle {

    $AESKey = New-Object Byte[] 32
    [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey)
    return $AESKey

}


function Generer-IV {

    $IV = New-Object Byte[] 16
    [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($IV)
    return $IV

}


function Chiffrer-message
{
    param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string] $Message,

    [Parameter(Mandatory=$true, Position=1)]
    [System.Byte[]] $Key,
  
    [Parameter(Mandatory=$true, Position=2)]
    [Byte[]] $IVs

    )

$AES = New-Object System.Security.Cryptography.AesCryptoServiceProvider
$AES.Key = $Key
$AES.IV = $IVs
$AES.Mode = "CBC"
$Encryptor = $AES.CreateEncryptor()
$EncryptedBytes = $Encryptor.TransformFinalBlock([Text.Encoding]::UTF8.GetBytes($Message), 0, $Message.Length)
return [BitConverter]::ToString($EncryptedBytes) -replace '-', ''

}


## déchiffrement

function Dechiffrer-message
{
    param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string] $EncryptedString,

    [Parameter(Mandatory=$true, Position=1)]
    [System.Byte[]] $Key,

    [Parameter(Mandatory=$true, Position=2)]
    [Byte[]] $IVs

    )

$EncryptedBytes = [byte[]]::new($EncryptedString.Length / 2)
for ($i = 0; $i -lt $EncryptedBytes.Length; $i++) {
    $EncryptedBytes[$i] = [Convert]::ToByte($EncryptedString.Substring($i * 2, 2), 16)
}
$AES = New-Object System.Security.Cryptography.AesCryptoServiceProvider
$AES.Key = $Key
$AES.Mode = "CBC"
$AES.IV = $IVs
$Decryptor = $AES.CreateDecryptor()
$DecryptedBytes = $Decryptor.TransformFinalBlock($EncryptedBytes, 0, $EncryptedBytes.Length)
return [Text.Encoding]::UTF8.GetString($DecryptedBytes)

}