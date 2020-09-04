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
