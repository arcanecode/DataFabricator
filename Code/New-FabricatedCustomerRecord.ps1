class CustomerRecord
{
  [string] $FirstName
  [string] $MiddleName
  [string] $LastName
  [string] $CustomerID
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
  [string] FullName()
  {
    $retVal = "$($this.FirstName) $($this.MiddleName) $($this.LastName)"
    return $retVal
  }

}
function New-FabricatedCustomerRecord()
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
    $cust = [CustomerRecord]::new()

    $cust.FirstName = Get-FabricatedName -First
    $cust.MiddleName = Get-FabricatedName -First
    $cust.LastName = Get-FabricatedName -Last

    $custnumber = $(1..999999 | Get-Random).ToString().PadLeft(6,'0')
    $cust.CustomerID = "$($cust.LastName.Substring(0, 2).ToUpper())$($custnumber)"

    $cust.EMail = "$($cust.FirstName.Substring(0, 1).ToLower()).$($cust.LastName.ToLower())@$($EMailDomain)"

    $cust.HomePhone = Get-FabricatedPhone
    $cust.MobilePhone = Get-FabricatedPhone
    $cust.WorkPhone = Get-FabricatedPhone

    $cust.HomeAddress1 = Get-FabricatedAddressLine1
    $cust.HomeAddress2 = Get-FabricatedAddressLine2
    $cust.HomeCity = Get-FabricatedCity
    $cust.HomeState = Get-FabricatedState
    $cust.HomeZip = Get-FabricatedZipCode

    $cust.WorkAddress1 = Get-FabricatedAddressLine1
    $cust.WorkAddress2 = Get-FabricatedAddressLine2
    $cust.WorkCity = Get-FabricatedCity
    $cust.WorkState = Get-FabricatedState
    $cust.WorkZip = Get-FabricatedZipCode

    $cust.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 
 
    $retVal += $cust
  }

  return $retVal

}