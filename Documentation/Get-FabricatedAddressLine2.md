---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md
schema: 2.0.0
---

# Get-FabricatedAddressLine2

## SYNOPSIS

Fabricates an address suitible for the second line in an address, such as an apartment number or office suite.

## SYNTAX

```powershell
Get-FabricatedAddressLine2 [[-Threshold] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Often, but not always, an address will contain a second line that will be an apartment number or office suite.
To account for the fact that an address2 line is not always used, this function calculates a percentage of the time to generate an address 2, by default 25%.
This means there is a 25% chance of returning an address2, the rest of the time it will return an empty value for address2.
Note this is calculated on each call to the function, it is not done across calls.
The default threshold can be overridden using the Threshold parameter.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedAddressLine2
```

Get-FabricatedAddressLine2 the following data:

Address2: Office 33

### EXAMPLE 2

```powershell
Get-FabricatedAddressLine2 -Threshold 50
```

Get-FabricatedAddressLine2 will have a 50% chance of returning data, such as:

Address2: Suite A

### EXAMPLE 3

```powershell
Get-FabricatedAddressLine2 -Threshold 100
```

Get-FabricatedAddressLine2 will always return an address2 value, such as:

Address2: Apartment 42

## PARAMETERS

### -Threshold

The percentage of the time to return a value for address2, by default it is set to 25.
To always return an address2 line, set the threshold to 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 25
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

String with a realistic address2 line

## NOTES

Data Fabricator - Get-FabricatedAddressLine2.ps1

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
