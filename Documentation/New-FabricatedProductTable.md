# New-FabricatedProductTable

## SYNOPSIS

Fabricate a table (a collection of product objects) with all possible combinations of products.

## SYNTAX

```powershell
New-FabricatedProductTable [<CommonParameters>]
```

## DESCRIPTION

Products?
You want products?
Well we got your products right here!
This cmdlet will return a collection of all possible combinations of product codes that are contained in the included sample dataset.
Note this cmdlet and New-FabricatedProductRecord both return the same output type, so they can be used interchangeably.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedProductTable
```

This is a subset of the data that is returned:


Property | Value
| ----- | ------ |
ProductCode | COAMAUEXT
Clothing    | Coat
Color       | Mauve
Size        | Extra large
ProductCode | COAMAU2XL
Clothing    | Coat
Color       | Mauve
Size        | 2XL
ProductCode | COAMAU3XL
Clothing    | Coat
Color       | Mauve
Size        | 3XL
ProductCode | COAMAU4XL
Clothing    | Coat
Color       | Mauve
Size        | 4XL

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

Returns an array with objects that have the following properties.

Property | Description
| ----- | ------ |
ProductCode | The 9 character product code to uniquely identify this product.
Clothing    | The type of clothing, shirt, pants and so forth
Color       | The color of the clothing, such as red, green, or blue
Size        | The size of the clothing, for example medium, large, 1XL, 2XL

## NOTES

Data Fabricator - New-FabricatedProductTable.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedProductRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
