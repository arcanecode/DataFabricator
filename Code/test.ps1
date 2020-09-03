class Warehouse 
{
  [string] $City 
  [string] $State
}

$w1 = [Warehouse]::new()
$w2 = [Warehouse]::new()

$w1.City = "Chelsea"
$w1.State = "AL"
$w2.City = "Chelsea"
$w2.State = "KY"

#$w1 -eq $w2

$w1
$w2

Compare-Object -ReferenceObject $w1 -DifferenceObject $w2 -ExcludeDifferent -IncludeEqual


$(Compare-Object $w1 $w2 -IncludeEqual).SideIndicator


if (-not (Compare-Object $w1 $w2 -IncludeEqual))
{ 'match' }
else
{ 'no match' } 


# City Length
$minLen = 9999999
$city = 'x'
# Replace spaces commas and dashes with nothing, and uppercase
foreach($c in $m_Cities)
{
  $cCleaned = $c.Replace(' ', '').Replace('-', '').Replace(',', '').ToUpper()

  if ($cCleaned.Length -lt $minLen)
  { 
    $minLen = $cCleaned.Length
    $city = $cCleaned
  }
}

Write-Host "Min Length is $city $minLen"

# Y CDP

#------------------------------------------------------------------------------------------------
#  Dupe Testing
#------------------------------------------------------------------------------------------------

$front = '            "'
$end = '",'

$prevItem = ''
$dupeList = @()
$deDupeList = @()

foreach( $c in $($m_Cities | Sort-Object))
{
  if ($c -eq $prevItem)
  {
    $dupeList += $c
  }
  else
  {
    $deDupeList += $c
  }

  $prevItem = $c 
}

$dupeList 
$deDupeList

$output = ''
foreach($c in $deDupeList)
{
  Write-Output $c
  $output += "$front$c$end`r`n"
}

$output 
Set-Clipboard $output


# Check for dupes with the city code
$cityCodes = @()

# Replace spaces commas and dashes with nothing, and uppercase
foreach($c in $m_Cities)
{
  $code = $c.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()
  $cityCodes += $code
  Write-Host "$c - $code"
}

# Now look for dupes
$prevItem = ''
$dupeList = @()
$deDupeList = @()

foreach( $c in $cityCodes)
{
  Write-Host $c
  if ($c -eq $prevItem)
  {
    $dupeList += $c
  }
  else
  {
    $deDupeList += $c
  }

  $prevItem = $c 
}

$cityCodes.Count
$dupeList.Count
$deDupeList.Count




$minLen = 9999999
$city = 'x'
# Replace spaces commas and dashes with nothing, and uppercase
foreach($c in $cityCodes)
{
  $cCleaned = $c.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()

  if ($cCleaned.Length -lt $minLen)
  { 
    $minLen = $cCleaned.Length
    $city = $cCleaned
  }
}

Write-Host "Min Length is $city $minLen"


$prevItem = ''

# Replace spaces commas and dashes with nothing, and uppercase
foreach($c in $cityCodes)
{
  $cCleaned = $c.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()

  Write-Host $cCleaned
  if ($cCleaned -eq $prevItem)
  {
    $dupeList += $cCleaned
  }
  else
  {
    $deDupeList += $cCleaned
  }

  $prevItem = $cCleaned 

}

$dupeList.Count
$deDupeList.Count





class dupeTest
{
  [string] $Key
  [int] $SomeValue
}

$dupes = @()

for($i=0; $i -lt 10; $i=$i+2)
{
  $d = [dupeTest]::new()
  $d.Key = "AA$i"
  $d.SomeValue = $i
  $dupes += $d
}

$dupes

$dupes.Key.Contains("AA2")

$recordCount = 10
$i = $dupes.Count
$keyValue = 0

while ($i -lt $recordCount) 
{
  $d = [dupeTest]::new()
  $d.Key = "AA$keyValue"
  $d.SomeValue = $keyValue
  if ($dupes.Key.Contains($d.Key) -eq $false)
  {
    $dupes += $d
    $i++
  }
  $keyValue++

}

$dupes | Sort-Object -Property Key


$k = "Key"

$dupes.$k.Contains("AA09")

$dupes
$dupes.RemoveAt(2)



function get-mytest()
{
  [CmdletBinding()]
  param (
          [string] $paramStr = "param"
        , [int] $paramInt = 33
        , [switch] $ASwitch
        )

  Write-Host "Name"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Name
  #Write-Host "CmdletBinding"
  #Write-Host $PSCmdlet.MyInvocation.MyCommand.CmdletBinding
  #Write-Host "CommandType"
  #Write-Host $PSCmdlet.MyInvocation.MyCommand.CommandType
  #Write-Host "Definition"
  #Write-Host $PSCmdlet.MyInvocation.MyCommand.Definition
  Write-Host "Options"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Options
  Write-Host "Verb"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Verb
  Write-Host "Noun"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Noun
  Write-Host "Parameters"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Parameters
  Write-Host "OutputType"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.OutputType
  Write-Host "ParameterSets"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.ParameterSets
  Write-Host "Version"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Version
  Write-Host "Visibility"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Visibility
  Write-Host "Source"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.Source
  Write-Host "ScriptBlock"
  Write-Host $PSCmdlet.MyInvocation.MyCommand.ScriptBlock
  



  foreach($b in $PSCmdlet.MyInvocation.BoundParameters)
  {
    Write-Host $b.ToString()
  }

  
}

get-mytest 

