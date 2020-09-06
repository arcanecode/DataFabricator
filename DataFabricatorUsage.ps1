# Demonstrates how to use the DataFabricator Module

# First, remove the module from memory if it's loaded. This is needed
# if you are making changes and want to test those changes.

# If the module is not in memory, then suppress the error and silently continue
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator -Verbose

Clear-Host

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

Get-FabricatedState
Get-FabricatedState -FullName

Get-FabricatedState -Verbose
Get-FabricatedState -FullName -Verbose

Get-FabricatedZipCode
Get-FabricatedZipCode -Plus4
Get-FabricatedZipCode -PlusFour

Get-FabricatedZipCode -Verbose


New-FabricatedCityStateZipCodeRecord
New-FabricatedCityStateZipCodeRecord -Plus4
New-FabricatedCityStateZipCodeRecord -PlusFour
New-FabricatedCityStateZipCodeRecord -RecordCount 5
New-FabricatedCityStateZipCodeRecord -RecordCount 5 -Plus4
New-FabricatedCityStateZipCodeRecord -RecordCount 5 -PlusFour

New-FabricatedCityStateZipCodeRecord -Verbose
New-FabricatedCityStateZipCodeRecord -Plus4 -Verbose
New-FabricatedCityStateZipCodeRecord -PlusFour -Verbose

New-FabricatedCityStateZipCodeRecord -Verbose

Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator -Verbose
$csz = New-FabricatedCityStateZipCodeRecord -RecordCount 5 -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStateZipCodeRecord -RecordCount 50 -Plus4 -Verbose
$csz | Format-Table

$csz = New-FabricatedCityStateZipCodeRecord -RecordCount 50 -Plus4 -MaxDuplicateCountBeforeError 5 -Verbose
$csz | Format-Table


$csz = New-FabricatedCityStateZipCodeRecord -RecordCount 250 -Verbose
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
# Names
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
Get-FabricatedPhone -NoDashes
Get-FabricatedPhone -Verbose

Get-FabricatedSSN
Get-FabricatedSSN -NoDashes
Get-FabricatedSSN -Verbose

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

$cust = New-FabricatedCustomerRecord -EMailDomain 'pluralsight.com'
$cust

$cust = New-FabricatedCustomerRecord -RecordCount 5
$cust
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

#------------------------------------------------------------------------------------------------
# Company
#------------------------------------------------------------------------------------------------
Get-FabricatedCompany

$company = New-FabricatedCompanyRecord
$company

$company = New-FabricatedCompanyRecord -RecordCount 5
$company
$company | Format-Table

$company = New-FabricatedCompanyRecord -RecordCount 5 -Verbose
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
$csz = New-FabricatedCityStateZipCodeRecord
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


# To DO

$company = New-FabricatedCompanyRecord -RecordCount 50


# Some examples of how to export the fabricated data to files
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


# Date Table


# Write Help / Verbose
#   x ConvertFrom-CityStateCode
#   x ConvertFrom-ProductCode
#   x ConvertTo-CityCode
#   x ConvertTo-ProductCode
#  
#   x Get-FabricatedAddressLine1
#   x Get-FabricatedAddressLine2
#   x Get-FabricatedBin 
#   x Get-FabricatedCity
#   x Get-FabricatedCompany 
#   x Get-FabricatedDate
#   x Get-FabricatedJobTitle
#   Get-FabricatedName
#   Get-FabricatedPhone
#   Get-FabricatedSSN
#   Get-FabricatedState
#   Get-FabricatedTime
#   Get-FabricatedZipCode
#  
#   New-FabricatedCityStateZipCodeRecord
#   New-FabricatedCompanyRecord
#   New-FabricatedCustomerRecord
#   New-FabricatedEmployeeRecord
#   New-FabricatedInventoryRecord
#   New-FabricatedProductRecord
#   New-FabricatedProductTable   

# Install/Test PlatyPs
# Eventually Pester Tests

# Maybe: remove the Key from Product table

# Output CSV
# Output JSON   $x | ConvertTo-Json | Out-File $path

# Load-TableProducts Not sure this is still needed?
