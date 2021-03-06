# Get-FabricatedAddressLine1

## SYNOPSIS

Fabricates an address typically used as the address line 1 in an address.

## SYNTAX

```powershell
Get-FabricatedAddressLine1 [<CommonParameters>]
```

## DESCRIPTION

Most people don't want to give out their addresses, heck even the help authors don't want you know where we live for fear you'll come throw eggs at our house.
So we created this cmdlet, which will fabricate fake addresses.

Note that addresses often consist of two lines, address 1 and address 2.
This will create a realistic but fake address suitable for address 1.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedAddressLine1
```

Get-FabricatedAddressLine1 returns data similar to the following example:


Property | Value
| ----- | ------ |
Address1 | 4964 Mackenzie Road

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

String with an address

## NOTES

Data Fabricator - Get-FabricatedAddressLine1.ps1

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
