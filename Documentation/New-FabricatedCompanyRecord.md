---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipCodeRecord.md
schema: 2.0.0
---

# New-FabricatedCompanyRecord

## SYNOPSIS

Fabricates a new company and returns it as an object (aka record)

## SYNTAX

```powershell
New-FabricatedCompanyRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet will create a new object (or objects) that have properties tha a company would have.
Company name, address, contact and more (see the Outputs section for full details.)
This makes it easy to generate one or more companies for you to do business with.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedCompanyRecord
```

New-FabricatedCompanyRecord returns the following data:


Property | Value
| ----- | ------ |
Name            | Transformative Products Corp
Address1        | 762 Connie Hwy
Address2        |
City            | West Columbia City
State           | AL
Zip             | 48310
ContactName     | Mikala Mundy
ContactPhone    | 342-056-6296
ContactEMail    | m.mundy@transformativeproductscorp.com
ContactJobTitle | Transport Driver

### EXAMPLE 2

```powershell
New-FabricatedCompanyRecord -RecordCount 10
```

In this example, New-FabricatedCompanyRecord will return 10 rows of fabricated data, each row with output similar to the example above.

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

One or more objects with the following properties.

Property | Description
| ----- | ------ |
Name            | The fabricated name of the company
Address1        | The fictional address line 1 for the company
Address2        | The fictional address line 2 for the company (might be empty)
City            | A randomly selected City
State           | A randomly selected state
Zip             | A fabricated Zip code
ContactName     | A fabricated persons name in "First Last" format
ContactPhone    | A fake phone number for the company
ContactEMail    | An email address generated from the name and company, such as f.last@companyname.com
ContactJobTitle | A randomly selected job title of the company contact

## NOTES

Data Fabricator - New-FabricatedCompanyRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedCityStateZipCodeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipCodeRecord.md)

[New-FabricatedNameRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedNameRecord.md)

[Get-FabricatedAddressLine1](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine1.md)

[Get-FabricatedAddressLine2](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine2.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
