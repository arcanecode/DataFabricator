<#
.SYNOPSIS
Fabricates one or more product records.

.DESCRIPTION
This will generate one or more product records with the output type as described in the output section below.
Note this cmdlet and New-FabricatedProductTable return the same output type, so could be used interchangeably.
The main difference is this cmdlet randomly generates product data, and thus will be a subset of the product table, whereas New-FabricatedProductTable returns all possible products.

.PARAMETER RecordCount
The number of records you want returned from this cmdlet. The default is 1.

.PARAMETER MaxDuplicateCountBeforeError
This cmdlet checks for duplicates so they are removed from the final output.
By default, once the cmdlet has generated 50 duplicates it will throw an error and exit before all the records have been generated (although it will return what it has generated to that point).
It is possible in some cases to request more records than it is possible to create based on the internal data.
To keep from falling into an infinite loop this mechanism will exit and let the user know what the issue is.
Normally you won't need to override this, but it is possible should you feel the need.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Returns an array with objects that have the following properties.

ProductCode | The 9 character product code to uniquely identify this product.
Clothing | The type of clothing.
Color | The color of the clothing.
Size | The size of the clothing.

.EXAMPLE
New-FabricatedProductRecord

This is a subset of the data that is returned:

ProductCode | COAMAUEXT
Clothing | Coat
Color | Mauve
Size | Extra large
ProductCode | COAMAU2XL
Clothing | Coat
Color | Mauve
Size | 2XL
ProductCode | COAMAU3XL
Clothing | Coat
Color | Mauve
Size | 3XL
ProductCode | COAMAU4XL
Clothing | Coat
Color | Mauve
Size | 4XL

.NOTES
Data Fabricator - New-FabricatedProductRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductTable.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

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

  # Define the output object
  class Product
  {
    [string] $ProductCode
    [string] $Clothing
    [string] $Color
    [string] $Size
  }
  
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
                                                 -Size $product.Size `
                                                 -Verbose:$false
    
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
