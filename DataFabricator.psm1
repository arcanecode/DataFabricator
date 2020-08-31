<#-----------------------------------------------------------------------------
  Beginning PowerShell Scripting for Developers
  Zip Code Lookups
  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2015 Robert C. Cain. All rights reserved.
  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 
  This module may not be reproduced in whole or in part without the express
  written consent of the author. 
  Notes
  This module demonstrates several concepts. First, it illustrates how to 
  call a REST API. The USPS (United States Postal Service) has an API
  which will allow you to retrieve a City and State based on a passed in
  Zip Code. 
  In order to use it, you will need to first register. It's free, just
  go to:
  https://www.usps.com/business/web-tools-apis/welcome.htm
  and register. They'll send you an email with your user ID. 
  In the code below replace the xxxxxxxxx's with your user id, then these
  demos should work.
  Next, it demonstrates how to integrate the new class features of PowerShell
  Version 5 with modules. 
-----------------------------------------------------------------------------#>

# Use the $PSVersionTable.OS value to determine which OS you are on.
# Then load the files setting the \ or / according to the OS.

# Run the scripts to load data into memory
. .\Data\Load-Address2.ps1
. .\Data\Load-Cities.ps1
. .\Data\Load-Company.ps1
. .\Data\Load-Compass.ps1
. .\Data\Load-JobTitles.ps1
. .\Data\Load-Letter.ps1
. .\Data\Load-NamesFirst.ps1
. .\Data\Load-NamesLast.ps1
. .\Data\Load-Products.ps1
. .\Data\Load-States.ps1
. .\Data\Load-StreetsFirst.ps1
. .\Data\Load-StreetsLast.ps1


# Run the scripts to load the functions into memory
. .\Code\Get-FabricatedAddressLine1.ps1
. .\Code\Get-FabricatedAddressLine2.ps1
. .\Code\Get-FabricatedBin.ps1
. .\Code\Get-FabricatedCity.ps1
. .\Code\Get-FabricatedCityStateZipCode.ps1
. .\Code\Get-FabricatedCompany.ps1
. .\Code\Get-FabricatedDate.ps1
. .\Code\Get-FabricatedJobTitle.ps1
. .\Code\Get-FabricatedName.ps1
. .\Code\Get-FabricatedPhone.ps1
. .\Code\Get-FabricatedProduct
. .\Code\Get-FabricatedSSN.ps1
. .\Code\Get-FabricatedState.ps1
. .\Code\Get-FabricatedTime.ps1
. .\Code\Get-FabricatedZipCode.ps1
. .\Code\New-FabricatedCompanyRecord.ps1
. .\Code\New-FabricatedEmployeeRecord.ps1
. .\Code\New-FabricatedProductTable.ps1

#-----------------------------------------------------------------------------#
# Export our functions
#-----------------------------------------------------------------------------#
Export-ModuleMember Get-FabricatedAddressLine1
Export-ModuleMember Get-FabricatedAddressLine2
Export-ModuleMember Get-FabricatedBin 
Export-ModuleMember Get-FabricatedCity
Export-ModuleMember Get-FabricatedCityStateZipCode
Export-ModuleMember Get-FabricatedCompany 
Export-ModuleMember Get-FabricatedDate
Export-ModuleMember Get-FabricatedJobTitle
Export-ModuleMember Get-FabricatedName
Export-ModuleMember Get-FabricatedPhone
Export-ModuleMember Get-FabricatedProduct

Export-ModuleMember Get-FabricatedSSN
Export-ModuleMember Get-FabricatedState
Export-ModuleMember Get-FabricatedTime
Export-ModuleMember Get-FabricatedZipCode
Export-ModuleMember New-FabricatedCompanyRecord
Export-ModuleMember New-FabricatedEmployeeRecord
Export-ModuleMember New-FabricatedProductTable 
