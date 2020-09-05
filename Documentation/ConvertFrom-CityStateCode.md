---
external help file: DataFabricator-help.xml
Module Name: DataFabricator
online version:
schema: 2.0.0
---

# ConvertFrom-CityStateCode

## SYNOPSIS
ConvertFrom-CityStateCode - Converts a CityState code back to a city and state

## SYNTAX

```
ConvertFrom-CityStateCode [[-CityStateCode] <String>] [<CommonParameters>]
```

## DESCRIPTION
Takes a City State Code (the city code with the two character state abbreviation on front) and deconstructs it, converting it back to the city and state.

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP"
```

Returns:

City           State
----           -----
Aaronsburg CDP AL

## PARAMETERS

### -CityStateCode
The code holding the state and city code

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### There are no inputs for this cmdlet
## OUTPUTS

### An object with two properties, the City and State.
### class City
### {
###   [string] $City
###   [string] $State
### }
## NOTES

## RELATED LINKS

[arcanecode.gallery]()

