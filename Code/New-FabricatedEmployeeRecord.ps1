class EmployeeRecord
{
  [string] $FirstName
  [string] $MiddleName
  [string] $LastName
  [string] $SSN
  [string] $EmployeeID
  [string] $EMail
  [string] $HomePhone
  [string] $MobilePhone
  [string] $WorkPhone
  [string] $HomeAddress1
  [string] $HomeAddress2
  [string] $HomeCity
  [string] $HomeState
  [string] $HomeZip
  [string] $WorkAddress1
  [string] $WorkAddress2
  [string] $WorkCity
  [string] $WorkState
  [string] $WorkZip
  [string] $BirthDate
  [string] $HireDate
  [string] $JobTitle
  [string] FullName()
  {
    $retVal = "$($this.FirstName) $($this.MiddleName) $($this.LastName)"
    return $retVal
  }

}
function New-FabricatedEmployeeRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [string] $EMailDomain = 'fakemail.com'
        )

  # Declare an empty array to hold the results

  $retVal = @()
  
  for ($i = 0; $i -lt $RecordCount; $i++) 
  {
    $emp = [EmployeeRecord]::new()

    $emp.FirstName = Get-FabricatedName -First
    $emp.MiddleName = Get-FabricatedName -First
    $emp.LastName = Get-FabricatedName -Last

    $emp.SSN = Get-FabricatedSSN
    $emp.EmployeeID = "$($emp.LastName.Substring(0, 2).ToUpper())$($emp.SSN.Substring($emp.SSN.Length - 4, 4)) "

    $emp.EMail = "$($emp.FirstName.Substring(0, 1).ToLower()).$($emp.LastName.ToLower())@$($EMailDomain)"

    $emp.HomePhone = Get-FabricatedPhone
    $emp.MobilePhone = Get-FabricatedPhone
    $emp.WorkPhone = Get-FabricatedPhone

    $emp.HomeAddress1 = Get-FabricatedAddressLine1
    $emp.HomeAddress2 = Get-FabricatedAddressLine2
    $emp.HomeCity = Get-FabricatedCity
    $emp.HomeState = Get-FabricatedState
    $emp.HomeZip = Get-FabricatedZipCode

    $emp.WorkAddress1 = Get-FabricatedAddressLine1
    $emp.WorkAddress2 = Get-FabricatedAddressLine2
    $emp.WorkCity = Get-FabricatedCity
    $emp.WorkState = Get-FabricatedState
    $emp.WorkZip = Get-FabricatedZipCode

    $emp.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 
    $emp.HireDate = Get-FabricatedDate -RelativeFromYear 15

    $emp.JobTitle = Get-FabricatedJobTitle

    $retVal += $emp
  }

  return $retVal

}