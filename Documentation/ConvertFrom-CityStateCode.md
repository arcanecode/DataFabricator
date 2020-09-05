---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/ConvertFrom-CityStateCode.md
schema: 2.0.0
---

# ConvertFrom-CityStateCode

## SYNOPSIS

Converts a CityState code back to a city and state

## SYNTAX

```powershell
ConvertFrom-CityStateCode [-CityStateCode] <String> [<CommonParameters>]
```

## DESCRIPTION

Takes a CityState code (the city code with the two character state abbreviation on front) and deconstructs it, converting it back to the city and state.

## EXAMPLES

### EXAMPLE 1

```powershell
ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP"
```

ConvertFrom-CityStateCode returns the following data:

City: Aaronsburg CDP

State: AL

## PARAMETERS

### -CityStateCode

The code holding the state and city code

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This has no inputs

## OUTPUTS

An object array with two properties, the City and State.

## NOTES

Data Fabricator - ConvertFrom-CityStateCode

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[ConvertFrom-CityStateCode](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/ConvertFrom-CityStateCode.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
