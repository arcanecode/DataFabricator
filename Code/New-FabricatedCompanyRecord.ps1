<#
.SYNOPSIS
Fabricates a new company and returns it as an object (aka record)

.DESCRIPTION
This cmdlet will create a new object (or objects) that have properties tha a company would have.
Company name, address, contact and more (see the Outputs section for full details.)
This makes it easy to generate one or more companies for you to do business with.

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
One or more objects with the following properties.

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

.EXAMPLE
New-FabricatedCompanyRecord

New-FabricatedCompanyRecord returns the following data:

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

.EXAMPLE
New-FabricatedCompanyRecord -RecordCount 10

In this example, New-FabricatedCompanyRecord will return 10 rows of fabricated data, each row with output similar to the example above.

.NOTES
Data Fabricator - New-FabricatedCompanyRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedNameRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine1.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedAddressLine2.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function New-FabricatedCompanyRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
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
"@

  # Define the properties of the object (or arrayy of them) we will return
  class CompanyRecord
  {
    [string] $Name
    [string] $Address1
    [string] $Address2
    [string] $City
    [string] $State
    [string] $PostalCode
    [string] $ContactName
    [string] $ContactPhone
    [string] $ContactEMail
    [string] $ContactJobTitle
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
    $csz = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $name = New-FabricatedNameRecord -Verbose:$false

    $company = [CompanyRecord]::new()
    $company.Name = Get-FabricatedCompany -Verbose:$false
    $company.Address1 = Get-FabricatedAddressLine1 -Verbose:$false
    $company.Address2 = Get-FabricatedAddressLine2 -Threshold 90 -Verbose:$false
    $company.City = $csz.City
    $company.State = $csz.State
    $company.PostalCode = $csz.PostalCode

    $company.ContactName = $name.FirstLast
    $email = $company.Name.ToLower().Replace(' ', '')
    $company.ContactEMail = "$($name.EmailName)@$($email).com"

    $company.ContactPhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $company.ContactJobTitle = Get-FabricatedJobTitle -Verbose:$false
    
    $item = $company.Name
    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $company; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.Name.Contains($company.Name) -eq $false)
      {        
        $retVal += $company; $i++   # If not there are are safe to add it
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
  $retVal = $retVal | Sort-Object -Property Name

  # Return our results
  return $retVal

}