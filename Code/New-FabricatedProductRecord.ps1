class Product
{
  [string] $ProductCode
  [string] $Clothing
  [string] $Color
  [string] $Size
}

function New-FabricatedProductRecord {
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count: $RecordCount
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
"@

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount)
  {
    $product = [Product]::new()
    $product.Clothing = $m_Clothing | Get-Random
    $product.Color = $m_Colors | Get-Random
    $product.Size = $m_Sizes | Get-Random
    
    $product.ProductCode = ConvertTo-ProductCode -Clothing $product.Clothing `
                                                 -Color $product.Color `
                                                 -Size $product.Size
    
    $clothSp = ' ' * ($c_MaxClothingLength - $product.Clothing.Length)
    $colorSp = ' ' * ($c_MaxColorLength - $product.Color.Length)
    $prodData = "Product $($product.ProductCode) $($product.Clothing)$clothSp $($product.Color)$colorSp $($product.Size)"

    $progressMessage = "$fn - Fabricating #$($i.ToString('#,##0')): $prodData"
    Write-Verbose $progressMessage

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $product; $i++
    }   
    else
    {
      # Now do the dupe check
      if ( $retVal.ProductCode.Contains($product.ProductCode) -eq $false )
      {        
        $retVal += $product; $i++   # If not there are are safe to add it
      }
      else
      {        
        $dupeTrackingCount++        # Mark as a dupe
        Write-Verbose "$fn - Duplicate   #$($dupeTrackingCount.ToString('#,##0')): $prodData Skipping"
      }        
    }

    # If we exceeded the max dupe error count, error out
    if ( $dupeTrackingCount -ge $MaxDuplicateCountBeforeError )
    {
      $i = $RecordCount + 1     # Set it high so the while loop will exit
      $extra = "If you are looking to get ALL product records, please see the function New-FabricatedProductTable."
      Request-DupeErrorMessage -FunctionName $fn -DuplicateCount $dupeTrackingCount -Extra $extra | Write-Verbose
    }
  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Sort the output
  $retVal = $retVal | Sort-Object -Property ProductCode

  # Return our results
  return $retVal 

}
