# New-FabricatedEmployeeRecord

## SYNOPSIS

Fabricates one or more new employee records, and returns them as an array of objects (aka records).

## SYNTAX

```powershell
New-FabricatedEmployeeRecord [[-RecordCount] <Int32>] [[-MaxDuplicateCountBeforeError] <Int32>]
 [[-EMailDomain] <String>] [[-CountryCode] <String>] [<CommonParameters>]
```

## DESCRIPTION

If your company is like mine, the employees are far too embarrased to admit working there.

In order not to drive employee morale even lower than it is, you can use this cmdlet to fabricate the data to create a fake employee record, with properties as defined in the output area.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FabricatedEmployeeRecord
```

New-FabricatedEmployeeRecord returns data similar to the following example:


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
HomeAddress1   | 5865 Hallmark Ave
HomeAddress2   |
HomeCity       | Bangor
HomeState      | OX
HomePostalCode | NU8Q 9TQ
WorkAddress1   | 7144 Lennie Arnold Ln
WorkAddress2   | Apt 7236
WorkCity       | Stirling
WorkState      | BD
WorkPostalCode | TL1S 4RM
BirthDate      | 1958-09-13

### EXAMPLE 2

```powershell
New-FabricatedEmployeeRecord -RecordCount 5
```

New-FabricatedEmployeeRecord returns data similar to the following example:

The cmdlet produces five rows of data similar to the previous example.

### EXAMPLE 3

```powershell
New-FabricatedEmployeeRecord -CountryCode UK
```

New-FabricatedEmployeeRecord returns data similar to the following example:


Property | Value
| ----- | ------ |
FirstName      | Savannah
MiddleName     | Kristy
LastName       | Capehart
FullName       | Savannah Kristy Capehart
TaxpayerID     | 74097 67643
EmployeeID     | CA7643
EMail          | s.capehart@fakemail.com
HomePhone      | (020) 5482 0235
MobilePhone    | (020) 5748 0412
WorkPhone      | (020) 3252 0034
HomeAddress1   | 2086 Ethel Cooper Ave.
HomeAddress2   |
HomeCity       | Dundee
HomeState      | DV
HomePostalCode | RH2I 8DP
WorkAddress1   | 1860 H.T.
Matthews Circle
WorkAddress2   | Apartment 7467
WorkCity       | Truro
WorkState      | LA
WorkPostalCode | GJ2J 8QG
BirthDate      | 2000-10-19
HireDate       | 2011-06-23
JobTitle       | Lpn Nurse

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

The cmdlet creates an array of one or more objects with the following properties.

Property | Description
| ----- | ------ |
FirstName      | The employees first name
MiddleName     | Middle name of the employee
LastName       | The last name for this employee
FullName       | The full name of the employee
TaxpayerID     | The fabricated taxpayer ID
EmployeeID     | The employee's ID
EMail          | The first part of the email address (the part before the @ sign)
HomePhone      | The generated home phone number
MobilePhone    | A fabricated mobile phone number
WorkPhone      | A created phone for the employee at work
HomeAddress1   | The home address line 1 for the employee
HomeAddress2   | The home address line 2 for the employee
HomeCity       | A city for the employee's home
HomeState      | The state the employee lives in
HomePostalCode | The postal code for the employee at home
WorkAddress1   | A work address line 1 for the employee
WorkAddress2   | A work address line 2 for the employee
WorkCity       | The city for the work address
WorkState      | The state of the employees work
WorkPostalCode | The fabricated postal code for the employees work address
BirthDate      | The employees birth date
HireDate       | The hire date for this employee
JobTitle       | The employee's job title

## NOTES

Data Fabricator - New-FabricatedEmployeeRecord.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

## RELATED LINKS

[Get-FabricatedJobTitle](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedJobTitle.md)

[Get-FabricatedDate](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedDate.md)

[Get-FabricatedAddressLine1](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine1.md)

[Get-FabricatedAddressLine2](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine2.md)

[Get-FabricatedPhone](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPhone.md)

[Get-FabricatedTaxpayerID](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedTaxpayerID.md)

[New-FabricatedNameRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedNameRecord.md)

[New-FabricatedCityStatePostalCodeRecord](https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md)

[ArcaneCode's Website](http://arcanecode.me)

[Data Fabricator on GitHub](http://datafabricator.com)
