---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md
schema: 2.0.0
---

# Get-FabricatedPostalCode

## SYNOPSIS

Fabrictes a postal code.

## SYNTAX

```powershell
Get-FabricatedPostalCode [[-CountryCode] <String>] [-Plus4] [<CommonParameters>]
```

## DESCRIPTION

This cmldet will generate a postal code in the format used by the country represented in the country code parameter. 
If no code is passed, it will default to a country code of US. 
In the US postal codes, known as Zip Codes, are five numbers indicating the area of mail service.
The US postal system also supports an additional four numbers known as the "Plus 4" system that provides additional accuracy.
By default, for US codes, this cmdlet will randomly generate a five digit zip code in 00000 format, using the switch it will append the additional plus 4 in 00000-0000 format.
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

### EXAMPLE 4

```powershell
Get-FabricatedPostalCode -CountryCode UK
```

Get-FabricatedPostalCode returns a string with the following data:


Property | Value
| ----- | ------ |
Postal Code | MV6Y 2BH

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
Note that this parameter is only valid when the country code is US, for other country codes it will be ignored.

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

A string with a generated postal code, matching the format for the country code used (US by defalt)

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
