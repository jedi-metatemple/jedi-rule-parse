# jedi-rule-parse
A better Expat-based parser for RuleXML.

## Style-templates used:
Following is a list of all the template files used by this parser - followed
by a full list of all the parameter variables that this template is _documented_
here as using.

### contain/expanded-text.stl
HTML output-format for the _original_ type of expanded text
(which is, technically, deprecated).
As a matter of fact, in future versions, unless this parser
is invoked with an option to accept that extended-text type
in the name of backwards-compatibility, this template will
not even be _looked_ for.

  * __title__: Title of this section of extended text.
(Mandatory for this type of extended text - and should be escaped
by this template.)
  * __content__: HTML code for the _text_ of this extended text.

### extx/cls-*.stl
Templates for any of the extended-text classes defined by the
<extxcl> tag and used by the extended-text segments enclosed by
<extx> tags.

  * __title__: Title of this section of extended text.
Mandatory if the <extxcl> tag defining the current extended-text
class has an 'rqtitle' parameter with a value of 'yes' - in which
case it should be escaped by this template.
Otherwise, this template-parameter isn't even _valid_.
  * __content__: HTML code for the _text_ of this extended text.

### highlight/document-name.stl
HTML output-format for displaying the name of a document or franchise
or anything that would have such a title.

  * __content__: HTML code that would go _inside_ this title.

### highlight/emphasis.stl
Exactly like __highlight/document-name.stl__ - except this one is for
emphasis
rather than names of a document or franchise or something.

### highlight/reference.stl
This is the HTML output-format for semi-formal semi-informal citations
within the text.
Exactly like all other style-templates within the __highlight__ directory,
with one difference.
The other highlighting templates are meant to highlight, but still keep _what_
they highlight as _inherent_ parts of the text.
On the other hand, it is asked that _this_ template (in addition to highlighting)
also, paranthetically _separate_ it's text from the rest.

### highlight/vocabulary.stl
Exactly like __highlight/document-name.stl__ - except this one is for
vocabulary terms
rather than names of a document or franchise or something.

### lesson-in-midtoc.stl
HTML output-format for a lesson's entry in the Expanded Table of Contents.

  * __ttl1__: The title of the containing chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __daynum__: The day-number of this lesson in the cycle. (This can be used
as an ID-number for the lesson.)
  * __dates__: The collective HTML code for the dates on which this lesson is featured.

### link/off-of-doc.stl
HTML output-format for a hypertext link. (__NOTE:__ These links are
permitted in the expanded text, but not in the main text.)

  * __link__: The URL you are linking to. (This should probably be escaped.)
  * __text__: The text of the hyperlink.

### main-lesson-display.stl
HTML output-format for a lesson's entry in the main body of the document.

  * __ttl1__: The title of the containing chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __daynum__: ??? The day-number of this lesson in the cycle. (This can be used
as an ID-number for the lesson.)
  * __dates__: The collective HTML code for the dates on which this lesson is featured.
  * __text__: The HTML code for the _contents_ of the lesson.

### main-lesson-placehold.stl
Exactly like __main-lesson-display.stl__ - except that it is for
placeholder lessons - invoked if the "stat" parameter to the "lcn"
tag has a value of "notyet".

### main-lesson-group-display.stl
HTML output-format for a chapter in the main body of the document.

  * __ttl1__: The title of the chapter.
  * __ttl2__: The title of the containing section (generally, that being the
full document).
  * __content__: The HTML of the rest of this section of the main body
of the document.
  * __chapt\_id__: The id-number of the chapter.

### mainbd-date/*
Exactly like __midtoc-date/*__ except it pertains to the date's appearance
in the main body rather than in the Expanded Table of Contents.

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


