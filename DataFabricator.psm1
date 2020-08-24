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

# Run the scripts to load data into memory
. .\Data\Load-NamesFirst.ps1

# Run the scripts to load the functions into memory
. .\Code\Get-RandomValue.ps1

#-----------------------------------------------------------------------------#
# Export our functions
#-----------------------------------------------------------------------------#
Export-ModuleMember Get-FirstName
