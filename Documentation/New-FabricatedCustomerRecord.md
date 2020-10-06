# New-FabricatedCustomerRecord

## SYNOPSIS

Fabricates one or more new customer records, and returns them as an array of objects (aka records).

## SYNTAX

```powershell
New-FabricatedCustomerRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [[-EMailDomain] <String>] [[-CountryCode] <String>] [<CommonParameters>]
```

## DESCRIPTION

Our lawyers have advised us not to use the names of real customers in our data, to avoid even more lawsuits or make their negative product reviews easy to find.
So we've created this cmdlet, which will generate one or more fake customer records for the country code passed in.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedCustomerRecord
```

New-FabricatedCustomerRecord returns data similar to the following example:


Property | Value
| ----- | ------ |
FirstName      | Johanna
MiddleName     | Shelley
LastName       | Papineau
FullName       | Johanna Shelley Papineau
CustomerID     | PA479424
EMail          | j.papineau@fakemail.com
HomePhone      | 441-583-1920
MobilePhone    | 305-376-0859
WorkPhone      | 790-880-0566
HomeAddress1   | 6252 Cedar Branch Street
HomeAddress2   |
HomeCity       | Whiting City
HomeState      | AK
HomePostalCode | 85714
WorkAddress1   | 1940 Ticonderoga Rd
WorkAddress2   |
WorkCity       | Pelham Manor Village
WorkState      | KS
WorkPostalCode | 94602
BirthDate      | 1982-03-23

### EXAMPLE 2

```powershell
New-FabricatedCustomerRecord -CountryCode UK
```

New-FabricatedCustomerRecord returns data similar to the following example:


Property | Value
| ----- | ------ |
FirstName      | Ilana
MiddleName     | Maria
LastName       | Brehm
FullName       | Ilana Maria Brehm
CustomerID     | BR832859
EMail          | i.brehm@fakemail.com
HomePhone      | (020) 6895 6647
MobilePhone    | (020) 9319 7122
WorkPhone      | (020) 2151 8310
HomeAddress1   | 5865 Hallmark Ave.
HomeAddress2   |
HomeCity       | Bangor
HomeState      | OX
HomePostalCode | NU8Q 9TQ
WorkAddress1   | 7144 Lennie Arnold Ln.
WorkAddress2   | Apt 7236
WorkCity       | Stirling
WorkState      | BD
WorkPostalCode | TL1S 4RM
BirthDate      | 1958-09-13

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

### -EMailDomain

By default the cmdlet will create customer records using fakemail.com as the final part of the email address.

You can override this, for example using your own company email, using this parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Fakemail.com
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

An array of 1 or more objects with the following structure.

Property | Description
| ----- | ------ |
FirstName      | Customers first name
MiddleName     | The middle name of the customer
LastName       | The last name of the customer
FullName       | The customers full name
CustomerID     | A generated customer ID for this customer
EMail          | Email Address
HomePhone      | The customers home phone
MobilePhone    | The customers mobile phone numer
WorkPhone      | The work phone number
HomeAddress1   | The first line of the home address
HomeAddress2   | The second line of the home address
HomeCity       | The city for the home address
HomeState      | The state code for the home address
HomePostalCode | The postal code for the home address
WorkAddress1   | The first line of the work adress
WorkAddress2   | The second line of the work address
WorkCity       | The city for the work address
WorkState      | The state code for the work address
WorkPostalCode | The postal code for the work address
BirthDate      | The birthdate of the customer

## NOTES

Data Fabricator - New-FabricatedCustomerRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[New-FabricatedNameRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedNameRecord.md)

[New-FabricatedCityStatePostalCodeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
