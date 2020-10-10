# Open-DataFabricatorWebsite

## SYNOPSIS

Opens the GitHub site for DataFabricator in your default browser.

## SYNTAX

```powershell
Open-DataFabricatorWebsite [[-FunctionName] <String>] [<CommonParameters>]
```

## DESCRIPTION

As stated, this will open my github site for the DataFabricator project.
This should make it easy to quickly open the site.

You can also pass in the name of a function, and it will jump directly to that function.
Because this assembles a URL out of the function name, the case of the function name must match exactly, i.e.
Get-FabricatedBin and not get-fabricatedbin.

Note that Microsoft Edge doesn't always pop up above your current terminal or VSCode, so look for it flashing in the Windows toolbar if Edge is your default browser.

Also, don't trust me by default.
Check out the source code before you use this so, from a security perspective, you'll be sure you are getting sent to github.
While I wouldn't do anything nefarious, you should always be cautions when opening up strange webistes.

## EXAMPLES

### EXAMPLE 1

```powershell
Open-DataFabricatorWebsite
```

Opens the github page for DataFabricator in your default web browser.

### EXAMPLE 2

```powershell
Open-DataFabricatorWebsite -FunctionName Get-FabricatedBin
```

Opens the github page for DataFabricator in your default web browser and jumps directly to the Get-FabricatorBin documentation page.

## PARAMETERS

### -FunctionName

The name of one of the many functions within the DataFabricator module.
To see a short list of all the commands, use Get-Command -Module DataFabricator | Select-Object Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Missing
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

Opens the DataFabricator site on GitHub.

## NOTES

Data Fabricator - Open-DataFabricatorWebsite.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[CMDLET-HERE](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
