---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version: https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCity.md
schema: 2.0.0
---

# New-FabricatedCityStateZipCodeRecord

## SYNOPSIS

Fabricate one or more records with city, state, and zip code data.

## SYNTAX

```powershell
New-FabricatedCityStateZipCodeRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [-Plus4] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet will genereate an object (or array of them) with combinations of randomly selected cities, states and zip codes.
Because these are randomly selected, you will wind up with odd results sometimes, such as placing Salt Lake City in Alabama, with a zip code somewhere in Michigan.
That's not only acceptable but desired, as this data is only supposed to be realistic looking, not actually real.
One additional field is the CityCode. 
This is the city run through the ConvertTo-CityCode cmdlet, and will produce a unique value (based on the data supplied with the module) that is suitable for use as a key.
This value is appended to the two letter state abbreviation to produce unqiue city/state keys.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedCityStateZipCodeRecord | Test-Pipe
```

New-FabricatedCityStateZipCodeRecord returns the following data.


Property | Value
| ----- | ------ |
City             | Chinook CDP
State            | AK
StateName        | Alaska
ZipCode          | 27264
CityStZipCode    | Chinook CDP, AK 27264
CityStateZipCode | Chinook CDP, Alaska 27264
CityCode         | AKCHINOOKCDP

### EXAMPLE 2

```powershell
New-FabricatedCityStateZipCodeRecord -RecordCount 5 | Test-Pipe
```

New-FabricatedCityStateZipCodeRecord returns 5 records with data similar to the previous example.

### EXAMPLE 3

```powershell
New-FabricatedCityStateZipCodeRecord -Plus4 | Test-Pipe
```

New-FabricatedCityStateZipCodeRecord returns the following data:


Property | Value
| ----- | ------ |
City             | Chinook CDP
State            | AK
StateName        | Alaska
ZipCode          | 27264
CityStZipCode    | Chinook CDP, AK 27264-3982
CityStateZipCode | Chinook CDP, Alaska 27264-3982
CityCode         | AKCHINOOKCDP

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

### -Plus4

Switch that will add a randomly generated plus 4 code to the returned zip code.
(See the documentation for Get-FabricatedZipCode for more info on plus 4 codes.)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: PlusFour

Required: False
Position: Named
Default value: False
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

Object (or array of objects) with the following properties.

Property | Description
| ----- | ------ |
City             | A randomly selected city.
State            | A randomly selected two character state code.
StateName        | The full name of the state for the corresponding state code.
ZipCode          | Randomly generated zip code.
CityStZipCode    | Full city, state abbreviation, and zip combined in a string, i.e. "Chelsea, AL 12345".
CityStateZipCode | City, full state name, and zip combined in a string, i.e. "Chelsea, Alabama 12345".
CityCode         | The city which has been processed using the ConvertTo-CityCode cmdlet. Allows the city to be used as a unique key.

## NOTES

Data Fabricator - New-FabricatedCityStateZipCodeRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[Get-FabricatedCity](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCity.md)

[Get-FabricatedState](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedState.md)

[Get-FabricatedZipCode](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedZipCode.md)

[New-FabricatedCityStateZipRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md)

[New-FabricatedCompanyRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md)

[New-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md)

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
