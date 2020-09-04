function ConvertTo-CityCode()
{
  [CmdletBinding()]
  param (
          [string] $City
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CityStateCode: $CityStateCode
"@

  $retVal = $City.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()
  Write-Verbose "$fn City Code: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}