# Get-FabricatedCompany

## SYNOPSIS

Fabricates a company name.

## SYNTAX

```powershell
Get-FabricatedCompany [<CommonParameters>]
```

## DESCRIPTION

Let's face it, no real company wants to be associated with the likes of us.

So we wrote this cmdlet, which randomly generates a company name from three parts to create a realistic name.

The first part is a name, such as Arcane, the second is an industry, such as Training, the final part is a company type such as Incorporated.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedCompany
```

Get-FabricatedCompany returns data similar to the following example:


Property | Value
| ----- | ------ |
Company | Arcane Training Inc

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

String holding a company name.

## NOTES

Data Fabricator - Get-FabricatedCompany.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedCompanyRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
