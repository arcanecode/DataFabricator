# Get-FabricatedTaxpayerID

## SYNOPSIS

Fabricates a TaxpayerID (taxpayer identification number).
In the US this would be the Social Security Number.

## SYNTAX

```powershell
Get-FabricatedTaxpayerID [[-CountryCode] <String>] [-NoFormatting] [<CommonParameters>]
```

## DESCRIPTION

Taxes are a terrible thing, but we all have to pay them.
And to pay them we have to have a tax payer ID.

Of course we don't want to use real ones (unless you'd be open to paying our outrageously high tax bill, he said hopefuly?).

To avoid this, we have this function which will generate a taxpayer ID Number (abbreviated TaxpayerID) for the specified CountryCode.

If no CountryCode is passed in, the cmdlet defaults to the US, the social security number in xxx-xx-xxxx format.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedTaxpayerID
```

Get-FabricatedTaxpayerID returns data similar to the following example:


Property | Value
| ----- | ------ |
TaxpayerID | 082-12-7296

### EXAMPLE 2

```powershell
Get-FabricatedTaxpayerID -NoFormatting
```

Get-FabricatedTaxpayerID returns the following data (for the default CountryCode):


Property | Value
| ----- | ------ |
TaxpayerID | 082127296

### EXAMPLE 3

```powershell
Get-FabricatedTaxpayerID -CountryCode UK
```

Get-FabricatedTaxpayerID returns data similar to the following example:


Property | Value
| ----- | ------ |
TaxpayerID | 01234 56789

### EXAMPLE 4

```powershell
Get-FabricatedTaxpayerID -CountryCode UK -NoFormatting
```

Get-FabricatedTaxpayerID returns data similar to the following example:


Property | Value
| ----- | ------ |
TaxpayerID | 0123456789

## PARAMETERS

### -CountryCode

Enumerated country code.
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

### -NoFormatting

Switch that will prevent formatting, such as dashes or spaces, from being included in the output.

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

String with the fabricated TaxpayerID.

## NOTES

Data Fabricator - Get-FabricatedTaxpayerID.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
