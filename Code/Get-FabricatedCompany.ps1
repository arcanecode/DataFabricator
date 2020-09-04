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