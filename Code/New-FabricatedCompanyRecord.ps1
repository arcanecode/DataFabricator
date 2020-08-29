class CompanyRecord
{
  [string] $Name
  [string] $Address1
  [string] $Address2
  [string] $City
  [string] $State
  [string] $Zip
  [string] $ContactName
  [string] $ContactPhone
  [string] $ContactEMail
  [string] $ContactJobTitle
}
function New-FabricatedCompanyRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        )

  # Declare an empty array to hold the results

  $retVal = @()
  
  for ($i = 0; $i -lt $RecordCount; $i++) 
  {
    $company = [CompanyRecord]::new()
    $company.Name = Get-FabricatedCompany
    $company.Address1 = Get-FabricatedAddressLine1
    $company.Address2 = Get-FabricatedAddressLine2
    $company.City = Get-FabricatedCity
    $company.State = Get-FabricatedState
    $company.Zip = Get-FabricatedZipCode

    $firstName = Get-FabricatedName -First
    $lastName = Get-FabricatedName -Last

    $company.ContactName = "$firstName $lastName"
    $company.ContactPhone = Get-FabricatedPhone
    $company.ContactJobTitle = Get-FabricatedJobTitle

    $email = $company.Name.ToLower().Replace(' ', '')
    $company.ContactEMail = "$($firstName.Substring(0, 1).ToLower()).$($lastName.ToLower())@$($email).com"
    

    $retVal += $company
  }

  return $retVal

}