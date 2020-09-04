function Get-FabricatedName()
{
  [CmdletBinding()]
  param (
          [switch] $First
        , [switch] $Last
        , [switch] $FirstMiLast
        , [switch] $FirstMiddleLast
        , [switch] $LastFirst
        , [switch] $LastFirstMi
        , [switch] $LastFirstMiddle
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Go ahead and generate some names, we'll use these to assemble the output
  $firstName = $m_NamesFirst | Get-Random
  $mi = $m_Letter | Get-Random
  $middleName = $m_NamesFirst | Get-Random
  $lastName = $m_NamesLast | Get-Random    

  switch ($true)
  {
    $First.IsPresent { $retVal = $firstName }

    $Last.IsPresent  { $retVal = $lastName }

    $FirstMiLast.IsPresent { $retVal = "$firstName $mi. $lastName" }

    $FirstMiddleLast.IsPresent { $retVal = "$firstName $middleName $lastName" }

    $LastFirst.IsPresent { $retVal = "$lastName, $firstName" }

    $LastFirstMi.IsPresent { $retVal = "$lastName, $firstName $mi." }

    $LastFirstMiddle.IsPresent { $retVal = "$lastName, $firstName $middleName" }

    default { $retVal = "$firstName $lastName" }
  }

  Write-Verbose "$fn Fabricated Name $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal 

}
