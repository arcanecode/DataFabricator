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
