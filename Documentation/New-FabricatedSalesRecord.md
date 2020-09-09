---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedDate.md
schema: 2.0.0
---

# New-FabricatedSalesRecord

## SYNOPSIS

Fabricates sales data based on the supplied mix of employees, products, customers, and employees.

## SYNTAX

```powershell
New-FabricatedSalesRecord [[-RecordCount] <Int32>] [[-Employees] <Array>] [[-Products] <Array>]
 [[-Customers] <Array>] [[-MinQuantityPerSale] <Int32>] [[-MaxQuantityPerSale] <Int32>]
 [[-MinPricePerProduct] <Single>] [[-MaxPricePerProduct] <Single>] [[-YearsToFabricateSalesFor] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

Like our company, yours is probably embarrassed to admit how little they actually sell.
To avoid this, you'll want to fabricate some fake sales data.

Sales data answers the questions of what piece of cheap merchandise was sold (products), 
which employee actually surprised their manager by selling something (employees),
who was foolish or gullible enough to buy our stuff (customers),
and how many did this poor person get stuck with (quantity),
not to mention how much money did we make which is important to know because we've got another boat payment coming due (total sale).

This exciting cmdlet takes the output from other cmdlets and combines them together to fabricate sales data.

## EXAMPLES

### EXAMPLE 1

```powershell
$employees = New-FabricatedEmployeeRecord -RecordCount 10
$products = New-FabricatedProductRecord -RecordCount 100
$customers = New-FabricatedCustomerRecord -RecordCount 20
$sales = New-FabricatedSalesRecord -Employees $employees -Products $products -Customers $customers
$sales
```

New-FabricatedSalesRecord returns data similar to the following example:


Property | Value
| ----- | ------ |
SalesDate       | 8/17/2019 12:00:00 AM
ProductCode     | SHIMAUEXT
EmployeeID      | CH5970
CustomerID      | SH0286
Quantity        | 37
PricePerProduct | 5.47
TotalSale       | 202.39

### EXAMPLE 2

```powershell
$employees = New-FabricatedEmployeeRecord -RecordCount 10
$products = New-FabricatedProductRecord -RecordCount 100
$customers = New-FabricatedCustomerRecord -RecordCount 20
# Note the line continuation character at the end
$sales = New-FabricatedSalesRecord -Employees $employees `
                                   -Products $products `
                                   -Customers $customers `
                                   -RecordCount 5
$sales
```

New-FabricatedSalesRecord returns 5 rows of data similar to the data in the previous example

### EXAMPLE 3

```powershell
$employees = New-FabricatedEmployeeRecord -RecordCount 10
$products = New-FabricatedProductRecord -RecordCount 100
$customers = New-FabricatedCustomerRecord -RecordCount 20
# Note the line continuation character at the end
$sales = New-FabricatedSalesRecord -Employees $employees `
                                   -Products $products `
                                   -Customers $customers `
                                   -MinQuantityPerSale 100 `
                                   -MaxQuantityPerSale 1000 `
                                   -MinPricePerProduct 100.00 `
                                   -MaxPricePerProduct 200.00 
$sales
```

New-FabricatedSalesRecord returns data similar to the following example:


Property | Value
| ----- | ------ |
SalesDate       | 9/3/2019 12:00:00 AM
ProductCode     | MENGRE4XL
EmployeeID      | BL3621
CustomerID      | CH5970
Quantity        | 534
PricePerProduct | 116.93
TotalSale       | 62440.62

## PARAMETERS

### -Customers

An array of customer objects as output from the New-FabricatedCustomerRecord cmdlet.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Employees

An array of employee objects as output from the New-FabricatedEmployeeRecord cmdlet.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxPricePerProduct

The maximum price for a single piece of product.
The default is 99.99. 
Note prices are not in any monetary unit, so you can pretend they are dollars, pounds, euros, Minecraft emeralds, or whatever you think you can cram into your wallet.

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 99.99
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxQuantityPerSale

The maximum number of items that can be sold for a single transaction.
The defalt is 99.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 99
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinPricePerProduct

The minimum price for a single piece of product.
The default is 1.00. 
Note prices are not in any monetary unit, so you can pretend they are dollars, pounds, euros, Martian gliptars, or whatever you fancy.

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinQuantityPerSale

The minimum number of items to sell in a single transaction.
The default is 1.

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

### -Products

An array of product objects as output from either the New-FabricatedProductRecord cmdlet or the New-FabricatedProductTable cmdlet.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
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

### -YearsToFabricateSalesFor

How many years to fabricate data for, starting with the current year and going back in time.
The default is 1.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

This cmdlet outputs an array of objects, each with the following properties:

Property | Description
| ----- | ------ |
SalesDate       | The date and time of the sale (in datetime format)
ProductCode     | A unique identifier for this product
EmployeeID      | A unique identifier for this employee
CustomerID      | A unique identifier for this customer
Quantity        | The number of items sold
PricePerProduct | The price per product
TotalSale       | Quantity * PricePerProduct (we did the math so you don't have to!)

## NOTES

Data Fabricator - New-FabricatedSalesRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[Get-FabricatedDate](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedDate.md)

[New-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md)

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[New-FabricatedProductRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductRecord.md)

[New-FabricatedProductTable](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedProductTable.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
