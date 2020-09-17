# This is simply an array of the letter A-Z. It could be used for middle
# initials, suite or apartment numbers, and more

$m_Letter = 'A'..'Z'

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module

# Since this is an array of characters the length will always be 1,
# but we'll create a constant for it to be compatible with the other
# module level arrays
$c_MaxLetterLength = 1


# Generate an array of two letter codes. This is used for Warehouse Bins,
# Postal codes in some countries such as the UK, and more.
$m_TwoLetter = @()

foreach ( $m1 in $m_Letter )
{
  foreach ( $m2 in $m_Letter )
  {
    $m_TwoLetter += "$m1$m2"
  }
}

# Since this is an array of two letters the length will always be 2,
# but we'll create a constant for it to be compatible with the other
# module level arrays
$c_MaxTwoLetterLength = 2
