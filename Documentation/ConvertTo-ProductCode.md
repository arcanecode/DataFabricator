# ConvertTo-ProductCode

## SYNOPSIS

Creates a product code from the clothing, color and size.

## SYNTAX

```powershell
ConvertTo-ProductCode [[-Clothing] <String>] [[-Color] <String>] [[-Size] <String>] [<CommonParameters>]
```

## DESCRIPTION

The product code consists of the first three characters from the clothing, color, and size all upper cased.

Based on the sample data included with this module this will create a unique value that is used as a key in several places.

## EXAMPLES

### EXAMPLE 1

```powershell
ConvertTo-ProductCode -Clothing 'Gloves' -Color 'Ocean Green' -Size 'Large'
```

ConvertTo-ProductCode returns data similar to the following example:


Property | Value
| ----- | ------ |
ProductCode | GLOOCELAR

## PARAMETERS

### -Clothing

A string with the name of the clothing.

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

### -Color

A string with the color of the product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Size

A string with the size of the product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

String with the 9 character product code.

## NOTES

Data Fabricator - ConvertTo-ProductCode.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedProductRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductRecord.md)

[New-FabricatedProductTable](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductTable.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
