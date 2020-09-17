# First part of an Address 2, to be combined with a letter or number
# Example: Suite 101 or Apartment A

$m_Address2First = Get-Content .\Data\Data-Address2.txt

<#
$m_Address2First = 'Suite',
                   'Ste',
                   'Apartment',
                   'Apt',
                   'Office'
#>
# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxAddress2FirstLength = ($m_Address2First | Measure-Object -Maximum -Property Length).Maximum
