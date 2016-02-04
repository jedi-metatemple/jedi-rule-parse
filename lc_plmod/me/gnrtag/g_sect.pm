package me::gnrtag::g_sect;
use strict;
use me::gnrtag::g_include;
use me::gnrtag::g_notice;


sub tag_on {
  $_[0]->morph(&subcont());
}

sub tag_off {
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &me::gnrtag::g_include::subcont();
  $lc_cont->tag('sect',\&tag_on,\&tag_off);
  $lc_cont->tag(&me::gnrtag::g_notice::full_tag());
  
  return $lc_cont;
}


1;
