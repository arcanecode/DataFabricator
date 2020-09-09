<#
.SYNOPSIS
Fabricates a company name.

.DESCRIPTION
Let's face it, no real company wants to be associated with the likes of us.
So we wrote this cmdlet, which randomly generates a company name from three parts to create a realistic name.
The first part is a name, such as Arcane, the second is an industry, such as Training, the final part is a company type such as Incorporated.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String holding a company name.

.EXAMPLE
Get-FabricatedCompany

Get-FabricatedCompany returns data similar to the following example:

Company | Arcane Training Inc

.NOTES
Data Fabricator - Get-FabricatedCompany.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedCompany()
{
  [CmdletBinding()]
  param ()

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  $coFirst = $m_CompanyFirst | Get-Random
  $coIndustry = $m_CompanyIndustry | Get-Random
  $coLast = $m_CompanyLast | Get-Random 

  $retVal = "$coFirst $coIndustry $coLast"

  Write-Verbose "$fn Fabricated Company: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal 

}