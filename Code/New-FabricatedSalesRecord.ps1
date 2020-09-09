<#
.SYNOPSIS
Fabricates sales data based on the supplied mix of employees, products, customers, and employees.

.DESCRIPTION
Like our company, yours is probably embarrassed to admit how little they actually sell. To avoid this, you'll want to fabricate some fake sales data.

Sales data answers the questions of what piece of cheap merchandise was sold (products), 
which employee actually surprised their manager by selling something (employees),
who was foolish or gullible enough to buy our stuff (customers),
and how many did this poor person get stuck with (quantity),
not to mention how much money did we make which is important to know because we've got another boat payment coming due (total sale).

This exciting cmdlet takes the output from other cmdlets and combines them together to fabricate sales data.

.PARAMETER RecordCount
The number of records you want returned from this cmdlet. The default is 1.

.PARAMETER Employees
An array of employee objects as output from the New-FabricatedEmployeeRecord cmdlet.

.PARAMETER Products
An array of product objects as output from either the New-FabricatedProductRecord cmdlet or the New-FabricatedProductTable cmdlet.

.PARAMETER Customers
An array of customer objects as output from the New-FabricatedCustomerRecord cmdlet.

.PARAMETER MinQuantityPerSale
The minimum number of items to sell in a single transaction. The default is 1.

.PARAMETER MaxQuantityPerSale
The maximum number of items that can be sold for a single transaction. The defalt is 99.

.PARAMETER MinPricePerProduct
The minimum price for a single piece of product. The default is 1.00. 
Note prices are not in any monetary unit, so you can pretend they are dollars, pounds, euros, Martian gliptars, or whatever you fancy.

.PARAMETER MaxPricePerProduct
The maximum price for a single piece of product. The default is 99.99. 
Note prices are not in any monetary unit, so you can pretend they are dollars, pounds, euros, Minecraft emeralds, or whatever you think you can cram into your wallet.

.PARAMETER YearsToFabricateSalesFor
How many years to fabricate data for, starting with the current year and going back in time.
The default is 1.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
This cmdlet outputs an array of objects, each with the following properties:

SalesDate       | The date and time of the sale (in datetime format)
ProductCode     | A unique identifier for this product
EmployeeID      | A unique identifier for this employee
CustomerID      | A unique identifier for this customer
Quantity        | The number of items sold
PricePerProduct | The price per product
TotalSale       | Quantity * PricePerProduct (we did the math so you don't have to!)

.EXAMPLE
$employees = New-FabricatedEmployeeRecord -RecordCount 10
$products = New-FabricatedProductRecord -RecordCount 100
$customers = New-FabricatedCustomerRecord -RecordCount 20
$sales = New-FabricatedSalesRecord -Employees $employees -Products $products -Customers $customers
$sales

New-FabricatedSalesRecord returns data similar to the following example:

SalesDate       | 8/17/2019 12:00:00 AM
ProductCode     | SHIMAUEXT
EmployeeID      | CH5970
CustomerID      | SH0286
Quantity        | 37
PricePerProduct | 5.47
TotalSale       | 202.39

.EXAMPLE
$employees = New-FabricatedEmployeeRecord -RecordCount 10
$products = New-FabricatedProductRecord -RecordCount 100
$customers = New-FabricatedCustomerRecord -RecordCount 20
# Note the line continuation character at the end
$sales = New-FabricatedSalesRecord -Employees $employees `
                                   -Products $products `
                                   -Customers $customers `
                                   -RecordCount 5
$sales

New-FabricatedSalesRecord returns 5 rows of data similar to the data in the previous example

.EXAMPLE
$employees = New-FabricatedEmployeeRecord -RecordCount 10
$products = New-FabricatedProductRecord -RecordCount 100
$customers = New-FabricatedCustomerRecord -RecordCount 20
# Note the line continuation character at the end
$sales = New-FabricatedSalesRecord -Employees $employees `
                                   -Products $products `
                                   -Customers $customers `
                                   -MinQuantityPerSale 100 `
                                   -MaxQuantityPerSale 1000 `
                                   -MinPricePerProduct 100.00 `
                                   -MaxPricePerProduct 200.00 
$sales

New-FabricatedSalesRecord returns data similar to the following example:

SalesDate       | 9/3/2019 12:00:00 AM
ProductCode     | MENGRE4XL
EmployeeID      | BL3621
CustomerID      | CH5970
Quantity        | 534
PricePerProduct | 116.93
TotalSale       | 62440.62

.NOTES
Data Fabricator - New-FabricatedSalesRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function New-FabricatedSalesRecord()
{
  [CmdletBinding()]
  param (
             [int] $RecordCount = 1
        ,  [array] $Employees
        ,  [array] $Products
        ,  [array] $Customers
        ,    [int] $MinQuantityPerSale = 1
        ,    [int] $MaxQuantityPerSale = 99
        , [single] $MinPricePerProduct = 1.00
        , [single] $MaxPricePerProduct = 99.99
        ,    [int] $YearsToFabricateSalesFor = 1
        )

 # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count..........................: $RecordCount
         Number of Employee Records Passed In..: $($Employees.Count)
         Number of Product Records Passed In...: $($Products.Count)
         Number of Customer Records Passed In..: $($Customers.Count)
         Min Quantity Per Sale.................: $MinQuantityPerSale
         Max Quantity Per Sale.................: $MaxQuantityPerSale
         Min Price Per Product.................: $MinPricePerProduct
         Max Price Per Product.................: $MaxPricePerProduct
         Years To Fabricate Sales For..........: $YearsToFabricateSalesFor 
"@

  # Note: We are not doing dupe checking in this function, as it's realistic to have
  # a duplicate sale on the same day.

  # Define the output object for this cmdlet
  class SalesRecord
  {
    [datetime] $SalesDate
      [string] $ProductCode
      [string] $EmployeeID
      [string] $CustomerID
         [int] $Quantity
      [single] $PricePerProduct
      [single] $TotalSale
  }

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount) 
  {
    $sales = [SalesRecord]::new()

    $sales.EmployeeID = ($Employees | Get-Random).EmployeeID
    $sales.ProductCode = ($Products | Get-Random).ProductCode
    $sales.CustomerID = ($Employees | Get-Random).EmployeeID

    $sales.Quantity = $MinQuantityPerSale..$MaxQuantityPerSale | Get-Random
    $cents = (0..99 | Get-Random) / 100.00
    $sales.PricePerProduct = ($MinPricePerProduct..$MaxPricePerProduct | Get-Random) + $cents
    $sales.TotalSale = $sales.Quantity * $sales.PricePerProduct

    $sales.SalesDate = Get-FabricatedDate -RelativeFromYear $YearsToFabricateSalesFor -AsDateTime -Verbose:$false

    Write-Verbose "$fn Fabricating $($sales.EmployeeID) $($sales.ProductCode) $($sales.CustomerID) $($sales.Quantity) $($sales.PricePerProduct) $($sales.TotalSale) $($sales.SalesDate)"

    $retVal += $sales
    $i++
  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Sort the output before returning
  $retVal = $retVal | Sort-Object -Property SalesDate, ProductCode, EmployeeID

  # Return our results
  return $retVal

}
