---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md
schema: 2.0.0
---

# Get-FabricatedState

## SYNOPSIS

Fabricates a US state by randomly picking it from a list of states.

## SYNTAX

```powershell
Get-FabricatedState [-FullName] [<CommonParameters>]
```

## DESCRIPTION

Will randomly select a state and returns the two character code for that state.
Alternativley it can also return the full name of a state by using the FullName switch.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedState
```

Get-FabricatedState returns the following data:


Property | Value
| ----- | ------ |
State | AL

### EXAMPLE 2

```powershell
Get-FabricatedState -FullName
```

Get-FabricatedState returns the following data:


Property | Value
| ----- | ------ |
State | Alabama

## PARAMETERS

### -FullName

Switch that will return the full name of a state instead of the two character state abbreviation.

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

String with a randomly selected US state.

## NOTES

Data Fabricator - Get-FabricatedState.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedCityStateZipRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md)

[New-FabricatedCompanyRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md)

[New-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md)

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[New-FabricatedInventoryRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
