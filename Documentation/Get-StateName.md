# Get-StateName

## SYNOPSIS

Converts the state abbreviation to the full state name.

## SYNTAX

```powershell
Get-StateName [[-StateAbbr] <String>] [[-CountryCode] <String>] [<CommonParameters>]
```

## DESCRIPTION

State abbreviations can be confusing, I mean is AL Alabama or Alaska?
Who has time to remember stuff like that.

To avoid confusion, this cmdlet takes the passed in the two character state abbreviation, and expands it to the full state name.

The country code is also needed to know which set of state tables to use (US, UK, etc).

## EXAMPLES

### EXAMPLE 1

```powershell
Get-StateName -StateAbbr 'AL' -CountryCode 'US'
```

returns data similar to the following example:


Property | Value
| ----- | ------ |
StateName | Alabama

### EXAMPLE 2

```powershell
Get-StateName -StateAbbr 'CA' -CountryCode 'UK'
```

returns data similar to the following example:


Property | Value
| ----- | ------ |
StateName | Cambridgeshire

## PARAMETERS

### -CountryCode

Country code.
If no code is supplied it defaults to the US.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: US
Accept pipeline input: False
Accept wildcard characters: False
```

### -StateAbbr

The two character state abbreviation.

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

This cmdlet has no inputs.

## OUTPUTS

String with the expanded state name. It will be empty if the passed in state abbreviation is not found.

## NOTES

Data Fabricator - Get-StateName.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[CMDLET-HERE](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
