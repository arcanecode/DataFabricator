function Request-DupeErrorMessage()
{
  [CmdletBinding()]
  param (
          [string] $FunctionName
        , [int] $DuplicateCount
        , [string] $Extra = ''
        )

  if ($Extra.Length -gt 0)
  {
      $dupeErrorMessage = @"
Error
  Function: $FunctionName
  Time: $(Get-Date -Format 'yyyy-MM-dd hh:mm:ss tt' )
  Error Message: Duplicate Max Count Exceeded, $DuplicateCount duplicates were generated. 
                                                                                                        -
Explanation:
  You may have tried to fabricate more records than the number of possible combinations.
                                                                                                        -
Suggestion: 
  Try running again with a lower value for the RecordCount parameter.
  Alternatively, increase the value of the MaxDuplicateCountBeforeError to a number greater than $MaxDuplicateCountBeforeError
  $Extra
                                                                                                        -
"@
  }
  else
  {
    $dupeErrorMessage = @"
Error
  Function: $FunctionName
  Time: $(Get-Date -Format 'yyyy-MM-dd hh:mm:ss tt' )
  Error Message: Duplicate Max Count Exceeded, $DuplicateCount duplicates were generated. 
                                                                                                        -
Explanation:
  You may have tried to fabricate more records than the number of possible combinations.
                                                                                                        -
Suggestion: 
  Try running again with a lower value for the RecordCount parameter.
  Alternatively, increase the value of the MaxDuplicateCountBeforeError to a number greater than $MaxDuplicateCountBeforeError
                                                                                                        -
"@
  }

  return $dupeErrorMessage

}
