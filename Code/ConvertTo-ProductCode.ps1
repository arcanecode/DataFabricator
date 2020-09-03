function ConvertTo-ProductCode()
{
  [CmdletBinding()]
  param (
          [string] $Clothing
        , [string] $Color
        , [string] $Size
        )

  $retVal = $Clothing.Substring(0,3).ToUpper() `
          + $Color.Substring(0,3).ToUpper() `
          + $Size.Substring(0,3).ToUpper()

  return $retVal
  
}
