# DataFabricator Module

## Description

This module is designed to fabricate fake, but realistic looking data. Fabricated data could be used to test applications, for providing data to demonstrate your program to others, and more.

It has been designed to be modular, you could select individual functions, such as generating names, or to generate entire records such as customer or employee records.

## DataFabricator Cmdlets

### [ConvertFrom-CityStateCode](ConvertFrom-CityStateCode.md)

Takes a CityState code (the city code with the two character state abbreviation on front) and deconstructs it, converting it back to the city and state.

### [ConvertFrom-ProductCode](ConvertFrom-ProductCode.md)

Takes the product code and converts it back to the Clothing, Color and Size.

### [ConvertTo-CityCode](ConvertTo-CityCode.md)

The city code is combined with the two character state abbreviaion to create the city state code.

This is used as a key in several functions.

### [ConvertTo-ProductCode](ConvertTo-ProductCode.md)

The product code consists of the first three characters from the clothing, color, and size all upper cased.

Based on the sample data included with this module this will create a unique value that is used as a key in several places.

### [Get-CountryCodes](Get-CountryCodes.md)

Returns a list of all valid Country Codes.

### [Get-FabricatedAddressLine1](Get-FabricatedAddressLine1.md)

Fabricates an address typically used as the address line 1 in an address.

### [Get-FabricatedAddressLine2](Get-FabricatedAddressLine2.md)

Fabricates an address suitable for the second line in an address, such as an apartment number or office suite.

### [Get-FabricatedBin](Get-FabricatedBin.md)

Fabricates a location in a warehouse, referred to as a Bin number.

### [Get-FabricatedCity](Get-FabricatedCity.md)

Fabricates the name of a city from a list of cities.

### [Get-FabricatedCompany](Get-FabricatedCompany.md)

Fabricates a company name.

### [Get-FabricatedDate](Get-FabricatedDate.md)

Fabricates a date and (optionally) a time.

### [Get-FabricatedJobTitle](Get-FabricatedJobTitle.md)

Fabricates a job title from an internal list.

### [Get-FabricatedName](Get-FabricatedName.md)

Fabricates names, first and last, from internal lists of over 20,000 names.

### [Get-FabricatedPhone](Get-FabricatedPhone.md)

Fabricates a phone number for the CountryCode, defaulting to the US based format.

### [Get-FabricatedPostalCode](Get-FabricatedPostalCode.md)

Fabricates a postal code.

### [Get-FabricatedState](Get-FabricatedState.md)

Fabricates a state by randomly picking it from a list of states.

### [Get-FabricatedTaxpayerID](Get-FabricatedTaxpayerID.md)

Fabricates a TaxpayerID (taxpayer identification number). In the US this would be the Social Security Number.

### [Get-FabricatedTime](Get-FabricatedTime.md)

Fabricates a random time of day.

### [Get-StateName](Get-StateName.md)

Converts the state abbreviation to the full state name.

### [New-FabricatedCityStatePostalCodeRecord](New-FabricatedCityStatePostalCodeRecord.md)

Fabricate one or more records with city, state, and postal code data.

### [New-FabricatedCompanyRecord](New-FabricatedCompanyRecord.md)

Fabricates one or more new company records, and returns them as an array of objects (aka records).

### [New-FabricatedCustomerRecord](New-FabricatedCustomerRecord.md)

Fabricates one or more new customer records, and returns them as an array of objects (aka records).

### [New-FabricatedEmployeeRecord](New-FabricatedEmployeeRecord.md)

Fabricates one or more new employee records, and returns them as an array of objects (aka records).

### [New-FabricatedInventoryRecord](New-FabricatedInventoryRecord.md)

Fabricates one or more new inventory records, and returns them as an array of objects (aka records).

### [New-FabricatedNameRecord](New-FabricatedNameRecord.md)

Fabricates one or more new name records, complete with all variations of a name, and returns them as an array of objects (aka records).

### [New-FabricatedProductRecord](New-FabricatedProductRecord.md)

Fabricates one or more new product records, and returns them as an array of objects (aka records).

### [New-FabricatedProductTable](New-FabricatedProductTable.md)

Fabricate a table (a collection of product objects) with all possible combinations of products.

### [New-FabricatedSalesRecord](New-FabricatedSalesRecord.md)

Fabricates sales data based on the supplied mix of employees, products, customers, and employees. Returns them as a collection of sales records (objects) in an array.

### [Open-DataFabricatorWebsite](Open-DataFabricatorWebsite.md)

As the name implies, it opens the DataFabricator page on GitHub in your default web browser. This makes it easy to open the site for quick reference. You can also pass in the name of a function via the -FunctionName parameter and it will jump right to the page for that function.

### [Show-AboutDataFabricator](Show-AboutDataFabricator.md)

Displays information about the DataFabricator module, with links to find out more info.

### [Show-DataFabricatorFunctions](Show-DataFabricatorFunctions.md)

Displays a list of all the functions in the DataFabricator, along with a synopsis of their purpose. (Basically, it is a mirror of this document.)

### [Test-CountryCode](Test-CountryCode.md)

Tests the passed in country code to see if it is valid.

---

## Author Information

### Author

Robert C. Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcanecode@gmail.com

### Websites

About Me: [http://arcanecode.me](http://arcanecode.me)

Blog: [http://arcanecode.com](http://arcanecode.com)

Github: [http://arcanerepo.com](http://arcanerepo.com)

LinkedIn: [http://arcanecode.in](http://arcanecode.in)

### Copyright Notice

This document is Copyright (c) 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
