$registryPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727",
                "HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319",`
                "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727",`
                "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"

$name1 = "SystemDefaultTlsVersions"

$name2 = "SchUseStrongCrypto"

$propertyType = "DWORD"

$value = "00000001"

foreach ($path in $registryPath)
{
    IF((Test-Path $path))
    {
	    New-ItemProperty -Path $path -Name $name1 -Value $value `
                             -PropertyType $propertyType -Force | Out-Null
        
	    New-ItemProperty -Path $path -Name $name2 -Value $value `
                             -PropertyType $propertyType -Force | Out-Null
        
	    Write-Host Value of Property $name1 for Registry Key $path
	    Get-ItemPropertyValue -Path $path -Name $name1
        
	    Write-Host Value of Property $name2 for Registry Key $path
	    Get-ItemPropertyValue -Path $path -Name $name2
    }
    ELSE {
        Write-Host "Path $path doesn't exists"
    }
}