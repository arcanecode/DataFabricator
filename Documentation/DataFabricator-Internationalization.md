# Internationalization

## Overview

I'll be honest here, internationalization was an afterthought. After I created the first pass at the DataFabricator module, I decided I didn't like the fact it was so US focused. As such, I refactored many of the functions to add a `CountryCode` parameter. Currently, if you don't pass in a CountryCode, it defaults to use US. You can also explicitly pass in US as the country. The other country code currently supported is UK.

(And before I get a "well actually...", yes I know the UK is a collection of countries itself, but for purposes of data fabrication we can treat it conceptually as a single country. This is something that can be updated in the future if there is enough need.)

This allows the DataFabricator to correctly format things like phone numbers, postal codes, and taxpayer IDs for other countries.

The refactoring had a bit of a side effect though, in that the UK doesn't have the concept of "states" like the US. Instead it has counties, and these do not have the same two character abbreviations that are used in the United States.

As such, I've temporarily created a table of two character abbreviations for the "states" (UK counties) which I've included as part of the data. In the future I would like to refactor all the functions to eliminate the need for the two character state code, however this will be a fairly large undertaking so I'm saving it for a future revision.

I'm open to any input or assistance in this effort from my PowerShell friends in other countries, so we can make DataFabricator work for you too.

[Return to ReadMe](..\ReadMe.md)

---

## Author Information

### Author

Robert C. Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcanecode@gmail.com

### Websites

About Me: [http://arcanecode.me](http://arcanecode.me)

Blog: [http://arcanecode.com](http://arcanecode.com)

Github: [http://arcanerepo.com](http://arcanerepo.com)

LinkedIn: [http://arcanecode.in](http://arcanecode.in)

### Copyright Notice

This document is Copyright (c) 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
