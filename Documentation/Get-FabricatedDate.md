# Get-FabricatedDate

## SYNOPSIS

Fabricates a date and (optionally) a time.

## SYNTAX

```powershell
Get-FabricatedDate [[-FromYear] <Int32>] [[-ThruYear] <Int32>] [[-RelativeFromYear] <Int32>]
 [[-RelativeThruYear] <Int32>] [-AsDateTime] [-FormatMDY] [-FormatDMY] [-FabricateTime] [<CommonParameters>]
```

## DESCRIPTION

This flexible cmdlet has the ability generate dates in either string or datetime format.

By default it will uses ranges in the last 50 years backwards from the current year, however these are easily overridden using the parameters (see each parameter for more information).

The default format for the returned string is YYYY-MM-DD (only a date, no time), unless overridden.

Using switches (see below) you can change the format a well as include a fabricated time.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-FabricatedDate
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 1991-12-23

### EXAMPLE 2

```powershell
Get-FabricatedDate -FromYear 1930
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 1936-02-27

### EXAMPLE 3

```powershell
Get-FabricatedDate -FromYear 1000 -ThruYear 1200
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 1042-02-27

### EXAMPLE 4

```powershell
Get-FabricatedDate -RelativeFromYear 1000
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 1764-05-21

### EXAMPLE 5

```powershell
Get-FabricatedDate -RelativeThruYear 21
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 1984-02-07

### EXAMPLE 6

```powershell
Get-FabricatedDate -AsDateTime
```

Get-FabricatedDate returns the following datetime datatype:


Property | Value
| ----- | ------ |
Date | Tuesday, August 18, 1981 12:00:00 AM

### EXAMPLE 7

```powershell
Get-FabricatedDate -AsDateTime -FabricateTime
```

Get-FabricatedDate returns the following datetime datatype:


Property | Value
| ----- | ------ |
Date | Tuesday, June 14, 2011 4:18:26 AM

### EXAMPLE 8

```powershell
Get-FabricatedDate -FormatMDY
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 10-28-1998

### EXAMPLE 9

```powershell
Get-FabricatedDate -FormatDMY
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 22-02-1975

### EXAMPLE 10

```powershell
Get-FabricatedDate -FabricateTime
```

Get-FabricatedDate returns the following string:


Property | Value
| ----- | ------ |
Date | 1992-05-28 07:27:33

## PARAMETERS

### -AsDateTime

Switch that will return the fabricated date as a datetime datatype instead of a string.

Note if you do not also use the FabricatedTime switch, the default time will be midnight (12:00:00 AM).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FabricateTime

Switch that will fabricate a time of the day instead of using the default of midnight (12:00:00 AM).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatDMY

Swtich that will return the date in DD-MM-YYYY format instead of the default YYYY-MM-DD format.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatMDY

Switch that will return the date in MM-DD-YYYY format instead of the default YYYY-MM-DD format.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromYear

The year to begin generating dates from.
If no date is passed it, by default it will go back 50 years from the current year.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: -9999
Accept pipeline input: False
Accept wildcard characters: False
```

### -RelativeFromYear

Rather than hard coding a year, you can use this parameter to create an offset from the current year as the starting year.
For example, if you pass in 100, and the current year is 2020, the starting year will be 1920.
When New Years hits and we get to 2021, the starting year will become 2021.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: -9999
Accept pipeline input: False
Accept wildcard characters: False
```

### -RelativeThruYear

Just like the RelativeFromYear, this parameter can be used to set a relative end year for date generation.

This can be especially useful for generating birthdays for employees.

Many companies require people to be a minimum age, for example 21.

Using 21 for a relative thru year would assure all dates fabricated would be at least 21 years ago.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: -9999
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThruYear

The final year to use for date generation.
If no year is supplied it will default to the current year.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: -9999
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has no inputs.

## OUTPUTS

Either a string or a datetime datatype with a fabricated date.

## NOTES

Data Fabricator - Get-FabricatedDate.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedCustomerRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md)

[New-FabricatedEmployeeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md)

[New-FabricatedSalesRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedSalesRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
