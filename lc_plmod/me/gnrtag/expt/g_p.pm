package me::gnrtag::expt::g_p;
use strict;
use me::gnrtag::g_p;
use me::gnrtag::expt::g_a;

sub addtags {
  $_[0]->tag('p',\&tag_on,\&me::gnrtag::g_p::tag_off);
}

sub tag_on {
  &me::gnrtag::g_p::tag_meat_on($_[0]);
  $_[0]->morph(&subcont());
}


sub subcont {
  my $lc_cont;
  
  $lc_cont = &me::gnrtag::g_p::subcont();
  &me::gnrtag::expt::g_a::addtags($lc_cont);
  
  return $lc_cont;
}


1;
