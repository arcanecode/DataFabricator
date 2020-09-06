---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md
schema: 2.0.0
---

# Get-FabricatedBin

## SYNOPSIS

Fabricates a location in a warehouse, referred to as a Bin number.

## SYNTAX

```powershell
Get-FabricatedBin [<CommonParameters>]
```

## DESCRIPTION

Many warehouses follow a typical physical layout to indicate where a product is stored.
First is one to two letters, indicating what row a product can be found on.
Each row contains racks with bins for storing products, typically on pallets.
Bins often use three numbers, the first number indicating a level (1, 2, or 3) like a floor in a building.
The second two indicate how far down the row to go, for example 33 being the 33rd bin.
This routine follows this pattern, creating two letters for a row and three numbers for the location on the row.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedBin
```

Get-FabricatedBin returns the following data:

IW328

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

String holding a bin number in the format AA123

## NOTES

Data Fabricator - Get-FabricatedBin.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedInventoryRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
