<#
.SYNOPSIS
Takes the product code and converts it back to the Clothing, Color and Size.

.DESCRIPTION
The product code is 9 characters, the first three point to the clothing, second three to color, and final three to size. This function breaks them into the three codes then uses an internal lookup table to convert these back into the full clothing, color and size names.
These are then placed into an object with three properties, Clothing, Color, and Size, which is returned.

.PARAMETER ProductCode
The 9 character product code.

.INPUTS
This has no inputs

.OUTPUTS
A object with three fields: Clothing, Color, and Size.

.EXAMPLE
ConvertFrom-ProductCode -ProductCode "GLOOCELAR"

Returns the following data:

Clothing | Gloves
Color | Ocean Green
Size | Large

.NOTES
Data Fabricator - ConvertFrom-ProductCode.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/ConvertTo-ProductCode.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com

#>
function ConvertFrom-ProductCode()
{

  [CmdletBinding()]
  param(
         [string] $ProductCode
       )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         ProductCode: $ProductCode
"@

  # Structure returned by the function
  class Product
  {
    [string] $Clothing
    [string] $Color
    [string] $Size
  }

  # Break the product code down to its three parts
  $clothingCode = $ProductCode.Substring(0, 3)
  $colorCode = $ProductCode.Substring(3, 3)  
  $sizeCode = $ProductCode.Substring(6, 3)

  # Create a new instance of the product
  $retVal = [Product]::new()

  # Lookup the full names from the module level hash tables
  # These were loaded in the Load-Products.ps1 script
  $retVal.Clothing = $m_ClothingCodes[$clothingCode]
  $retVal.Color = $m_ColorCodes[$colorCode]
  $retVal.Size = $m_SizeCodes[$sizeCode]

  Write-Verbose "$ProductCode = $($retVal.Clothing) $($retVal.Color) $($retVal.Size)"

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  # Return our result
  return $retVal 

}