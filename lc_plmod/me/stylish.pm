package me::stylish;
use strict;
use chobak_style;


sub load {
  my $lc_styl;
  
  $lc_styl = &chobak_style::new($_[0]);
  
  
  $lc_styl->load('main-frame.stl','mainframe');
  
  $lc_styl->load('section-in-midtoc.stl','lcn-mid-toc-sect');
  $lc_styl->load('lesson-in-midtoc.stl','lcn-mid-toc-lcn');
  
  
  # UNSORTED STUFF
  
  $lc_styl->load('main-lesson-display.stl','lcn-main');
  $lc_styl->load('main-lesson-placehold.stl','lcn-phold-main');
  $lc_styl->load('main-lesson-group-display.stl','lcn-group-main');
  
  $lc_styl->load('highlight/document-name.stl','highlight/docname');
  $lc_styl->load('highlight/emphasis.stl','highlight/emphasis');
  $lc_styl->load('highlight/vocabulary.stl','highlight/vocabulary');
  $lc_styl->load('highlight/reference.stl','highlight/reference');
  
  $lc_styl->load('contain/expanded-text.stl','contain/expanded-text');
  $lc_styl->load('link/off-of-doc.stl','link/off-of-doc');
  
  return $lc_styl;
}



1;
