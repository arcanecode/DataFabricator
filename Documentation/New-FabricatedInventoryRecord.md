---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md
schema: 2.0.0
---

# New-FabricatedInventoryRecord

## SYNOPSIS

Fabricates a new inventory record.

## SYNTAX

```powershell
New-FabricatedInventoryRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [[-WarehouseCode] <String>] [[-CountryCode] <String>] [[-MinQuantity] <Int32>] [[-MaxQuantity] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

Let's face it, your company probably doesn't want to admit to how much junk is still in the warehouse that they can't sell.

In order to avoid yet another negative quarter on the stock market, you can use this cmdlet to create one or more rows of fake but realistic inventory data. 
This contains properties such as the product, warehouse, bin, and quantity.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedInventoryRecord
```

New-FabricatedInventoryRecord returned the following data:


Property | Value
| ----- | ------ |
ProductCode      | HATRED6XL
WarehouseCode    | MIMANLEYHOTSPRINGSCDP
Bin              | ZL021
WarehouseBinCode | MIMANLEYHOTSPRINGSCDPZL021
Quantity         | 661

### EXAMPLE 2

```powershell
New-FabricatedInventoryRecord -MinQuantity 1000 -MaxQuantity 2000
```

New-FabricatedInventoryRecord returned the following data:


Property | Value
| ----- | ------ |
ProductCode      | SLABLU6XL
WarehouseCode    | ARSHAVERLAKECDP
Bin              | HL092
WarehouseBinCode | ARSHAVERLAKECDPHL092
Quantity         | 1227

### EXAMPLE 3

```powershell
New-FabricatedInventoryRecord -CountryCode UK
```

New-FabricatedInventoryRecord returned the following data:


Property | Value
| ----- | ------ |
ProductCode      | JEAWHILAR
WarehouseCode    | BRDURHAM
Bin              | WO134
WarehouseBinCode | BRDURHAMWO134
Quantity         | 887

### EXAMPLE 4

```powershell
New-FabricatedInventoryRecord -WarehouseCode 'NCMAUCKPORTTOWN'
```

New-FabricatedInventoryRecord returned the following data:


Property | Value
| ----- | ------ |
ProductCode      | PANREDSMA
WarehouseCode    | NCMAUCKPORTTOWN
Bin              | TM160
WarehouseBinCode | NCMAUCKPORTTOWNTM160
Quantity         | 647

## PARAMETERS

### -CountryCode

Country code.
If no code is supplied it defaults to the US.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: US
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -MaxQuantity

The maximum quantity to generate inside a bin within the warehouse.
This defaults to 999 if no value is passed in.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 999
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinQuantity

The minimum quantity to generate inside a bin within the warehouse.
This defaults to 1 if no value is passed in.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 1
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

### -WarehouseCode

A code which represents the warehouse to put the inventory. 
If not passed in, then warehouse values are generated for each product. 
By passing in a warehouse code all inventory will be generated for a single warehouse.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: X
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

This cmdlet returns one or more objects with the following properties:

Property | Description
| ----- | ------ |
ProductCode       | Unique identifier for the product
WarehouseCode     | A code which uniquely identifies a warehouse
Bin               | The bin number where a product is located within a warehouse
WarehouseBinCode  | A code which combines the warehouse code and bin to form a unique identifier for a location
Quantity          | How many items are in this bin

## NOTES

Data Fabricator - New-FabricatedInventoryRecord.ps1

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
