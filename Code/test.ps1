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

