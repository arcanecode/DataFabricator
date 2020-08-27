function Get-FabricatedAddressLine2 ()
{
  [CmdletBinding()]
  param(
         [int] $Threshold = 25
       )

  # Do a little boundary checking
  if ($Threshold -lt 1) { $Threshold = 1 }
  if ($Threshold -gt 100) { $Threshold = 100 }

  # A majority of the time, the Address Line 2 is empty
  # The threshold is the percent of the time it will return a value
  $thresholdPercent = 1..100 | Get-Random

  if ($thresholdPercent -gt $Threshold)
  {
    $retVal = ''
  }
  else 
  {
    $first = $m_Address2First | Get-Random
    
    # 20 percent of the time, use a letter, otherwise use a number
    if ($(1..100 | Get-Random) -gt 20)
    {
      $last = $(1..9999 | Get-Random).ToString()
    }
    else 
    {
      $last = $m_Letter | Get-Random  
    }

    $retVal = "$first $last"
  }

  return $retVal

}