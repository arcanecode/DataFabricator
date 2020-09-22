#------------------------------------------------------------------------------------------------
# In version 5.1 of Pester, the author has indicated they want to enable
# looping for a Describe block in the manner below.
# In version 5.0.x, however, this is not implemented so having to do
# loops in the IT blocks as shown in the DataFabricator.Module.Tests.ps1
# I've left this sa an example, so when Pester 5.1 is released
# I can test it and hopefully shift testing over to this model
#------------------------------------------------------------------------------------------------


  $functions = ( 'ConvertFrom-CityStateCode',
                 'ConvertFrom-ProductCode' #,
               #  'ConvertTo-CityCode',
               #  'ConvertTo-ProductCode',
               #  'Get-CountryCodes',
               #  'Get-FabricatedAddressLine1',
               #  'Get-FabricatedAddressLine2',
               #  'Get-FabricatedBin',
               #  'Get-FabricatedCity',
               #  'Get-FabricatedCompany',
               #  'Get-FabricatedDate',
               #  'Get-FabricatedJobTitle',
               #  'Get-FabricatedName',
               #  'Get-FabricatedPhone',
               #  'Get-FabricatedPostalCode',
               #  'Get-FabricatedState',
               #  'Get-FabricatedTaxpayerID',
               #  'Get-FabricatedTime',
               #  'Get-StateName',
               #  'New-FabricatedCityStatePostalCodeRecord',
               #  'New-FabricatedCompanyRecord',
               #  'New-FabricatedCustomerRecord',
               #  'New-FabricatedEmployeeRecord',
               #  'New-FabricatedInventoryRecord',
               #  'New-FabricatedNameRecord',
               #  'New-FabricatedProductRecord',
               #  'New-FabricatedProductTable',
               #  'New-FabricatedSalesRecord',
               #  'Test-CountryCode'
               )

Describe 'Data Fabricator Functions Tests' -ForEach $functions {

  BeforeAll{
    $file = $_
    $module = 'DataFabricator'
    $here = Split-Path -parent $PSCommandPath

  }

      It "Does the function $function exist?" {
        "$here\..\Code\$function.ps1" | Should -Exist
      }

}



