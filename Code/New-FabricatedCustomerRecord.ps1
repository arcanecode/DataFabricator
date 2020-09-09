<#
.SYNOPSIS
Fabricates a new customer record.

.DESCRIPTION
This cmdlet will generate one or more custoemr records for the country code passed in.

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
An array of 1 or more objects with the following structure.

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

.EXAMPLE
New-FabricatedCustomerRecord

New-FabricatedCustomerRecord returns the following data:

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

.EXAMPLE
New-FabricatedCustomerRecord -CountryCode UK

New-FabricatedCustomerRecord returns the following data:

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

.NOTES
Data Fabricator - New-FabricatedCustomerRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedNameRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function New-FabricatedCustomerRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [string] $EMailDomain = 'fakemail.com'
        , [string] $CountryCode = 'US'
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count: $RecordCount
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
         EMailDomain: $EMailDomain
"@

  # Create a class for our return object
  class CustomerRecord
  {
    [string] $FirstName
    [string] $MiddleName
    [string] $LastName
    [string] $FullName
    [string] $CustomerID
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
  
  while ($i -lt $RecordCount) 
  {
    # Fabricate city/state/PostalCode and name records
    $cszHome = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $cszWork = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $name = New-FabricatedNameRecord -Verbose:$false

    $cust = [CustomerRecord]::new()

    $cust.FirstName = $name.First
    $cust.MiddleName = $name.Middle
    $cust.LastName = $name.Last
    $cust.FullName = $name.FirstMiddleLast

    $custnumber = $(1..999999 | Get-Random).ToString().PadLeft(6,'0')
    $cust.CustomerID = "$($cust.LastName.Substring(0, 2).ToUpper())$($custnumber)"

    $cust.EMail = "$($name.EmailName)@$($EMailDomain)"

    $cust.HomePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $cust.MobilePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $cust.WorkPhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false

    $cust.HomeAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $cust.HomeAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $cust.HomeCity = $cszHome.City
    $cust.HomeState = $cszHome.State
    $cust.HomePostalCode = $cszHome.PostalCode

    $cust.WorkAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $cust.WorkAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $cust.WorkCity = $cszWork.City
    $cust.WorkState = $cszWork.State
    $cust.WorkPostalCode = $cszWork.PostalCode

    $cust.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 -Verbose:$false
 
    $item = $cust.FullName
    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $cust; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.FullName.Contains($cust.FullName) -eq $false)
      {        
        $retVal += $cust; $i++   # If not there are are safe to add it
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