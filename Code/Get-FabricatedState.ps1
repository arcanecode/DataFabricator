function Get-FabricatedState()
{
  [CmdletBinding()]
  param (
          [switch] $FullName
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  if ($FullName.IsPresent)
  {
    $retVal = $m_StateName | Get-Random
  }
  else 
  {
    $retVal = $m_StateAbbr | Get-Random  
  }

  Write-Verbose "$fn Fabricated State $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}