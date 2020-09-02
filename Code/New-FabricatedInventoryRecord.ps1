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

  $retVal = @()

  for($i = 0; $i -lt $RecordCount; $i++)
  {
    $prod = [InventoryRecord]::new()
  
    $prod.ProductCode = $(Get-FabricatedProduct).ProductCode

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