class InventoryRecord
{
  [string] $ProductCode
  [string] $WarehouseCode
  [string] $Bin
  [int] $Quantity
}

function New-FabricatedInventoryRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [string] $WarehouseCode = 'x'
        , [int] $MinQuantity = 1
        , [int] $MaxQuantity = 999  
        )


  # Note, due to the way the range function in PowerShell works, we
  # don't have to worry if the Min Quantity is greater than the Max.
  # 1..999 and 999..1 both work the same for our purposes
  
  # Generate the records
  $retVal = @()

  for($i = 0; $i -lt $RecordCount; $i++)
  {
    $prod = [InventoryRecord]::new()
  
    $prod.ProductCode = $(New-FabricatedProductRecord).ProductCode

    # If they passed a warehouse use it, otherwise generate one
    if ($WarehouseCode -ne 'x')
    {
      $prod.WarehouseCode = $WarehouseCode
    }
    else
    {
      $state = Get-FabricatedState
      $cityCode = ConvertTo-CityCode -City $(Get-FabricatedCity)
  
      $prod.WarehouseCode = "$state$cityCode"
    }
    
    $prod.Bin = Get-FabricatedBin
  
    $prod.Quantity = $MinQuantity..$MaxQuantity | Get-Random

    $retVal += $prod
  }

  return $retVal 

}