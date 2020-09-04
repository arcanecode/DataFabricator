class City
{
  [string] $City
  [string] $State
}
function ConvertFrom-CityStateCode()
{ 
  [CmdletBinding()]
  param (
          [string] $CityStateCode
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CityStateCode: $CityStateCode
"@

  #Extract the State abbreviation
  $state = $CityStateCode.Substring(0, 2)

  # Extract the City Code
  $code = $CityStateCode.Substring(2)
  
  # Get the city code based on the code from the hash table
  $city = $m_CityCodes[$code]

  # Create a new object to return
  $retVal = [City]::new()
  $retVal.City = $city
  $retVal.State = $state

  # Show what we found
  Write-Verbose "$fn City: $city State: $state"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}