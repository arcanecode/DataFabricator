<#
.SYNOPSIS
Fabricate a table with all possible combinations of products.

.DESCRIPTION
This cmdlet will return a collection of all possible combinations of product codes that are contained in the included sample dataset.
Note this cmdlet and New-FabricatedProductRecord both return the same output type, so they can be used interchangeably.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Returns an array with objects that have the following properties.

ProductCode | The 9 character product code to uniquely identify this product.
Clothing    | The type of clothing, shirt, pants and so forth
Color       | The color of the clothing, such as red, green, or blue
Size        | The size of the clothing, for example medium, large, 1XL, 2XL

.EXAMPLE
New-FabricatedProductTable

This is a subset of the data that is returned:

ProductCode | COAMAUEXT
Clothing    | Coat
Color       | Mauve
Size        | Extra large
ProductCode | COAMAU2XL
Clothing    | Coat
Color       | Mauve
Size        | 2XL
ProductCode | COAMAU3XL
Clothing    | Coat
Color       | Mauve
Size        | 3XL
ProductCode | COAMAU4XL
Clothing    | Coat
Color       | Mauve
Size        | 4XL

.NOTES
Data Fabricator - New-FabricatedProductTable.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function New-FabricatedProductTable
{
  [CmdletBinding()]
  param (
  )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Define the output object
  class ProductTable
  {
    [string] $ProductCode
    [string] $Clothing
    [string] $Color
    [string] $Size
  }
  
  $products = @()
  $i = 0

  foreach($clothing in $m_Clothing)
  {
    foreach($color in $m_Colors)
    {
      foreach($size in $m_Sizes)
      {
        $productCode = ConvertTo-ProductCode -Clothing $clothing `
                                             -Color $color `
                                             -Size $size `
                                             -Verbose:$false

        $prod = [ProductTable]::new()
        $prod.ProductCode = $productCode
        $prod.Clothing = $clothing
        $prod.Color = $color
        $prod.Size = $size

        $clothSp = ' ' * ($c_MaxClothingLength - $prod.Clothing.Length)
        $colorSp = ' ' * ($c_MaxColorLength - $prod.Color.Length)
        $prodData = "Product $($prod.ProductCode) $($prod.Clothing)$clothSp $($prod.Color)$colorSp $($prod.Size)"
        Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $prodData"
        
        $products += $prod 
        $i++
      }
    }
  }
  
 # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $products 

}
