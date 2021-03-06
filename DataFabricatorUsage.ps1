<#-------------------------------------------------------------------------------------------------
  Data Fabricator - DataFabricatorUsage.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script simply demonstrates how to use the DataFabricator Module. It's a bunch of test
  commands I used during development. I've left it here in case you want to explore
  DataFabricator.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Note, this PowerShell script is designed to run individual lines of code for testing.
# Highlighting individual line(s) and pressing F8 to run just those lines.

# Old habits die hard, and sometimes you hit F5 by accident. The line below will exit the
# script, should you hit F5.
if ( 1-eq 1 ) { exit }

#------------------------------------------------------------------------------------------------
# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.
#------------------------------------------------------------------------------------------------

# If the module is not in memory, then suppress the error and silently continue
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module ./DataFabricator -Verbose

Clear-Host

#------------------------------------------------------------------------------------------------
# Helper Functions
#------------------------------------------------------------------------------------------------
Show-AboutDataFabricator
Show-DataFabricatorFunctions
Open-DataFabricatorWebsite

#------------------------------------------------------------------------------------------------
# Country Codes
#------------------------------------------------------------------------------------------------
Get-CountryCodes

# Should return true
Test-CountryCode -CountryCode 'UK'

# Should produce an error message and return false
Test-CountryCode -CountryCode 'XX'

#------------------------------------------------------------------------------------------------
# Address
#------------------------------------------------------------------------------------------------
Get-FabricatedAddressLine1
Get-FabricatedAddressLine1 -Verbose

Get-FabricatedAddressLine2
Get-FabricatedAddressLine2 -Threshold 100

Get-FabricatedAddressLine2 -Verbose
Get-FabricatedAddressLine2 -Threshold 99 -Verbose

#------------------------------------------------------------------------------------------------
# City State and Zip Codes
#------------------------------------------------------------------------------------------------
ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP"
ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP" -Verbose

ConvertTo-CityCode -City "Aaronsburg CDP"
ConvertTo-CityCode -City "Aaronsburg CDP" -Verbose

Get-FabricatedCity
Get-FabricatedCity -Verbose

Get-FabricatedCity -CountryCode US
Get-FabricatedCity -CountryCode US -Verbose

Get-FabricatedCity -CountryCode UK
Get-FabricatedCity -CountryCode UK -Verbose

Get-FabricatedCity -CountryCode 'Garbage'
Get-FabricatedCity -CountryCode 'Garbage' -Verbose


Get-FabricatedState
Get-FabricatedState -FullName

Get-FabricatedState -Verbose
Get-FabricatedState -FullName -Verbose

Get-FabricatedState -CountryCode UK
Get-FabricatedState -CountryCode UK -FullName

Get-FabricatedPostalCode
Get-FabricatedPostalCode -Plus4
Get-FabricatedPostalCode -PlusFour

Get-FabricatedPostalCode -Verbose

Get-FabricatedPostalCode -CountryCode UK
Get-FabricatedPostalCode -CountryCode UK -Plus4
Get-FabricatedPostalCode -CountryCode UK -PlusFour

Get-FabricatedPostalCode -CountryCode UK -Verbose
Get-FabricatedPostalCode -CountryCode UK -Plus4 -Verbose

New-FabricatedCityStatePostalCodeRecord
New-FabricatedCityStatePostalCodeRecord -Plus4
New-FabricatedCityStatePostalCodeRecord -PlusFour
New-FabricatedCityStatePostalCodeRecord -RecordCount 5
New-FabricatedCityStatePostalCodeRecord -RecordCount 5 -Plus4
New-FabricatedCityStatePostalCodeRecord -RecordCount 5 -PlusFour

New-FabricatedCityStatePostalCodeRecord -Verbose
New-FabricatedCityStatePostalCodeRecord -Plus4 -Verbose
New-FabricatedCityStatePostalCodeRecord -PlusFour -Verbose

New-FabricatedCityStatePostalCodeRecord -CountryCode UK
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -Plus4
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -PlusFour
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -RecordCount 5
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -RecordCount 5 -Plus4
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -RecordCount 5 -PlusFour

New-FabricatedCityStatePostalCodeRecord -CountryCode UK -Verbose
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -Plus4 -Verbose
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -PlusFour -Verbose

$csz = New-FabricatedCityStatePostalCodeRecord -RecordCount 5 -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStatePostalCodeRecord -RecordCount 50 -Plus4 -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStatePostalCodeRecord -RecordCount 50 -Plus4 -MaxDuplicateCountBeforeError 5 -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStatePostalCodeRecord -RecordCount 5 -CountryCode UK -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStatePostalCodeRecord -RecordCount 50 -Plus4 -CountryCode UK -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStatePostalCodeRecord -RecordCount 50 -Plus4 -MaxDuplicateCountBeforeError 5 -CountryCode UK -Verbose
$csz | Format-Table

#------------------------------------------------------------------------------------------------
# Company
#------------------------------------------------------------------------------------------------
Get-FabricatedCompany
Get-FabricatedCompany -Verbose

#------------------------------------------------------------------------------------------------
# Dates
#------------------------------------------------------------------------------------------------
Get-FabricatedDate
Get-FabricatedDate -FromYear 1930
Get-FabricatedDate -FromYear 1000 -ThruYear 1200
Get-FabricatedDate -RelativeFromYear 1000
Get-FabricatedDate -RelativeThruYear 21

Get-FabricatedDate -AsDateTime
Get-FabricatedDate -AsDateTime -FabricateTime
Get-FabricatedDate -FormatMDY
Get-FabricatedDate -FormatDMY

Get-FabricatedDate -FabricateTime

Get-FabricatedTime
Get-FabricatedTime -AMPM
Get-FabricatedTime -Verbose

Get-FabricatedDate -Verbose
Get-FabricatedDate -FromYear 1930 -Verbose
Get-FabricatedDate -FromYear 1940 -ThruYear 1990 -Verbose
Get-FabricatedDate -RelativeFromYear 1000 -Verbose

#------------------------------------------------------------------------------------------------
# Job Title
#------------------------------------------------------------------------------------------------
Get-FabricatedJobTitle

Get-FabricatedJobTitle -Verbose

#------------------------------------------------------------------------------------------------
# Names, Phones, and IDs
#------------------------------------------------------------------------------------------------
Get-FabricatedName
Get-FabricatedName -First
Get-FabricatedName -Last
Get-FabricatedName -FirstMiLast
Get-FabricatedName -FirstMiddleLast
Get-FabricatedName -LastFirst
Get-FabricatedName -LastFirstMi
Get-FabricatedName -LastFirstMiddle

Get-FabricatedName -Verbose

Get-FabricatedPhone
Get-FabricatedPhone -NoFormatting
Get-FabricatedPhone -Verbose
Get-FabricatedPhone -PhonePrefix '555'

Get-FabricatedPhone -CountryCode UK
Get-FabricatedPhone -CountryCode UK -NoFormatting
Get-FabricatedPhone -CountryCode UK -Verbose

Get-FabricatedTaxpayerID
Get-FabricatedTaxpayerID -NoFormatting
Get-FabricatedTaxpayerID -Verbose

Get-FabricatedTaxpayerID -CountryCode UK
Get-FabricatedTaxpayerID -CountryCode UK -NoFormatting
Get-FabricatedTaxpayerID -CountryCode UK -Verbose


#------------------------------------------------------------------------------------------------
# Name Records
#------------------------------------------------------------------------------------------------
$n = New-FabricatedNameRecord
$n

$n = New-FabricatedNameRecord -Verbose
$n

$n = New-FabricatedNameRecord -RecordCount 10
$n | Format-Table

$n = New-FabricatedNameRecord -RecordCount 10 -Verbose
$n | Format-Table


#------------------------------------------------------------------------------------------------
# Bins
#------------------------------------------------------------------------------------------------
Get-FabricatedBin

Get-FabricatedBin -Verbose

#------------------------------------------------------------------------------------------------
# Customers
#------------------------------------------------------------------------------------------------
$cust = New-FabricatedCustomerRecord
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -EMailDomain 'pluralsight.com'
$cust

$cust = New-FabricatedCustomerRecord -RecordCount 5
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -RecordCount 5 -EMailDomain 'pluralsight.com'
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -Verbose
$cust

$cust = New-FabricatedCustomerRecord -EMailDomain 'pluralsight.com' -Verbose
$cust

$cust = New-FabricatedCustomerRecord -RecordCount 50 -Verbose
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -RecordCount 5 -EMailDomain 'pluralsight.com' -Verbose
$cust
$cust | Format-Table



$cust = New-FabricatedCustomerRecord -CountryCode UK
$cust

$cust = New-FabricatedCustomerRecord -CountryCode UK -EMailDomain 'pluralsight.co'
$cust

$cust = New-FabricatedCustomerRecord -CountryCode UK -RecordCount 5
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -CountryCode UK -RecordCount 5 -EMailDomain 'pluralsight.co'
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -CountryCode UK -Verbose
$cust

$cust = New-FabricatedCustomerRecord -CountryCode UK -EMailDomain 'pluralsight.co' -Verbose
$cust

$cust = New-FabricatedCustomerRecord -CountryCode UK -RecordCount 50 -Verbose
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -CountryCode UK -RecordCount 5 -EMailDomain 'pluralsight.com' -Verbose
$cust
$cust | Format-Table

#------------------------------------------------------------------------------------------------
# Employee
#------------------------------------------------------------------------------------------------
$emp = New-FabricatedEmployeeRecord
$emp

$emp = New-FabricatedEmployeeRecord -EMailDomain 'pluralsight.com'
$emp

$emp = New-FabricatedEmployeeRecord -RecordCount 5
$emp
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -RecordCount 5 -EMailDomain 'pluralsight.com'
$emp
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -Verbose
$emp

$emp = New-FabricatedEmployeeRecord -EMailDomain 'pluralsight.com' -Verbose
$emp

$emp = New-FabricatedEmployeeRecord -RecordCount 5 -Verbose
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -RecordCount 5 -EMailDomain 'pluralsight.com' -Verbose
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -CountryCode UK
$emp

$emp = New-FabricatedEmployeeRecord -CountryCode UK -EMailDomain 'pluralsight.co'
$emp

$emp = New-FabricatedEmployeeRecord -CountryCode UK -RecordCount 5
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -CountryCode UK -RecordCount 5 -EMailDomain 'pluralsight.co'
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -CountryCode UK -Verbose
$emp

$emp = New-FabricatedEmployeeRecord -CountryCode UK -EMailDomain 'pluralsight.co' -Verbose
$emp

$emp = New-FabricatedEmployeeRecord -CountryCode UK -RecordCount 5 -Verbose
$emp | Format-Table

$emp = New-FabricatedEmployeeRecord -CountryCode UK -RecordCount 5 -EMailDomain 'pluralsight.co' -Verbose
$emp | Format-Table

#------------------------------------------------------------------------------------------------
# Company
#------------------------------------------------------------------------------------------------
Get-FabricatedCompany

$company = New-FabricatedCompanyRecord
$company

$company = New-FabricatedCompanyRecord -Verbose
$company

$company = New-FabricatedCompanyRecord -RecordCount 5
$company | Format-Table

$company = New-FabricatedCompanyRecord -RecordCount 5 -Verbose
$company | Format-Table

$company = New-FabricatedCompanyRecord -CountryCode UK
$company

$company = New-FabricatedCompanyRecord -CountryCode UK -Verbose
$company

$company = New-FabricatedCompanyRecord -CountryCode UK -RecordCount 5
$company | Format-Table

$company = New-FabricatedCompanyRecord -CountryCode UK -RecordCount 5 -Verbose
$company | Format-Table

#------------------------------------------------------------------------------------------------
# Product
#------------------------------------------------------------------------------------------------
ConvertFrom-ProductCode -ProductCode "GLOOCELAR"
ConvertFrom-ProductCode -ProductCode "GLOOCELAR" -Verbose

ConvertTo-ProductCode -Clothing 'Gloves' -Color 'Ocean Green' -Size 'Large'



$product = New-FabricatedProductRecord
$product

$product = New-FabricatedProductRecord -RecordCount 5
$product

$product = New-FabricatedProductRecord -RecordCount 5 -Verbose
$product

# Intentionally cause a max dupe error
$product = New-FabricatedProductRecord -RecordCount 1000 -MaxDuplicateCountBeforeError 1000 -Verbose
$product

# Return a list of all products
$productTable = New-FabricatedProductTable
$productTable

$productTable = New-FabricatedProductTable -Verbose
$productTable

#------------------------------------------------------------------------------------------------
# Inventory
#------------------------------------------------------------------------------------------------
$inv = New-FabricatedInventoryRecord
$inv

$inv = New-FabricatedInventoryRecord -RecordCount 5
$inv
$inv | Format-Table

# Use the same warehouse code for everything
$csz = New-FabricatedCityStatePostalCodeRecord
$WarehouseCode = $csz.CityCode
$WarehouseCode

$inv = New-FabricatedInventoryRecord -WarehouseCode $WarehouseCode
$inv

$inv = New-FabricatedInventoryRecord -RecordCount 5 -WarehouseCode $WarehouseCode -Verbose
$inv | Format-Table

$inv = New-FabricatedInventoryRecord -RecordCount 5 -WarehouseCode $WarehouseCode -MinQuantity 5000 -MaxQuantity 9999
$inv | Format-Table

$inv = New-FabricatedInventoryRecord -RecordCount 5 -WarehouseCode $WarehouseCode -MinQuantity 5000 -MaxQuantity 9999 -Verbose
$inv | Format-Table

#------------------------------------------------------------------------------------------------
# Sales
#------------------------------------------------------------------------------------------------
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator -Verbose

# Get some employees
$employees = New-FabricatedEmployeeRecord -RecordCount 50 -Verbose
$productTable = New-FabricatedProductTable -Verbose
$customers = New-FabricatedCustomerRecord -RecordCount 50 -Verbose

$sales = New-FabricatedSalesRecord -Employees $employees `
                                   -Products $productTable `
                                   -Customers $customers `
                                   -Verbose
$sales | Format-Table


$sales = New-FabricatedSalesRecord -RecordCount 50 `
                                   -Employees $employees `
                                   -Products $productTable `
                                   -Customers $customers `
                                   -Verbose
$sales | Format-Table

$s = New-FabricatedSalesRecord -RecordCount 50 `
                               -Employees $employees `
                               -Products $productTable `
                               -Customers $customers `
                               -MinQuantityPerSale 5 `
                               -MaxQuantityPerSale 10 `
                               -MinPricePerProduct 10 `
                               -MaxPricePerProduct 20 `
                               -YearsTofabricateSalesFor 5 `
                               -Verbose
$s | Format-Table


$company = New-FabricatedCompanyRecord -RecordCount 50

#------------------------------------------------------------------------------------------------
# This section is some simple examples of how to export the fabricated data into files.
# I've setup a folder, SampleOutput, as a place to store the data, and included some
# Remove-Item commands to empty the folder when you are done.
#
# Please note the sample files are not included on the GitHub site, since they are easy enough
# to regenerate.
#------------------------------------------------------------------------------------------------

$Path = ".\SampleOutput"
$employees    | Export-Csv "$Path\Employee.csv"
$productTable | Export-Csv "$Path\Products.csv"
$customers    | Export-Csv "$Path\Customers.csv"
$sales        | Export-Csv "$Path\Sales.csv"
$company      | Export-Csv "$Path\Company.csv"

$employees    | ConvertTo-Json | Out-File "$Path\Employees.json"
$productTable | ConvertTo-Json | Out-File "$Path\Products.json"
$customers    | ConvertTo-Json | Out-File "$Path\Customers.json"
$sales        | ConvertTo-Json | Out-File "$Path\Sales.json"
$company      | ConvertTo-Json | Out-File "$Path\Company.json"

Remove-Item "$Path\*.json"
Remove-Item "$Path\*.csv"
