$m_Compass = Get-Content .\Data\Data-Compass.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxCompassLength = ($m_Compass | Measure-Object -Maximum -Property Length).Maximum
