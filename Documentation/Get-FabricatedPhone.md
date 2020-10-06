# Get-FabricatedPhone

## SYNOPSIS

Fabricates a phone number for the CountryCode, defaulting to the US based format.

## SYNTAX

```powershell
Get-FabricatedPhone [[-CountryCode] <String>] [-NoFormatting] [<CommonParameters>]
```

## DESCRIPTION

We wouldn't want to use real phone numbers, telemarters are horrible!
They always seem to call at meal time.

This cmdlet generates random numbers to compose a phone number for the CountryCode parameter, to avoid those meal interrupting calls.

If no CountryCode is passed in, it will default to the US format of xxx-xxx-xxxx.

To suppress extra charcters like dashes, spaces, and so on from the phone number use the NoFormatting switch.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedPhone
```

Get-FabricatedPhone returns data similar to the following example:


Property | Value
| ----- | ------ |
Phone | 672-344-1425

### EXAMPLE 2

```powershell
Get-FabricatedPhone -NoFormatting
```

Get-FabricatedPhone returns data similar to the following example:


Property | Value
| ----- | ------ |
Phone | 6723441425

### EXAMPLE 3

```powershell
Get-FabricatedPhone -UK
```

Get-FabricatedPhone returns data similar to the following example:


Property | Value
| ----- | ------ |
Phone | (029) 6723 1425

### EXAMPLE 4

```powershell
Get-FabricatedPhone -UK -NoFormatting
```

Get-FabricatedPhone returns data similar to the following example:


Property | Value
| ----- | ------ |
Phone | 02967231425

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
