# jedi-rule-parse
A better Expat-based parser for RuleXML.

## Style-templates used:
Following is a list of all the template files used by this parser - followed
by a full list of all the parameter variables that this template is _documented_
here as using.

### main-frame.stl
This is the main framing, including the beginning and the end of the HTML output.

  * __title__: The title of the full document (unescaped).
  * __big-toc__: The HTML code for the _expanded_ table-of-contents.
  * __contents__: The HTML code for the contents of the document - that is,
the HTML code for all the lessons and everything else:

### section-in-midtoc.stl
HTML output-format for a chapter's place in the Expanded Table of Contents.

  * __ttl1__: The title of the chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __content__: The HTML of the rest of this section of the Expanded Table
of Contents (which should include _within_ it an entry for each lesson).


