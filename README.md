# jedi-rule-parse
A better Expat-based parser for RuleXML.

## Style-templates used:
Following is a list of all the template files used by this parser - followed
by a full list of all the parameter variables that this template is _documented_
here as using.

### lesson-in-midtoc.stl
HTML output-format for a lesson's entry in the Expanded Table of Contents.

  * __ttl1__: The title of the containing chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __daynum__: The day-number of this lesson in the cycle. (This can be used
as an ID-number for the lesson.)
  * __dates__: The collective HTML code for the dates on which this lesson is featured.

### main-lesson-group-display.stl
HTML output-format for a chapter in the main body of the document.

  * __ttl1__: The title of the chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __content__: The HTML of the rest of this section of the main body
of the document.
  * __chapt\_id__: The id-number of the chapter.

### midtoc-date/another.stl
In the event of any date being generated other than the first one - this
template is invoked to put it all together. It generates anew what is the
_collective_ HTML of the dates.

  * __new__: The HTML of the newly-generated date.
  * __old__: The collective HTML of all the dates up to this point.

### midtoc-date/each.stl
The template for the HTML for each auto-generated date in the Expanded Table of Contents.

  * __dayow__: The day of the week.
Can be shown with the __day-l__ directive.
  * __month__: The month.
Can be shown with the __month-l__ directive.
  * __dayom__: The day of the month (by number).
  * __year__: The year (with all it's digits).

### main-frame.stl
This is the main framing, including the beginning and the end of the HTML output.

  * __title__: The title of the full document (unescaped).
  * __big-toc__: The HTML code for the _expanded_ table-of-contents.
  * __small-toc__: The HTML code for the _compact_ table-of-contents.
  * __contents__: The HTML code for the contents of the document - that is,
the HTML code for all the lessons and everything else:

### midtoc-date/frame.stl
This frames in the Expanded Table of Contents
the HTML of all the dates for a lesson.
This style-template, however, will only be invoked
if there is at _least_ _one_ date for the entry.

  * __old__: The collective HTML for the entries that is _being_ framed.

### main-table-of-contents.stl
This is a chapter's entry in the Compact Table of Contents.
It's parameters are the same as __section-in-midtoc.stl__ -
except that it is asked that you refrain from using the
__content__ parameter.

### section-in-midtoc.stl
HTML output-format for a chapter's place in the Expanded Table of Contents.

  * __ttl1__: The title of the chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __content__: The HTML of the rest of this section of the Expanded Table
of Contents (which should include _within_ it an entry for each lesson).
  * __chapt\_id__: The id-number of the chapter.


