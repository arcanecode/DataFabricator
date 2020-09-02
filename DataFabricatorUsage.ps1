# Demonstrates how to use the DataFabricator Module

# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.

# If the module is not in memory, then suppress the error and silently continue
Remove-Module DataFabricator -ErrorAction SilentlyContinue

Import-Module .\DataFabricator -Verbose

Clear-Host

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
New-FabricatedCityStateZipCodeRecord
New-FabricatedCityStateZipCodeRecord -Plus4
New-FabricatedCityStateZipCodeRecord -PlusFour
New-FabricatedCityStateZipCodeRecord -RecordCount 5
New-FabricatedCityStateZipCodeRecord -RecordCount 5 -Plus4
New-FabricatedCityStateZipCodeRecord -RecordCount 5 -PlusFour

# Company
Get-FabricatedCompany

# Dates
Get-FabricatedDate
Get-FabricatedDate -FromYear 1930
Get-FabricatedDate -FromYear 1940 -ThruYear 1990
Get-FabricatedDate -RelativeFromYear 1000
Get-FabricatedDate -AsDateTime
Get-FabricatedDate -FormatMDY
Get-FabricatedDate -FormatDMY

Get-FabricatedTime
Get-FabricatedTime -AMPM

# Job Title
Get-FabricatedJobTitle

# Names
Get-FabricatedName 
Get-FabricatedName -First
Get-FabricatedName -Last
Get-FabricatedName -FirstMiLast
Get-FabricatedName -FirstMiddleLast
Get-FabricatedName -LastFirst
Get-FabricatedName -LastFirstMi
Get-FabricatedName -LastFirstMiddle

Get-FabricatedPhone
Get-FabricatedPhone -NoDashes

Get-FabricatedSSN
Get-FabricatedSSN -NoDashes

# Products
Get-FabricatedProduct
Get-FabricatedBin


# Records
# Customers
$cust = New-FabricatedCustomerRecord
$cust

$cust = New-FabricatedCustomerRecord -EMailDomain 'pluralsight.com'
$cust

$cust = New-FabricatedCustomerRecord -RecordCount 5
$cust
$cust | Format-Table

$cust = New-FabricatedCustomerRecord -RecordCount 5 -EMailDomain 'pluralsight.com'
$cust
$cust | Format-Table

# Employee
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


# Company
$company = New-FabricatedCompanyRecord
$company

$company = New-FabricatedCompanyRecord -RecordCount 5
$company
$company | Format-Table

# Product
$product = New-FabricatedProductRecord
$product

$product = New-FabricatedProductRecord -RecordCount 5
$product

$productTable = New-FabricatedProductTable
$productTable

# Inventory
$inv = New-FabricatedInventoryRecord
$inv

$inv = New-FabricatedInventoryRecord -RecordCount 5
$inv
$inv | Format-Table

# Use the same warehouse code for everything
$csz = New-FabricatedCityStateZipCodeRecord
$WarehouseCode = $csz.CityCode
$WarehouseCode

$inv = New-FabricatedInventoryRecord -WarehouseCode $WarehouseCode
$inv

$inv = New-FabricatedInventoryRecord -RecordCount 5 -WarehouseCode $WarehouseCode
$inv
$inv | Format-Table

$inv = New-FabricatedInventoryRecord -RecordCount 5 -WarehouseCode $WarehouseCode -MinQuantity 5000 -MaxQuantity 9999
$inv
$inv | Format-Table



# To DO
# Date Table
# Sales Table - Pass in:
#   Inventory
#   Customer
#   Employee
# Randomly pick the keys from each plus a quantity to create a sales table
