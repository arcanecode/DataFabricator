# ConvertTo-CityCode

## SYNOPSIS

Taks a city name and creates a city code

## SYNTAX

```powershell
ConvertTo-CityCode [[-City] <String>] [<CommonParameters>]
```

## DESCRIPTION

The city code is combined with the two character state abbreviaion to create the city state code.

This is used as a key in several functions.

## EXAMPLES

### EXAMPLE 1

```powershell
ConvertTo-CityCode -City "Aaronsburg CDP"
```

ConvertTo-CityCode returns data similar to the following example:


Property | Value
| ----- | ------ |
CityCode | AARONSBURGCDP

## PARAMETERS

### -City

The name of the city to create a city code for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

String with the CityCode

## NOTES

Data Fabricator - ConvertTo-CityCode.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedInventoryRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md)

[New-FabricatedCityStatePostalCodeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
