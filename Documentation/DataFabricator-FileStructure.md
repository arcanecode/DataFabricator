# DataFabricator - File Structure

## Overview

In this document I will cover the layout of the file structure for the DataFabricator module. This will hopefully assist you in finding things as you review the code.

## Root Folder

In the root directory are several files, including this read me.

Of course, we have the DataFabricator psd1 and psm1, which are required for any module.

The DataFabricatorUsage.ps1 file has simple examples of how to use each function. I used this during development, but you can also use it to explore the features of DataFabricator. Note this, as well as the other scripts, were designed to run from the root folder, so be sure to change your current path in the terminal to where you have extracted the DataFabricator project to.

Execute-Tests.ps1 has a list of all the tests and the commands to either execute a test individually or all in bulk.

Export-Documentation.ps1 will call the PlatyPS module to generate the majority of the markdown files in the Documentation folder.

## Code

This folder contains most (but not quite all) of the source code for the DataFabricator module. Each function is contained in its own ps1 file, and has complete PowerShell help at the top as well as extensive comments.

Note that there are a few helper functions in the Internal folder that are used by the functions but not exported outside the module.

## Data

The data folder contains all of the data used to generate the fabricated data. The data itself is in .txt files, making it easy to alter should you wish to.

The data itself is loaded into module level variables using the Load-\*.ps1 files, also located in this folder, called from the DataFabricator.psm1. The Get-\* functions then access these module level variables using the PowerShell Get-Random cmdlet.

Note there is an alternative method I could have used to load the data. Rather than loading it all at once, I could have loaded it with each call to one of the Get-\* cmdlets. It was done once only, at module load time, for speed. While it is a bit slow to load the module initially, when you call one of the New-\* cmdlets and pass in a large value for the RecordCount parameter, it would have executed the Get-\* function repeatedly, calling the load over and over. This would have made the New-\* functions very slow to execute.

The data contained in the .txt files comes from a variety of sources. Names data was culled from decades of US census data. City and State names were culled from publicly available datasets. Likewise the job titles were assembled from a wide variety of job listings found across the internet (including my dream job, Zamboni Driver). Some of these data files contains thousands, if not tens of thousands of rows, and thus should give well randomized data.

That said, it is possible that you could wind up with common real names, such as "John Smith". Should this occur, and you get any complaints, you can simply point back to this project indicating it was randomly generated and no implication of a real person was intended. In addition, you could remove the common name (i.e. Smith) from the .txt and eliminate the problem in the future.

Many of the functions fabricate data through compilation. For example, the Get-FabricatedAddress1 works by first generating a random number for the first part of the address. It then randomly selects part of a street address from the Data-StreetsFirst data, which holds names such as Main, First, Second, Oak, Elm, and other common names. It then concludes by appending a word from the Data-StreetsLast.txt file, which holds names such as Street, Avenue, Lane, and so on.

This can have some interesting side effects. For example, you could wind up with Salt Lake City, New Mexico, or Boston, Alabama. While not real locations, they are realistic looking.

Also note where numbers are concerned, such as postal codes or phone numbers, the numbers are simply randomly generated. It's possible then to generate a postal code that doesn't exist. Inversely, it's possible to, through sheer randomness, generate a real phone number. If this is a concern, you can override the phone prefix (using the -PhonePrefix parameter) and pass in a fake prefix, such as 555 in the US.

One last note, for the products I've chosen something generic, clothing. I use a clothing type, shirts, pants, etc, plus colors and sizes. You could also consider refactoring this (or creating your own version) to work with your companies actual products.

## Documentation

The Documentation folder contains Markdown files for this module. The only exception is in each folder there is a small ReadMe.md file which describes the purpose of the folder and has a link to the document you are reading right now for more information.

Each markdown that matches the name of a function was auto-generated using the open source PlatyPS module. This is done in the Export-Documentation.ps1 file, found in the root folder. See the comments within it for detailed information on how PlatyPS works, but in brief it takes the help comments found at the top of each ps1 file to create a corresponding markdown. Do not alter these directly, as when you run Export-Documentation.ps1 they will be overwritten. Instead, update the help comments within each function.

Other files, such as these DataFabricator*.md files, have been lovingly hand crafted by your humble author.

## Internal

There are a few functions created for internal use only. These are documented in the help comments at the top, but as they are not publicly available outside the module do not have markdown files generated from PlayPS. These are primarily for generating error messages and write-verbose text, so I could keep a consistent message across all of the functions.

## SampleOutput

The SampleOutput folder should be empty, except for the ReadMe.md file. Some of the samples in the DataFabricatorUsage.ps1 file in the root folder generate data to a file. I have it write the files to this folder to keep them cluttering up other folders. If you go through some of the examples you can safely delete the output here when you are done.

## Tests

The Tests folder has all of the Pester tests for the module. Please see the Execute-Tests.ps1 file in the root folder for more information on how to execute the tests.

[Return to ReadMe](..\ReadMe.md)

---

## Author Information

### Author

Robert C. Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcanecode@gmail.com

### Websites

About Me: [http://arcanecode.me](http://arcanecode.me)

Blog: [http://arcanecode.com](http://arcanecode.com)

Github: [http://arcanerepo.com](http://arcanerepo.com)

LinkedIn: [http://arcanecode.in](http://arcanecode.in)

### Copyright Notice

This document is Copyright (c) 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
