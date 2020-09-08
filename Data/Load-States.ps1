# Load State Abbreviations and Names

$m_StateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt
$m_StateNameUS = Get-Content .\Data\Data-StateNameUS.txt

# Since we want this to be a hashtable we need to include -Raw so 
# ConvertFrom-StringData will return a hashtable datatype
$m_StateTableUS = Get-Content -Raw .\Data\Data-StateTableUS.txt | ConvertFrom-StringData

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxStateAbbrUSLength = ($m_StateAbbrUS | Measure-Object -Maximum -Property Length).Maximum
$c_MaxStateNameUSLength = ($m_StateNameUS | Measure-Object -Maximum -Property Length).Maximum


$m_StateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt
$m_StateNameUK = Get-Content .\Data\Data-StateNameUK.txt
$m_StateTableUK = Get-Content -Raw .\Data\Data-StateTableUK.txt | ConvertFrom-StringData
