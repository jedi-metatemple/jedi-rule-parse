package me::spctag::g_sect_title;
use strict;
use chobxml02::context;

sub addtags {
  $_[0]->tag('title',\&tag_on,\&tag_off);
}

sub tag_on {
  my $lc_dat;
  
  # Only one Queen to a Hive, baby!!!
  $_[0]->untag('title');
  # And don't worry about how this will affect the close-tag
  # because the latest versions of 'chobakwrap' implement
  # 'chobxml02' in such a way that the handler of a closing
  # tag is identified *before* the execution of the handler
  # for the corresponding *opening* tag.
  
  # Create an empty string in tag-data labeled 'titl',
  # point the writer to it, and set the function to
  # just add all char-data to the writer --- all in
  # one convenient object-method!!!
  $_[0]->to_tag_data('titl');
  
  # No tags are allowed *within* a title:
  $_[0]->morph(&chobxml02::context::new());
  
  # A message to the next <lcn>:
  $lc_dat = $_[0]->gldata();
  $lc_dat->{'newt'} = ( 2 > 1 );
}

sub tag_off {
  my $lc_tgdat;
  my $lc_gldat;
  my $lc_expr;
  
  $lc_tgdat = $_[0]->tgdata();
  $lc_gldat = $_[0]->gldata();
  $lc_gldat->{'sctitle'}->on($lc_tgdat->{'titl'});
  
  # THE FOLLOWING CODE IS TEMPORARY:
  # Until we have a _better_ way of processing the
  # full-document's title.
  $lc_expr = $_[0]->argum(1);
  if ( $lc_expr->{'ttlopen'} )
  {
    $lc_expr->{'title'} = $lc_gldat->{'sctitle'}->{'lmn'}->[0];
    $lc_expr->{'ttlopen'} = ( 1 > 2 );
  }
}



1;
