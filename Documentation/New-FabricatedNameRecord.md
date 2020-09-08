---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedName.md
schema: 2.0.0
---

# New-FabricatedNameRecord

## SYNOPSIS

Fabricates a name record complete with all variations

## SYNTAX

```powershell
New-FabricatedNameRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

Where Get-FabricatedName returns a variation with a name based on a switch, this cmdlet will return all variations of a name in one concise record.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedNameRecord
```

New-FabricatedNameRecord returns an object with the following data:


Property | Value
| ----- | ------ |
First           | "Eliana"
Middle          | "Corey"
MiddleInitial   | "C"
Last            | "Moore"
FirstLast       | "Eliana Moore"
FirstMiLast     | "Eliana C.
Moore"
FirstMiddleLast | "Eliana Corey Moore"
LastFirst       | "Moore, Eliana"
LastFirstMi     | "Moore, Eliana C."
LastFirstMiddle | "Moore, Eliana Corey"
EmailName       | "e.moore"
NameCode        | "MOORE_ELIANA_COREY"

### EXAMPLE 2

```powershell
New-FabricatedNameRecord -RecordCount 5
```

New-FabricatedNameRecord returns 5 records with output similar to the previous example.

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

Array of objects with the following properties:

Property | Description
| ----- | ------ |
First           | The first name
Middle          | Middle Name
MiddleInitial   | First letter of the middle name
Last            | Last Name
FirstLast       | The full name in the format "John Doe"
FirstMiLast     | First and last with middle initial, "John X. Doe"
FirstMiddleLast | First, middle and last name, "John Xavier Doe"
LastFirst       | Name in reverse format, "Doe, John"
LastFirstMi     | Name in reverse format ending with the middle initial, "Doe, John X."
LastFirstMiddle | Name in reverse format with the full middle name, "Doe, John Xavier"
EmailName       | The name suitible for the opening part of an email address, "j.doe"
NameCode        | This is the name converted to uppercase with underscores, useful for a key. "DOE_JOHN_XAVIER"

## NOTES

Data Fabricator - New-FabricatedNameRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[Get-FabricatedName](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedName.md)

[New-FabricatedCompanyRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md)

[New-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md)

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
