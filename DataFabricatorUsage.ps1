# Demonstrates how to use the DataFabricator Module

# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.

# If the module is not in memory, then suppress the error and silently continue
Remove-Module DataFabricator -ErrorAction SilentlyContinue

Import-Module .\DataFabricator -Verbose

Clear-Host

# Names
Get-FabricatedName 
Get-FabricatedName -First
Get-FabricatedName -Last
Get-FabricatedName -FirstMiLast
Get-FabricatedName -FirstMiddleLast
Get-FabricatedName -LastFirst
Get-FabricatedName -LastFirstMi
Get-FabricatedName -LastFirstMiddle

# Address
Get-FabricatedAddressLine1
Get-FabricatedAddressLine2
Get-FabricatedAddressLine2 -Threshold 99

# City State and Zip Codes
Get-FabricatedCity

Get-FabricatedState
Get-FabricatedState -FullName

Get-FabricatedZipCode
Get-FabricatedZipCode -Plus4
Get-FabricatedZipCode -PlusFour

Get-FabricatedCityStateZipCode
Get-FabricatedCityStateZipCode -Plus4
Get-FabricatedCityStateZipCode -PlusFour
Get-FabricatedCityStateZipCode -FullStateName
Get-FabricatedCityStateZipCode -FullStateName -Plus4

# Dates
Get-FabricatedDate
Get-FabricatedDate -FromYear 1930
Get-FabricatedDate -FromYear 1940 -ThruYear 1990
Get-FabricatedDate -RelativeFromYear 1000
Get-FabricatedDate -AsDateTime
Get-FabricatedDate -FormatMDY
Get-FabricatedDate -FormatDMY

# Company
Get-FabricatedCompany
