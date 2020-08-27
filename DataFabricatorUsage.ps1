# Demonstrates how to use the DataFabricator Module

# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.

# If the module is not in memory, then suppress the error and silently continue
Remove-Module DataFabricator -ErrorAction SilentlyContinue

Import-Module .\DataFabricator -Verbose

Clear-Host

Get-FabricatedName 
Get-FabricatedName -First
Get-FabricatedName -Last
Get-FabricatedName -FirstMiLast
Get-FabricatedName -FirstMiddleLast
Get-FabricatedName -LastFirst
Get-FabricatedName -LastFirstMi
Get-FabricatedName -LastFirstMiddle

Get-FabricatedAddressLine1
Get-FabricatedAddressLine2
Get-FabricatedAddressLine2 -Threshold 99

Get-FabricatedState
Get-FabricatedState -FullName

Get-FabricatedZipCode
Get-FabricatedZipCode -Plus4
Get-FabricatedZipCode -PlusFour

Get-FabricatedCity

Get-FabricatedCityStateZipCode
Get-FabricatedCityStateZipCode -Plus4
Get-FabricatedCityStateZipCode -PlusFour
Get-FabricatedCityStateZipCode -FullStateName
Get-FabricatedCityStateZipCode -FullStateName -Plus4


