# DataFabricator

## Overview

DataFabricator is a PowerShell module for generating fake, but realistic looking data. You can fabricate data in two ways.

First, you can use the Get-* methods to generate a single piece of fake data, such as a name or date. Switches and parameters allow you to alter the output. For example, by default the Get-FabricatedName returns a string of "First Last" name. However, using switches you can fabricate just the first, just the last, first and last with a middle initial, or the full middle name.

Next are the New-* cmdlets. These will generate one or more records with a common set of data. As an example, take the New-FabricatedCompanyRecord. This cmdlet will create one or more objects, aka  "records", with a made up company name, address, phone number, contact person, and more.

We've also included a few ConvertFrom-\* / ConvertTo-\* cmdlets. In some of the functions unique keys are generated from the source data. These cmdlets can be used to convert from data into its key, and from the key back into its data components.

Finally there is the Test-* cmdlets, used to validate data. Right now there is only one, but more may be added in the future.

In addition to the code for the module itself, a complete set of documentation is included. Additionally, a full suite of Pester tests are part of the module source code, so any future changes can be validated.

## External Modules

There are no external modules required to use DataFabricator. It is self contained. However, if you wish to work with the source code you'll want to additional modules.

The first is PlatyPS, the current version. It is used to generate much of the documentation in the Documentation folder for the included inline help at the beginning of each function. See the Export-Documentation.ps1 file, in the root folder, for more information. It is extensively commented.

The other is Pester. Pester is used to execute the tests (found in the Tests folder) that were used to validate the functions in this module. At the time of this writing, Pester 5.0 is the current version, however it had some limitations that made it hard to author tests for this module. As such, I chose to use the Pester 5.1 beta to create all the tests. I've been assured by the author of Pester that version 5.1 will be released by year's end, if not much sooner. You can find full details in the Execute-Tests.ps1 file, also located in the root folder.

## Multi-Platform

This module was developed using PowerShell 7 (aka PowerShell Core 7, Microsoft keeps changing the name). I've not found anything in the DataFabricator itself that would not work under PowerShell 6. (Note, I can't swear the same for PlatyPS and Pester, as I've not tested their specified versions on PowerShell 6.)

This code was tested on Windows 10, macOS Catalina, and Ubuntu 20.04. Please note that PowerShell 7 is not yet "offically" supported on Ubuntu 20.04, however I found no problems executing this module (as well as other projects I've worked on) under Ubuntu 20.04. It should also operate fine on other Linux platforms that support PowerShell 7, but be sure to let me know if you run across issues.

## Additional Documentation

For more information, please see the following documentation.

[DataFabricator](./Documentation/DataFabricator.md) - Lists all of the cmdlets in the DataFabricator module, along with a brief synopsis. It also includes a link to the detailed documentation for each cmdlet.

[File Structure](./Documentation/DataFabricator-FileStructure.md) - For those who want a peek "behind the scenes", this document covers the layout of the files that are part of the module

[Internationalization](./Documentation/DataFabricator-Internationalization.md) - Talks about the current state of making DataFabricator usable internationally.

[Markdown Cheat Sheet](./Documentation/MarkdownCheatsheet.md) - This is just a simple cheat sheet for markdown, so I can quickly reference markdown formatting as I'm authoring these markdown files.

Note, during the development of this module I made extensive use of User Snippets in VSCode. I've placed copies of my snippets files for PowerShell and Markdown in the repository [VSCode_User_Snippets](https://github.com/arcanecode/VSCode_User_Snippets). I've included documentation on how snippets work and how to use them. Feel free to use all or part of them as you see fit.

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
