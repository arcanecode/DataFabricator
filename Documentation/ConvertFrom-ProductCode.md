---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/ConvertTo-ProductCode.md
schema: 2.0.0
---

# ConvertFrom-ProductCode

## SYNOPSIS

Takes the product code and converts it back to the Clothing, Color and Size.

## SYNTAX

```powershell
ConvertFrom-ProductCode [[-ProductCode] <String>] [<CommonParameters>]
```

## DESCRIPTION

The product code is 9 characters, the first three point to the clothing, second three to color, and final three to size.
This function breaks them into the three codes then uses an internal lookup table to convert these back into the full clothing, color and size names.
These are then placed into an object with three properties, Clothing, Color, and Size, which is returned.

## EXAMPLES

### EXAMPLE 1

```powershell
ConvertFrom-ProductCode -ProductCode "GLOOCELAR"
```

Returns the following data:


Property | Value
| ----- | ------ |
Clothing | Gloves
Color    | Ocean Green
Size     | Large

## PARAMETERS

### -ProductCode

The 9 character product code.

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

This has no inputs

## OUTPUTS

A object with these properties.

Property | Description
| ----- | ------ |
Clothing | The type of clothing, shirt, pants, and so forth
Color    | Standard colors like red, yellow, blue
Size     | Standard sizes such as large, 1XL, 2XL and so on

## NOTES

Data Fabricator - ConvertFrom-ProductCode.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[ConvertTo-ProductCode](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/ConvertTo-ProductCode.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
