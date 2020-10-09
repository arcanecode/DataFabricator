<#
.SYNOPSIS
Fabricates one or more new inventory records, and returns them as an array of objects (aka records).

.DESCRIPTION
Let's face it, your company probably doesn't want to admit to how much junk is still in the warehouse that they can't sell.

In order to avoid yet another negative quarter on the stock market, you can use this cmdlet to create one or more rows of fake but realistic inventory data. This contains properties such as the product, warehouse, bin, and quantity.

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

.PARAMETER WarehouseCode
A code which represents the warehouse to put the inventory. If not passed in, then warehouse values are generated for each product.

By passing in a warehouse code all inventory will be generated for a single warehouse.

.PARAMETER MinQuantity
The minimum quantity to generate inside a bin within the warehouse. This defaults to 1 if no value is passed in.

.PARAMETER MaxQuantity
The maximum quantity to generate inside a bin within the warehouse. This defaults to 999 if no value is passed in.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
This cmdlet returns one or more objects with the following properties:

ProductCode       | Unique identifier for the product
WarehouseCode     | A code which uniquely identifies a warehouse
Bin               | The bin number where a product is located within a warehouse
WarehouseBinCode  | A code which combines the warehouse code and bin to form a unique identifier for a location
Quantity          | How many items are in this bin

.EXAMPLE
New-FabricatedInventoryRecord

New-FabricatedInventoryRecord returned the following data:

ProductCode      | HATRED6XL
WarehouseCode    | MIMANLEYHOTSPRINGSCDP
Bin              | ZL021
WarehouseBinCode | MIMANLEYHOTSPRINGSCDPZL021
Quantity         | 661

.EXAMPLE
New-FabricatedInventoryRecord -MinQuantity 1000 -MaxQuantity 2000

New-FabricatedInventoryRecord returned the following data:

ProductCode      | SLABLU6XL
WarehouseCode    | ARSHAVERLAKECDP
Bin              | HL092
WarehouseBinCode | ARSHAVERLAKECDPHL092
Quantity         | 1227

.EXAMPLE
New-FabricatedInventoryRecord -CountryCode UK

New-FabricatedInventoryRecord returned the following data:

ProductCode      | JEAWHILAR
WarehouseCode    | BRDURHAM
Bin              | WO134
WarehouseBinCode | BRDURHAMWO134
Quantity         | 887

.EXAMPLE
New-FabricatedInventoryRecord -WarehouseCode 'NCMAUCKPORTTOWN'

New-FabricatedInventoryRecord returned the following data:

ProductCode      | PANREDSMA
WarehouseCode    | NCMAUCKPORTTOWN
Bin              | TM160
WarehouseBinCode | NCMAUCKPORTTOWNTM160
Quantity         | 647

.NOTES
Data Fabricator - New-FabricatedInventoryRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function New-FabricatedInventoryRecord()
{
  [CmdletBinding()]
  param (
             [int] $RecordCount = 1
        ,    [int] $MaxDuplicateCountBeforeError = 50
        , [string] $WarehouseCode = 'x'
        , [string] $CountryCode = 'US'
        ,    [int] $MinQuantity = 1
        ,    [int] $MaxQuantity = 999
        )


  # Note, due to the way the range function in PowerShell works, we
  # don't have to worry if the Min Quantity is greater than the Max.
  # 1..999 and 999..1 both work the same for our purposes

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  if ($WarehouseCode -eq 'x')
    { $wc = 'Fabricate Warehouse Codes'}
  else
    { $wc = $WarehouseCode }

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count....................: $RecordCount
         Max Duplicate Rows Befor Error..: $MaxDuplicateCountBeforeError
         Min Quantity....................: $MinQuantity
         Max Quantity....................: $MaxQuantity
         Warehouse Code..................: $wc
"@

  #----------------------------------------------------------------------------------------------
  #  Main logic to create and return the Record
  #----------------------------------------------------------------------------------------------

  # If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  # Define the output object
  class InventoryRecord
  {
    [string] $ProductCode
    [string] $WarehouseCode
    [string] $Bin
    [string] $WarehouseBinCode
       [int] $Quantity
  }

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0

  # Fabricate new rows
  while ($i -lt $RecordCount)
  {
    $prod = [InventoryRecord]::new()

    # Generate a product code, but suppress any verbose messages from it
    $prod.ProductCode = $(New-FabricatedProductRecord -Verbose:$false).ProductCode

    # If they passed a warehouse use it, otherwise generate one
    if ($WarehouseCode -ne 'x')
    {
      $prod.WarehouseCode = $WarehouseCode
    }
    else
    {
      $state = Get-FabricatedState -CountryCode $CountryCode -Verbose:$false
      $cityCode = ConvertTo-CityCode -City $(Get-FabricatedCity -CountryCode $CountryCode -Verbose:$false)

      $prod.WarehouseCode = "$state$cityCode"
    }

    $prod.Bin = Get-FabricatedBin -Verbose:$false

    $prod.Quantity = $MinQuantity..$MaxQuantity | Get-Random

    $prod.WarehouseBinCode = "$($prod.WarehouseCode)$($prod.Bin)"
    $item = "$($prod.WarehouseCode) $($prod.Bin) $($prod.ProductCode) $($prod.Quantity)"

    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    # Note, for this exercise we are going to assume once a bin within a warehouse
    # has something in it, it is full so won't put anything else there.
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $prod; $i++
    }
    else
    {
      # Now do the dupe check
      if ($retVal.WarehouseBinCode.Contains($prod.WarehouseBinCode) -eq $false)
      {
        $retVal += $prod; $i++   # If not there are are safe to add it
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
  $retVal = $retVal | Sort-Object -Property WarehouseBinCode

  # Return our results
  return $retVal

}