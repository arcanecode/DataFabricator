<#-------------------------------------------------------------------------------------------------
  Data Fabricator - DataFabricator.psm1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Run the scripts to load data into memory. These need to be run prior to running the functions.
. .\Data\Load-AboutMessages.ps1
. .\Data\Load-Address2.ps1
. .\Data\Load-Cities.ps1
. .\Data\Load-Company.ps1
. .\Data\Load-Compass.ps1
. .\Data\Load-CountryCode.ps1
. .\Data\Load-JobTitles.ps1
. .\Data\Load-Letter.ps1
. .\Data\Load-NamesFirst.ps1
. .\Data\Load-NamesLast.ps1
. .\Data\Load-Products.ps1
. .\Data\Load-States.ps1
. .\Data\Load-StreetsFirst.ps1
. .\Data\Load-StreetsLast.ps1

# Run the scripts to load the functions into memory
. .\Code\ConvertFrom-CityStateCode.ps1
. .\Code\ConvertFrom-ProductCode.ps1
. .\Code\ConvertTo-CityCode.ps1
. .\Code\ConvertTo-ProductCode.ps1
. .\Code\Get-CountryCodes.ps1
. .\Code\Get-StateName.ps1
. .\Code\Get-FabricatedAddressLine1.ps1
. .\Code\Get-FabricatedAddressLine2.ps1
. .\Code\Get-FabricatedBin.ps1
. .\Code\Get-FabricatedCity.ps1
. .\Code\Get-FabricatedCompany.ps1
. .\Code\Get-FabricatedDate.ps1
. .\Code\Get-FabricatedJobTitle.ps1
. .\Code\Get-FabricatedName.ps1
. .\Code\Get-FabricatedPhone.ps1
. .\Code\Get-FabricatedTaxpayerID.ps1
. .\Code\Get-FabricatedState.ps1
. .\Code\Get-FabricatedTime.ps1
. .\Code\Get-FabricatedPostalCode.ps1
. .\Code\New-FabricatedCityStatePostalCodeRecord.ps1
. .\Code\New-FabricatedCompanyRecord.ps1
. .\Code\New-FabricatedCustomerRecord.ps1
. .\Code\New-FabricatedEmployeeRecord.ps1
. .\Code\New-FabricatedInventoryRecord.ps1
. .\Code\New-FabricatedNameRecord.ps1
. .\Code\New-FabricatedProductRecord.ps1
. .\Code\New-FabricatedProductTable.ps1
. .\Code\New-FabricatedSalesRecord.ps1
. .\Code\Open-DataFabricatorWebsite.ps1
. .\Code\Show-AboutDataFabricator.ps1
. .\Code\Show-DataFabricatorFunctions.ps1
. .\Code\Test-CountryCode.ps1

# Run scripts to load internal functions, used only in the module
. .\Internal\Request-DupeErrorMessage.ps1
. .\Internal\Request-EndRunMessage.ps1

# A few hash tables rely on some of the functions, so these have to be run
# after the functions are loaded
. .\Data\Load-TableCityCodes.ps1
. .\Data\Load-TableProducts.ps1

#-----------------------------------------------------------------------------#
# Export our functions
#-----------------------------------------------------------------------------#
Export-ModuleMember ConvertFrom-CityStateCode
Export-ModuleMember ConvertFrom-ProductCode
Export-ModuleMember ConvertTo-CityCode
Export-ModuleMember ConvertTo-ProductCode

Export-ModuleMember Get-CountryCodes
Export-ModuleMember Get-StateName
Export-ModuleMember Get-FabricatedAddressLine1
Export-ModuleMember Get-FabricatedAddressLine2
Export-ModuleMember Get-FabricatedBin
Export-ModuleMember Get-FabricatedCity
Export-ModuleMember Get-FabricatedCompany
Export-ModuleMember Get-FabricatedDate
Export-ModuleMember Get-FabricatedJobTitle
Export-ModuleMember Get-FabricatedName
Export-ModuleMember Get-FabricatedPhone
Export-ModuleMember Get-FabricatedTaxpayerID
Export-ModuleMember Get-FabricatedState
Export-ModuleMember Get-FabricatedTime
Export-ModuleMember Get-FabricatedPostalCode

Export-ModuleMember New-FabricatedCityStatePostalCodeRecord
Export-ModuleMember New-FabricatedCompanyRecord
Export-ModuleMember New-FabricatedCustomerRecord
Export-ModuleMember New-FabricatedEmployeeRecord
Export-ModuleMember New-FabricatedInventoryRecord
Export-ModuleMember New-FabricatedNameRecord
Export-ModuleMember New-FabricatedProductRecord
Export-ModuleMember New-FabricatedProductTable
Export-ModuleMember New-FabricatedSalesRecord

Export-ModuleMember Open-DataFabricatorWebsite
Export-ModuleMember Show-AboutDataFabricator
Export-ModuleMember Show-DataFabricatorFunctions
Export-ModuleMember Test-CountryCode
