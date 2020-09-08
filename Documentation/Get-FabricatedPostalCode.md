---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md
schema: 2.0.0
---

# Get-FabricatedPostalCode

## SYNOPSIS

Fabrictes a US Zip Code in either 5 digit (the default) or the 5 Plus 4 format.

## SYNTAX

```powershell
Get-FabricatedPostalCode [[-CountryCode] <String>] [-Plus4] [<CommonParameters>]
```

## DESCRIPTION

In the US postal codes, known as Zip Codes, are five numbers indicating the area of mail service.
The postal system also supports an additional four numbers known as the "Plus 4" system that provides additional accuracy.
By default this cmdlet will randomly generate a five digit zip code in 00000 format, using the switch it will append the additional plus 4 in 00000-0000 format.
Note that these zip codes are randomly generated, and may or may not actually exist.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedPostalCode
```

Get-FabricatedPostalCode returns a string with the following data:


Property | Value
| ----- | ------ |
Zip Code | 12345

### EXAMPLE 2

```powershell
Get-FabricatedPostalCode -Plus4
```

Get-FabricatedPostalCode returns a string with the following data:


Property | Value
| ----- | ------ |
Zip Code | 12345-6789

### EXAMPLE 3

```powershell
Get-FabricatedPostalCode -PlusFour
```

Get-FabricatedPostalCode returns a string with the following data:


Property | Value
| ----- | ------ |
Zip Code | 12345-6789

## PARAMETERS

### -CountryCode

Country code.
If no code is supplied it defaults to the US.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: US
Accept pipeline input: False
Accept wildcard characters: False
```

### -Plus4

Switch that will add a randomly generated plus 4 code to the returned zip code.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: PlusFour

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

A string with the five digit zip code in 00000 format, or 00000-0000 if the Plus4 switch is used.

## NOTES

Data Fabricator - Get-FabricatedPostalCode.ps1

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

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
