---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md
schema: 2.0.0
---

# Get-FabricatedName

## SYNOPSIS

Fabricates names, first and last, from internal lists of over 20,000 names.

## SYNTAX

```powershell
Get-FabricatedName [-First] [-Last] [-FirstMiLast] [-FirstMiddleLast] [-LastFirst] [-LastFirstMi]
 [-LastFirstMiddle] [<CommonParameters>]
```

## DESCRIPTION

By default, this function will return a name in "First Last" format.
However, using the swticthes (documented below) you can change the output.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedName
```

Get-FabricatedName returns the following data:

John Sapien

### EXAMPLE 2

```powershell
Get-FabricatedName -First
```

Get-FabricatedName returns the following data:

Sherril

### EXAMPLE 3

```powershell
Get-FabricatedName -Last
```

Get-FabricatedName returns the following data:

Piercy

### EXAMPLE 4

```powershell
Get-FabricatedName -FirstMiLast
```

Get-FabricatedName returns the following data:

Gertie F.
Phillip

### EXAMPLE 5

```powershell
Get-FabricatedName -FirstMiddleLast
```

Get-FabricatedName returns the following data:

Loyce Coral Caldwell

### EXAMPLE 6

```powershell
Get-FabricatedName -LastFirst
```

Get-FabricatedName returns the following data:

Wixom, Eli

### EXAMPLE 7

```powershell
Get-FabricatedName -LastFirstMi
```

Get-FabricatedName returns the following data:

Tunnell, Evan E.

### EXAMPLE 8

```powershell
Get-FabricatedName -LastFirstMiddle
```

Get-FabricatedName returns the following data:

Boothe, Janiyah Lou

## PARAMETERS

### -FirstMiddleLast

Switch that will include a middle name: First Middle Last

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

### -FirstMiLast

Switch to have the name returned with a middle initial: First M Last

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

### -Last

Switch that will cause the function to only return a Last name: Last

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

### -LastFirst

Switch that returns the last name first: Last, First

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

### -LastFirstMi

Switch that returns the last name at the beginning, with first name and middle initial following: Last, First M

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

### -LastFirstMiddle

Switch that places the last name at the beginning, and includes the first and middle names: Last, First Middle

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

### -First

Switch that will cause the function to only return a First name: First

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

String containing a fabricated name.

## NOTES

Data Fabricator - Get-FabricatedName.ps1

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
