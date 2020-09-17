# Loads Company related values, First, Industry, and Last

$m_CompanyFirst = Get-Content .\Data\Data-CompanyNamePrefix.txt

$m_CompanyIndustry = Get-Content .\Data\Data-CompanyIndustry.txt

$m_CompanyLast = Get-Content .\Data\Data-CompanyType.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxCompanyFirstLength = ($m_CompanyFirst | Measure-Object -Maximum -Property Length).Maximum
$c_MaxCompanyIndustryLength = ($m_CompanyIndustry | Measure-Object -Maximum -Property Length).Maximum
$c_MaxCompanyLastLength = ($m_CompanyLast | Measure-Object -Maximum -Property Length).Maximum
