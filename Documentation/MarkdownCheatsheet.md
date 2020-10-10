# Markdown Cheat Sheet

## Table of Contents <a name="toc"></a>

- [Markdown Cheat Sheet](#markdown-cheat-sheet)
  - [Table of Contents <a name="toc"></a>](#table-of-contents-)
  - [Overview](#overview)
  - [Comments](#comments)
  - [Headers](#headers)
  - [Emphasis](#emphasis)
- [Lists](#lists)
  - [Images](#images)
  - [Links](#links)
  - [Anchors](#anchors)
    - [Some links](#some-links)
    - [Jump point 1 <a name="jump_1"></a>](#jump-point-1-)
    - [Jump point 2 <a name="jump_2"></a>](#jump-point-2-)
  - [Footnotes](#footnotes)
  - [Code](#code)
  - [Tables](#tables)
  - [Block Quotes](#block-quotes)
  - [HTML](#html)
  - [Horizontal rule](#horizontal-rule)
  - [YouTube Videos](#youtube-videos)
  - [Author Information](#author-information)
    - [Author](#author)
    - [Websites](#websites)
    - [Copyright Notice](#copyright-notice)

<a name="overview"></a>
## Overview

This document is a Markdown quick reference. It is by no means a comprehensive tutorial on Markdown, but rather just some of the most common Markdown tags to serve as a reminder.

You can view this using one of the Markdown preview tools, just be aware somethings won't work quite right, such as the Image and YouTube sections, as they point to items that do not exist.

[Back to Table of Contents](#toc)

<a name="comments"></a>
## Comments

Markdown comments can be done in two ways. First is the markdown syntax:

```
[//]: # (Here is my comment)
```

You can also give the comment a name/id

```
[comment]: # (Here is another comment)
```

The second method is with HTML
<!---
Block HTML comment here
multiline too
Make sure to use three - after the opening as some markdown viewers fail to recognize the html comment without it.
-->

Embedding blank linkes
To embed a blank line (extra space) in a document, you have to resort to HTML

```
&nbsp;
```

Or you can use the html line break.
```
<br>
```

[Back to Table of Contents](#toc)

<a name="headers"></a>
## Headers

```
# H1
## H2
### H3
#### H4
##### H5
###### H6
```

[Back to Table of Contents](#toc)

<a name="emphasis"></a>
## Emphasis

Italics: `_word_` becomes _word_  (can also use a single *)

Bold: `**word**` becomes **word**  (can also use a double underscore __)

Strikethru: `~~word~~` becomes ~~word~~

If you need to use these characters, you can do so by escaping them.

```
\*this won't be italisized*
```

becomes

\*this won't be italisized*

[Back to Table of Contents](#toc)

<a name="lists"></a>
# Lists

```
* Unordered list can use asterisks
- Or minuses
+ Or pluses
```

Nested lists can be setup.

```
+ Item 1
+ Item 2
+ Item 3
  - Item 3.1
  - Item 3.2
+ Item 4
+Item 5
```

Renders as:

+ Item 1
+ Item 2
+ Item 3
  - Item 3.1
  - Item 3.2
+ Item 4
+Item 5

[Back to Table of Contents](#toc)

<a name="images"></a>
## Images
You can embed images in one of two ways. The first uses pure markdown, but doesn't allow you to resize the image. (Note the image file names are case sensitive).

```
![Image Name](Images/myimage.jpg)
```

If you need to resize the image, you can use the HTML IMG tag.

```html
<img src="Images/myimage.jpg" width=320 height=240 alt="my image goes here">
```

[Back to Table of Contents](#toc)

<a name="Links"></a>
## Links
You can just paste in URL in which case markdown will make it a link

This will display the text in brackets, but link to the URL in parens

```
[Inline link](http://arcanecode.me)
```

[Inline link](http://arcanecode.me)

This will do the same but add a title

```
[Inline link](http://arcanecode.me "Arcane's Page")
```

[Inline link](http://arcanecode.me "Arcane's Page")

Can also have relative links

```
[Link to another file](../path/theotherfile.html)
```

[Link to another file](../path/theotherfile.html)

[Back to Table of Contents](#toc)

<a name="anchors"></a>
## Anchors

You can setup links to specific spots inside your document. To do so use the `<a>` tag for the anchor, and a `#` in the link.

```
### Some links
  * [Jump 1](#jump_1)
  * [Jump 2](#jump_2)
  * [Jump 3](#jump_3)
```

Here's the anchors:

```
### Jump point 1 <a name="jump_1"></a>

Some content here

### Jump point 2 <a name="jump_2"></a>

More content here

Anchors don't have to be in a header, it can be anywhere.

Footnote 3 <a name="jump_3"></a>
```

Try it out here:

### Some links
  * [Jump 1](#jump_1)
  * [Jump 2](#jump_2)
  * [Jump 3](#jump_3)

### Jump point 1 <a name="jump_1"></a>

Some content here

### Jump point 2 <a name="jump_2"></a>

More content here

Anchors don't have to be in a header, it can be anywhere.

Just some text for Footnote 3 <a name="jump_3"></a>

Anchors can also go backwords. For example you could use code like this to jump back to the top of a section.

```
[Back to Anchors](#anchors)
```

[Back to Anchors](#anchors)

[Back to Table of Contents](#toc)

<a name="Footnotes"></a>
## Footnotes

Not all parsers support footnotes, but many do. For example, the markdown extension here in Visual Studio does, but the markdown engine in GitHub does not.

To do a footnote, use a square bracket, caret, then the footnote number, such as `[^1]`.

```
Some text with a [^1] footnote

[^1]: Even though this footnote is right under the reference, you won't see it unless you jump to the bottom of the document.
```

Please note that no matter where you place the footnote in the document, the markdown engine will place it at teh very bottom of the document.

Try it out:

Some text with a [^1] footnote

[^1]: Even though this footnote is right under the reference, you won't see it unless you jump to the bottom of the document.

[Back to Table of Contents](#toc)

<a name="code"></a>
## Code

Inline code is surrounded with single backticks

```
Here the variable `$myVar` is used to do fun things.
```

Renders as:

Here the variable `$myVar` is used to do fun things.

Code blocks use three backticks ` ``` ` before and after the code.

```
Anything here gets ignored **this ain't bold** including markdown. It simply highlights in in gray.
```

To enable syntax highlighting, put the language name after the last backtick on the first line.

```powershell
$path = '/home/documents/'
Get-ChildItem $path
```

[Back to Table of Contents](#toc)

<a name="tables"></a>
## Tables

Use vertical bars to divide columns. Colons can be used to align columns. A colon on both sides indicates it should be centered, on the right side then it will be right aligned. No colon defaults to left aligned.

```
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |
```

Renders to:


| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

Note there must be at least three dashes for each header cell. Also, the opening and closing vertical bar are optional, but look much nicer.

[Back to Table of Contents](#toc)

<a name="blockquotes"></a>
## Block Quotes

Block quotes can be used to emulate a side note or what you might see in email. It produces the text in a light font (by default dark gray) on a colored background (default is a light gray). Use > to create a block quote. You can use multiple > to indent block quotes.

```
> Some text to block quote
>> Here's the __indented__ quote
```

> Some text to block quote
>> Here's the __indented__ quote

You can also embed markdown inside the block quote, as the above example shows with the word second bolded.

[Back to Table of Contents](#toc)

<a name="html"></a>
## HTML

You can embed HTML inside markdown, and for the most part it renders well.


[Back to Table of Contents](#toc)

<a name="horizontalrule"></a>
## Horizontal rule

You can add a horizontal rule in one of three ways. Use three Hyphens, Asterisks, or Underscores. Be sure to put a blank line before and after the horizontal line or it will adversely affect the text around it.

```
---
***
___
```

All become:

---
***
___

[Back to Table of Contents](#toc)

<a name="youtube"></a>
## YouTube Videos

They can't be added directly but you can add an image with a link to the video like this:

```
<a name="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg"
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>
```

Or, in pure Markdown, but losing the image sizing and border:

```
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](http://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)
```

[Back to Table of Contents](#toc)

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
