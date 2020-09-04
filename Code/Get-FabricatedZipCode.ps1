function Get-FabricatedZipCode {

  [CmdletBinding()]
  param (
          [Alias('PlusFour')]
          [switch] $Plus4
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Get a random number for the first part
  $first = $(1..99999 | Get-Random).ToString().PadLeft(5, '0')

  if ($Plus4.IsPresent)
  {
    $last = "-$($(1..9999 | Get-Random).ToString().PadLeft(4, '0'))"
  }
  else
  {
    $last = ''
  }

  $retVal = "$($first)$($last)"

  Write-Verbose "$fn Fabricated Zip Code: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}