<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-CountryCode.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  To support internationalization, many of the functions include a -CountryCode parameter.
  It is used for returning the correct format for phone numbers, postal codes, and the like.
  In addition, it dictates which module level variable to get things like cities and states from.

  Below are the list of valid country codes currently supported. Note that when a value of
  Unspecified, or when a value is not supplied to the CountryCode parameter, it will default
  to a value of US.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

$m_CountryCode = @(
                    'Unspecified',
                    'US',
                    'UK'
                  )

