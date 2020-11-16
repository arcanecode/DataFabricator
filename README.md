# DataFabricator

## Overview

DataFabricator is a PowerShell module for generating fake, but realistic looking data.

The first two cmdlets you may wish to remember are `Show-AboutDataFabricator` and `Show-DataFabricatorFunctions`. The first will show information about the DataFabricator, as well as relevant websites. The second will show a list of the functions in the DataFabricator, as well as a synopsis for each. Both of these could be piped to a text file for quick reference. Another you may find useful in exploring DataFabricator is `Open-DataFabricatorWebsite`. It simply opens up the github site for DataFabricator in your default browser.

Of course, what you are really interested in is fabricating data. You can do so in two ways.

First, you can use the `Get-*` methods to generate a single piece of fake data, such as a name or date. Switches and parameters allow you to alter the output. For example, by default the `Get-FabricatedName` returns a string of "First Last" name. However, using switches you can fabricate just the first, just the last, first and last with a middle initial, with the full middle name, and much more.

Next are the `New-*` cmdlets. These will generate one or more records with a common set of data. As an example, take the `New-FabricatedCompanyRecord`. This cmdlet will create one or more objects, aka  "records", with a made up company name, address, phone number, contact person, and more.

In addition, we've also included a few `ConvertFrom-*` / `ConvertTo-*` cmdlets. In some of the functions unique keys are generated from the source data. These cmdlets can be used to convert from data into its key, and from the key back into its data components.

Finally there is the `Test-*` cmdlets, used to validate data. Right now there is only one, but more may be added in the future.

In addition to the code for the module itself, a complete set of documentation is included. Additionally, a full suite of Pester tests are part of the module source code, so any future changes can be validated.

## External Modules

There are no external modules required to use DataFabricator. It is self contained. However, if you wish to work with the source code you'll want to additional modules.

The first is [PlatyPS](https://github.com/PowerShell/platyPS) , the current version. It is used to generate much of the documentation in the Documentation folder for the included inline help at the beginning of each function. See the Export-Documentation.ps1 file, in the root folder, for more information. It is extensively commented.

The other is [Pester](https://github.com/pester/Pester). Pester is used to execute the tests (found in the Tests folder) that were used to validate the functions in this module. At the time of this writing, Pester 5.0 is the current version, however it had some limitations that made it hard to author tests for this module. As such, I chose to use the Pester 5.1 beta 2 to create all the tests. I've been assured by the author of Pester that version 5.1 will be released by year's end, if not much sooner. You can find full details in the Execute-Tests.ps1 file, also located in the root folder.

## Multi-Platform

This module was developed using PowerShell 7.0.3 (aka PowerShell Core 7, Microsoft keeps changing the name). I've not found anything in the DataFabricator itself that would not work under PowerShell 6. (Note, I can't swear the same for PlatyPS and Pester, as I've not tested their specified versions on PowerShell 6.)

This code was tested on the following platforms:

* Windows 10
* macOS Catalina 10.15.7
* macOS Big Sur 11.0
* Ubuntu 20.04
* Ubuntu 20.10

Please note that PowerShell 7 is not yet "officially" supported on Ubuntu 20.04, however I found no problems executing this module (as well as other projects I've worked on) under Ubuntu 20.04. It should also operate fine on other Linux platforms that support PowerShell 7, but be sure to let me know if you run across issues.

## Additional Documentation

For more information, please see the following documentation.

[DataFabricator](./Documentation/DataFabricator.md) - Lists all of the cmdlets in the DataFabricator module, along with a brief synopsis. It also includes a link to the detailed documentation for each cmdlet.

[File Structure](./Documentation/DataFabricator-FileStructure.md) - For those who want a peek "behind the scenes", this document covers the layout of the files that are part of the module.

[Internationalization](./Documentation/DataFabricator-Internationalization.md) - Talks about the current state of making DataFabricator usable internationally.

[Markdown Cheat Sheet](./Documentation/MarkdownCheatsheet.md) - This is just a simple cheat sheet for markdown, so I can quickly reference markdown formatting as I'm authoring these markdown files.

Note, during the development of this module I made extensive use of User Snippets in VSCode. I've placed copies of my snippets files for PowerShell and Markdown in my repository [VSCode_User_Snippets](https://github.com/arcanecode/VSCode_User_Snippets). I've included documentation on how snippets work and how to use them. Feel free to use all or part of them as you see fit.

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
