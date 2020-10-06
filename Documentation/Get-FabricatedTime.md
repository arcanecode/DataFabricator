# Get-FabricatedTime

## SYNOPSIS

Fabricates a random time of day.

## SYNTAX

```powershell
Get-FabricatedTime [-AMPM] [<CommonParameters>]
```

## DESCRIPTION

The clock is ticking, even for us.
To get a time, we need to generate a fake time, which this cmdlet handles.

It will generate a time of day, by default in HH:MM:SS 24 hour format.

Using a switch it can also return the time in 12 hour AM/PM format.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedTime
```

Get-FabricatedTime returns data similar to the following example:


Property | Value
| ----- | ------ |
Time | 22:35:41

### EXAMPLE 2

```powershell
Get-FabricatedTime -AMPM
```

Get-FabricatedTime returns data similar to the following example:


Property | Value
| ----- | ------ |
Time | 10:35:41 PM

## PARAMETERS

### -AMPM

Switch that will cause the time to be returned in 12 hour format with AM or PM at the end of the string, as opposed to the default of 24 hour format.

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

String with a fabricated time.

## NOTES

Data Fabricator - Get-FabricatedTime.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[Get-FabricatedDate](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedDate.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
