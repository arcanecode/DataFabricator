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
