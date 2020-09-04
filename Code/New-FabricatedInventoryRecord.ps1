class InventoryRecord
{
  [string] $ProductCode
  [string] $WarehouseCode
  [string] $Bin
  [string] $WarehouseBinCode
  [int] $Quantity
}

function New-FabricatedInventoryRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [string] $WarehouseCode = 'x'
        , [int] $MinQuantity = 1
        , [int] $MaxQuantity = 999  
        )


  # Note, due to the way the range function in PowerShell works, we
  # don't have to worry if the Min Quantity is greater than the Max.
  # 1..999 and 999..1 both work the same for our purposes
  
  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  if ($WarehouseCode -eq 'x')
    { $wc = 'Fabricate Warehouse Codes'}
  else 
    { $wc = $WarehouseCode }

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count: $RecordCount
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
         Min Quantity: $MinQuantity
         Max Quantity: $MaxQuantity
         Warehouse Code: $wc
"@

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount) 
  {
    $prod = [InventoryRecord]::new()
  
    # Generate a product code, but suppress any verbose messages from it
    $prod.ProductCode = $(New-FabricatedProductRecord -Verbose:$false).ProductCode

    # If they passed a warehouse use it, otherwise generate one
    if ($WarehouseCode -ne 'x')
    {
      $prod.WarehouseCode = $WarehouseCode
    }
    else
    {
      $state = Get-FabricatedState -Verbose:$false
      $cityCode = ConvertTo-CityCode -City $(Get-FabricatedCity -Verbose:$false)
  
      $prod.WarehouseCode = "$state$cityCode"
    }
    
    $prod.Bin = Get-FabricatedBin -Verbose:$false
  
    $prod.Quantity = $MinQuantity..$MaxQuantity | Get-Random

    $prod.WarehouseBinCode = "$($prod.WarehouseCode)$($prod.Bin)"
    $item = "$($prod.WarehouseCode) $($prod.Bin) $($prod.ProductCode) $($prod.Quantity)"

    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    # Note, for this exercise we are going to assume once a bin within a warehouse
    # has something in it, it is full so won't put anything else there.
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $prod; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.WarehouseBinCode.Contains($prod.WarehouseBinCode) -eq $false)
      {        
        $retVal += $prod; $i++   # If not there are are safe to add it
      }
      else
      {
        $dupeTrackingCount++    # Mark as a dupe
        Write-Verbose "$fn - Duplicate   #$($dupeTrackingCount.ToString('#,##0')): $item Skipping"
      }
    }

    # If we exceeded the max dupe error count, error out
    if ( $dupeTrackingCount -ge $MaxDuplicateCountBeforeError )
    {
      $i = $RecordCount + 1     # Set it high so the while loop will exit
      Request-DupeErrorMessage -FunctionName $fn -DuplicateCount $dupeTrackingCount | Write-Verbose
    }
  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Sort the output before returning
  $retVal = $retVal | Sort-Object -Property WarehouseBinCode

  # Return our results
  return $retVal

}