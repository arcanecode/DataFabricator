<#
.SYNOPSIS
Creates a product code from the clothing, color and size.

.DESCRIPTION
The product code consists of the first three characters from the clothing, color, and size all upper cased.

Based on the sample data included with this module this will create a unique value that is used as a key in several places.

.PARAMETER Clothing
A string with the name of the clothing.

.PARAMETER Color
A string with the color of the product.

.PARAMETER Size
A string with the size of the product.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the 9 character product code.

.EXAMPLE
ConvertTo-ProductCode -Clothing 'Gloves' -Color 'Ocean Green' -Size 'Large'

ConvertTo-ProductCode returns data similar to the following example:

ProductCode | GLOOCELAR

.NOTES
Data Fabricator - ConvertTo-ProductCode.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductTable.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function ConvertTo-ProductCode()
{
  [CmdletBinding()]
  param (
          [string] $Clothing
        , [string] $Color
        , [string] $Size
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Clothing..: $Clothing
         Color.....: $Color
         Size......: $Size
"@

  $retVal = $Clothing.Substring(0,3).ToUpper() `
          + $Color.Substring(0,3).ToUpper() `
          + $Size.Substring(0,3).ToUpper()

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  # Return our data
  return $retVal
  
}
