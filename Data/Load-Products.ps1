$m_Colors = Get-Content .\Data\Data-Colors.txt

$m_Clothing = Get-Content .\Data\Data-Clothing.txt

$m_Sizes = Get-Content .\Data\Data-Sizes.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these "constants" here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxColorLength = ($m_Colors | Measure-Object -Maximum -Property Length).Maximum
$c_MaxClothingLength = ($m_Clothing | Measure-Object -Maximum -Property Length).Maximum
$c_MaxSizeLength = ($m_Sizes | Measure-Object -Maximum -Property Length).Maximum


