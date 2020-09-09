---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCity.md
schema: 2.0.0
---

# Test-CountryCode

## SYNOPSIS

Tests the country code to see if it is valid.

## SYNTAX

```powershell
Test-CountryCode [[-CountryCode] <Object>] [<CommonParameters>]
```

## DESCRIPTION

People suck at following directions. 
Even though we provided an easy way to return a list of valid country codes, the Get-CountryCodes cmdlet, we both know someone is going to try something bogus just to see if it works.
So we had to create this cmdlet, which tests the country code.
If it is valid it returns true.
If not, it returns false and outputs a warning message about it being invalid.
In most cmdlets if the code is invalid it then uses the default code of US and continues processing.

## EXAMPLES

### EXAMPLE 1

```powershell
Test-CountryCode -CountryCode 'US'
```

Test-CountryCode returns data similar to the following example:

True

### EXAMPLE 2

```powershell
Test-CountryCode -CountryCode 'Mars'
```

Test-CountryCode returns data similar to the following example:

False

## PARAMETERS

### -CountryCode

The country code being tested.

```yaml
Type: Object
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

This cmdlet has no inputs.

## OUTPUTS

The cmdlet returns either true or false

## NOTES

Data Fabricator - Test-CountryCode.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[Get-FabricatedCity](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCity.md)

[Get-FabricatedPhone](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPhone.md)

[Get-FabricatedPostalCode](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPostalCode.md)

[Get-FabricatedState](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedState.md)

[Get-FabricatedTaxpayerID](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedTaxpayerID.md)

[Get-StateName](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-StateName.md)

[Get-FabricatedCityStatePostalCodeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCityStatePostalCodeRecord.md)

[Get-FabricatedCompanyRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCompanyRecord.md)

[Get-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCustomerRecord.md)

[Get-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedEmployeeRecord.md)

[Get-FabricatedInventoryRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedInventoryRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
