class InventoryRecord
{
  [string] $ProductCode
  [string] $Warehouse
  [string] $Bin
  [int] $Quantity
}

function New-FabricatedInventoryRecord()
{
  [CmdletBinding()]
  param (
        )

  $retVal = [InventoryRecord]::new()

  $retVal.ProductCode = $(Get-FabricatedProduct).ProductCode
  $retVal.Warehouse = Get-FabricatedCity
  
  $retVal.Quantity = 1..999 | Get-Random
  

}