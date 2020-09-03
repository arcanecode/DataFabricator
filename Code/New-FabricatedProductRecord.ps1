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

  # Message Declarations
  $paramMessage = @"
Parameters
  RecordCount: $RecordCount
  MaxDuplicateCountBeforeError: $MaxDuplicateCountBeforeError

"@

  # Variable Declarations
  $retVal = @()
  $dupeTrackingCount = 0
  $i = 0

  Write-Verbose $paramMessage
  
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

    $progressMessage = "Record Number: $($i.ToString().PadLeft(4, '0')): $prodData"
    Write-Verbose $progressMessage

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $i++
      $retVal += $product
    }   

    # Now do the dupe check
    if ( $retVal.ProductCode.Contains($product.ProductCode) -eq $false )
    {
      # If not there are are safe to add it
      $retVal += $product
      $i++
    }
    else
    {
      # Already there, track the number of dupes and let user know
      $dupeTrackingCount++
      Write-Verbose "Dupe Number..: $($dupeTrackingCount.ToString().PadLeft(4, '0')): $prodData"
    }        

<#
    if ( $retVal.Count -gt 0 )
    {
        if ( $retVal.ProductCode.Contains($product.ProductCode) -eq $false )
        {
          $i++
          $retVal += $product
        }
        else
        {
          $dupeTrackingCount++
          Write-Verbose "Dupe Number..: $($dupeTrackingCount.ToString().PadLeft(4, '0')): $prodData"
        }        
    }
    else
    {
      $i++
      $retVal += $product
    }
#>
    if ( $dupeTrackingCount -ge $MaxDuplicateCountBeforeError )
    {
      $i = $RecordCount + 1 # Set it high so the while loop will exit

      $dupeErrorMessage = @"
Error
  Function: New-FabricatedProductRecord
  Time: $(Get-Date -Format 'MM/dd/yyyy hh:mm:ss tt' )
  Error Message: Duplicate Max Count Exceeded, $dupeTrackingCount duplicates were generated. 
                                                                                                        -
Explanation:
  You may have tried to fabricate more records than the number of possible combinations.
                                                                                                        -
Suggestion: 
  Try running again with a lower value for the RecordCount parameter.
  Alternatively, increase the value of the MaxDuplicateCountBeforeError to a number greater than $MaxDuplicateCountBeforeError
  If you are looking to get ALL product records, please see the function New-FabricatedProductTable.
                                                                                                        -
"@
      Write-Error $dupeErrorMessage
    }

  }

  return $retVal 

}
