function Get-StateName()
{
  [CmdletBinding()]
  param (
          [string] $StateAbbr
        , [string] $CountryCode = 'US'
        )

  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         State Abbreviation: $StateAbbr
         Country Code: $CountryCode
"@

# If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  switch ($CountryCode) {
    'UK'    { $retVal = $m_StateTableUK[$StateAbbr] }
    'US'    { $retVal = $m_StateTableUS[$StateAbbr] }
    default { $retVal = $m_StateTableUS[$StateAbbr] }
  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}
