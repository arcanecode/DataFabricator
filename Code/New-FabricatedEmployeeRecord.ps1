<#
.SYNOPSIS
Fabricates a new employee record.

.DESCRIPTION
If your company is like mine, the employees are far too embarrased to admit working there.
In order not to drive employee morale even lower than it is, you can use this cmdlet to fabricate the data to create a fake employee record, with properties as defined in the output area.

.PARAMETER EMailDomain
By default the cmdlet will create customer records using fakemail.com as the final part of the email address.
You can override this, for example using your own company email, using this parameter.

.PARAMETER RecordCount
The number of records you want returned from this cmdlet. The default is 1.

.PARAMETER MaxDuplicateCountBeforeError
This cmdlet checks for duplicates so they are removed from the final output.
By default, once the cmdlet has generated 50 duplicates it will throw an error and exit before all the records have been generated (although it will return what it has generated to that point).
It is possible in some cases to request more records than it is possible to create based on the internal data.
To keep from falling into an infinite loop this mechanism will exit and let the user know what the issue is.
Normally you won't need to override this, but it is possible should you feel the need.

.PARAMETER CountryCode
Country code. If no code is supplied it defaults to the US.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
The cmdlet creates an array of one or more objects with the following properties.

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

.EXAMPLE
New-FabricatedEmployeeRecord

New-FabricatedEmployeeRecord returns data similar to the following example:

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

.EXAMPLE
New-FabricatedEmployeeRecord -RecordCount 5

New-FabricatedEmployeeRecord returns data similar to the following example:

The cmdlet produces five rows of data similar to the previous example.

.EXAMPLE
New-FabricatedEmployeeRecord -CountryCode UK

New-FabricatedEmployeeRecord returns data similar to the following example:

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
WorkAddress1   | 1860 H.T. Matthews Circle
WorkAddress2   | Apartment 7467
WorkCity       | Truro
WorkState      | LA
WorkPostalCode | GJ2J 8QG
BirthDate      | 2000-10-19
HireDate       | 2011-06-23
JobTitle       | Lpn Nurse

.NOTES
Data Fabricator - New-FabricatedEmployeeRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedJobTitle.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedDate.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine1.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine2.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPhone.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedTaxpayerID.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedNameRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function New-FabricatedEmployeeRecord()
{
  [CmdletBinding()]
  param (
             [int] $RecordCount = 1
        ,    [int] $MaxDuplicateCountBeforeError = 50  
        , [string] $EMailDomain = 'fakemail.com'
        , [string] $CountryCode = 'US'
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count....................: $RecordCount
         Max Duplicate Rows Befor Error..: $MaxDuplicateCountBeforeError
         EMailDomain.....................: $EMailDomain
         Country Code....................: $CountryCode
"@

  # Define the output object
  class EmployeeRecord
  {
    [string] $FirstName
    [string] $MiddleName
    [string] $LastName
    [string] $FullName
    [string] $TaxpayerID
    [string] $EmployeeID
    [string] $EMail
    [string] $HomePhone
    [string] $MobilePhone
    [string] $WorkPhone
    [string] $HomeAddress1
    [string] $HomeAddress2
    [string] $HomeCity
    [string] $HomeState
    [string] $HomePostalCode
    [string] $WorkAddress1
    [string] $WorkAddress2
    [string] $WorkCity
    [string] $WorkState
    [string] $WorkPostalCode
    [string] $BirthDate
    [string] $HireDate
    [string] $JobTitle
  }
  
  # If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount) 
  {
    # Fabricate city/state/zip and name records
    $cszHome = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $cszWork = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $name = New-FabricatedNameRecord -Verbose:$false

    $emp = [EmployeeRecord]::new()

    $emp.FirstName = $name.First
    $emp.MiddleName = $name.Middle
    $emp.LastName = $name.Last
    $emp.FullName = $name.FirstMiddleLast

    $emp.TaxpayerID = Get-FabricatedTaxpayerID -CountryCode $CountryCode -Verbose:$false
    $emp.EmployeeID = "$($emp.LastName.Substring(0, 2).ToUpper())$($emp.TaxpayerID.Substring($emp.TaxpayerID.Length - 4, 4)) "

    $emp.EMail = "$($name.EmailName)@$($EMailDomain)"

    $emp.HomePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $emp.MobilePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $emp.WorkPhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false

    $emp.HomeAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $emp.HomeAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $emp.HomeCity = $cszHome.City
    $emp.HomeState = $cszHome.State
    $emp.HomePostalCode = $cszHome.PostalCode

    # It's fairly common for work address to have a line 2, so we'll use a high threshold
    $emp.WorkAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $emp.WorkAddress2 = Get-FabricatedAddressLine2 -Threshold 75 -Verbose:$false
    $emp.WorkCity = $cszWork.City
    $emp.WorkState = $cszWork.State
    $emp.WorkPostalCode = $cszWork.PostalCode

    $emp.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 -Verbose:$false
    $emp.HireDate = Get-FabricatedDate -RelativeFromYear 15 -Verbose:$false

    $emp.JobTitle = Get-FabricatedJobTitle -Verbose:$false

    $item = $emp.FullName
    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $emp; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.FullName.Contains($emp.FullName) -eq $false)
      {        
        $retVal += $emp; $i++   # If not there are are safe to add it
      }
      else
      {
        $dupeTrackingCount++    # Mark as a dupe
        Write-Verbose "$fn - Duplicate   #$($dupeTrackingCount.ToString('#,##0')): $item Skipping"
      }
    }

    # If we exceeded the max dupe error count, error out
    if ( $dupeTrackingCount -ge $MaxDuplicateCountBeforeError )
    {
      $i = $RecordCount + 1     # Set it high so the while loop will exit
      Request-DupeErrorMessage -FunctionName $fn -DuplicateCount $dupeTrackingCount | Write-Verbose
    }

  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Sort the output before returning
  $retVal = $retVal | Sort-Object -Property LastName, FirstName, MiddleName

  # Return our results
  return $retVal

}