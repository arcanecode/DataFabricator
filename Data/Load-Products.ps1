$m_Colors = 'Red',
            'Green',
            'Blue',
            'Yellow',
            'Black',
            'White',
            'Purple',
            'Sky Blue',
            'Ocean Green',
            'Mauve'


$m_Clothing = 'Shirt',
              'Pants',
              'Socks',
              'Hat',
              'Mens Shoes',
              'Ladies Shoes',
              'Gloves',
              'Shorts',
              'Slacks',
              'Jeans',
              'Coat'

$m_Sizes = 'Extra Small',
           'Small',
           'Medium',
           'Large',
           'Extra large',
           '2XL',
           '3XL',
           '4XL'

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these "constants" here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxColorLength = ($m_Colors | Measure-Object -Maximum -Property Length).Maximum
$c_MaxClothingLength = ($m_Clothing | Measure-Object -Maximum -Property Length).Maximum
$c_MaxSizeLength = ($m_Sizes | Measure-Object -Maximum -Property Length).Maximum


