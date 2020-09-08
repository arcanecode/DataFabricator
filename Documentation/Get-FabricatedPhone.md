---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md
schema: 2.0.0
---

# Get-FabricatedPhone

## SYNOPSIS

Fabricates a phone number in xxx-xxx-xxxx (US Based) format.

## SYNTAX

```powershell
Get-FabricatedPhone [-NoDashes] [<CommonParameters>]
```

## DESCRIPTION

Generates three sets of random numbers and combines them to form a phone number.
By default the three sections are separated by dashes, however using a swtich the dash can be excluded from the output.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedPhone
```

Get-FabricatedPhone returns the following data:


Property | Value
| ----- | ------ |
Phone | 672-344-1425

### EXAMPLE 2

```powershell
Get-FabricatedPhone -NoDashes
```

Get-FabricatedPhone returns the following data:


Property | Value
| ----- | ------ |
Phone | 6723441425

## PARAMETERS

### -NoDashes

Switch that prevents dashses from being included in the returned phone number.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

String containing the fabricated phone number.

## NOTES

Data Fabricator - Get-FabricatedPhone.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedCompanyRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md)

[New-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md)

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
