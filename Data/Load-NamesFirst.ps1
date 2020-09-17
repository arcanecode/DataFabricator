$m_NamesFirst = Get-Content .\Data\Data-NamesFirst.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxNamesFirstLength = ($m_NamesFirst | Measure-Object -Maximum -Property Length).Maximum
