function Get-FabricatedSSN()
{
  [CmdletBinding()]
  param (
          [switch] $NoDashes
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Calculate a SSN
  $first = (0..999  | Get-Random).ToString().PadLeft( 3, '0')
  $mid   = (0..99   | Get-Random).ToString().PadLeft( 2, '0')
  $last  = (0..9999 | Get-Random).ToString().PadLeft( 4, '0')

  if ( $NoDashes.IsPresent )
  {
    $retVal = "$($first)$($mid)$($last)"
  }
  else
  {
    $retVal = "$first-$mid-$last"
  }

  Write-Verbose "$fn Fabricated SSN $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}