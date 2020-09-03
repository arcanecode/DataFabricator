$m_StreetsLast = 'Street',
                 'Road',
                 'Rd.',
                 'Avenue',
                 'Ave.',
                 'Lane',
                 'Ln.',
                 'Drive',
                 'Highway',
                 'Hwy',
                 'Boulevard',
                 'Blvd',
                 'Place',
                 'Court',
                 'Ct.',
                 'Circle',
                 'Trail',
                 'Path',
                 'Loop',
                 'Way'

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxStreetsLastLength = ($m_StreetsLast | Measure-Object -Maximum -Property Length).Maximum
