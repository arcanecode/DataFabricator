<#
.SYNOPSIS
Fabricates a job title from an internal list.

.DESCRIPTION
This module includes an interal list of over 4,000 real job titles, including my dream job of Zamboni Driver.

This routine will randomly select one from the list and return it.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the job title.

.EXAMPLE
Get-FabricatedJobTitle

Get-FabricatedJobTitle returns data similar to the following example:

Job Title | Credentialing Specialist

.NOTES
Data Fabricator - Get-FabricatedJobTitle.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedJobTitle()
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

  $retVal = $m_JobTitle | Get-Random

  Write-Verbose "$fn Fabricated Job Title $retVal"

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  # Return our results
  return $retVal

}