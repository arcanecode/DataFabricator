---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductTable.md
schema: 2.0.0
---

# New-FabricatedProductRecord

## SYNOPSIS

Fabricates one or more product records.

## SYNTAX

```powershell
New-FabricatedProductRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

This will generate one or more product records with the output type as described in the output section below.
Note this cmdlet and New-FabricatedProductTable return the same output type, so could be used interchangeably.
The main difference is this cmdlet randomly generates product data, and thus will be a subset of the product table, whereas New-FabricatedProductTable returns all possible products.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedProductRecord
```

This is a subset of the data that is returned:


Property | Value
| ----- | ------ |
ProductCode | COAMAUEXT
Clothing | Coat
Color | Mauve
Size | Extra large
ProductCode | COAMAU2XL
Clothing | Coat
Color | Mauve
Size | 2XL
ProductCode | COAMAU3XL
Clothing | Coat
Color | Mauve
Size | 3XL
ProductCode | COAMAU4XL
Clothing | Coat
Color | Mauve
Size | 4XL

## PARAMETERS

### -MaxDuplicateCountBeforeError

This cmdlet checks for duplicates so they are removed from the final output.
By default, once the cmdlet has generated 50 duplicates it will throw an error and exit before all the records have been generated (although it will return what it has generated to that point).
It is possible in some cases to request more records than it is possible to create based on the internal data.
To keep from falling into an infinite loop this mechanism will exit and let the user know what the issue is.
Normally you won't need to override this, but it is possible should you feel the need.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordCount

The number of records you want returned from this cmdlet.
The default is 1.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

Returns an array with objects that have the following properties.

Property | Description
| ----- | ------ |
ProductCode | The 9 character product code to uniquely identify this product.
Clothing | The type of clothing.
Color | The color of the clothing.
Size | The size of the clothing.

## NOTES

Data Fabricator - New-FabricatedProductRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedProductTable](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductTable.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
