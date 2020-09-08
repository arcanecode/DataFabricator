# This is the first half of a street address, for example "Oak" or "1st".
# The street address last holds things like "Ave" "Lane" etc.

$m_StreetsFirst = Get-Content .\Data\Data-StreetsFirst.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxStreetsFirstLength = ($m_StreetsFirst | Measure-Object -Maximum -Property Length).Maximum
