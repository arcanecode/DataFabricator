---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md
schema: 2.0.0
---

# Get-FabricatedTaxpayerID

## SYNOPSIS

Fabricates a TaxpayerID (Social Security Number), a taxpayer identification number used in the US.

## SYNTAX

```powershell
Get-FabricatedTaxpayerID [-NoDashes] [<CommonParameters>]
```powershell

## DESCRIPTION

Will generate a US based taxpayer Social Security Number (abbreviated TaxpayerID) in the format xxx-xx-xxxx.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedTaxpayerID
```powershell

Get-FabricatedTaxpayerID returns the following data:



Property | Value
| ----- | ------ |
Property | Value
| ----- | ------ |
TaxpayerID | 082-12-7296

### EXAMPLE 2

```powershell
Get-FabricatedTaxpayerID -NoDashes
```powershell

Get-FabricatedTaxpayerID returns the following data:


Property | Value
| ----- | ------ |
TaxpayerID | 082127296

## PARAMETERS

### -NoDashes

Switch that will prevent dashes from being included in the output.

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
