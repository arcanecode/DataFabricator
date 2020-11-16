<#-------------------------------------------------------------------------------------------------
  Data Fabricator - DataFabricator.psd1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

@{

  # Name of the module to process
  ModuleToProcess = 'DataFabricator.psm1'

  # Each module has to be uniquely identified. To do that PS uses a GUID.
  # To generate a GUID, use the New-Guid cmdlet and copy the result in here
  GUID = '2b6853c1-ed3c-46e3-bcd3-9e52d1de48cb'

  # Who wrote this module
  Author = 'Robert C. Cain'

  # Company who made this module
  CompanyName = 'Arcane Training and Consulting'

  # Copyright
  Copyright = '(c) 2020 All rights reserved'

  # Description of the module
  Description = 'Tools to fabricate realistic but fake data'

  # Version number for the module
  ModuleVersion = '0.9.2'

  # Minimum version of PowerShell needed to run this module
  PowerShellVersion = '6.0'

  # Min version of .NET Framework required
  DotNetFrameworkVersion = '2.0'

  # Min version of the CLR required
  CLRVersion = '2.0.50727'

  # These are the data files the functions use to fabricate data from
  FileList = @( './Data/Data-AboutFunctions.txt',
                './Data/Data-AboutMessage.txt',
                './Data/Data-Address2.txt',
                './Data/Data-CitiesUK.txt',
                './Data/Data-CitiesUS.txt',
                './Data/Data-Clothing.txt',
                './Data/Data-Colors.txt',
                './Data/Data-CompanyIndustry.txt',
                './Data/Data-CompanyNamePrefix.txt',
                './Data/Data-CompanyType.txt',
                './Data/Data-Compass.txt',
                './Data/Data-JobTitles.txt',
                './Data/Data-NamesFirst.txt',
                './Data/Data-NamesLast.txt',
                './Data/Data-Sizes.txt',
                './Data/Data-StateAbbrUK.txt',
                './Data/Data-StateAbbrUS.txt',
                './Data/Data-StateNameUK.txt',
                './Data/Data-StateNameUS.txt',
                './Data/Data-StateTableUK.txt',
                './Data/Data-StateTableUS.txt',
                './Data/Data-StreetsFirst.txt',
                './Data/Data-StreetsLast.txt'
              )

  # Where can you find more info plus source code with documentation
  HelpInfoURI = 'https://github.com/arcanecode/DataFabricator/blob/master/README.md'

}