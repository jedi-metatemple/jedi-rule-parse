package me::gnrtag::g_include;
use strict;
use chobxml02::context;

sub subcont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  $lc_cont->tag('sub',\&nothing,\&nothing);
  $lc_cont->tag('include',\&tag_on,\&tag_off);
  return $lc_cont;
}

sub zerocont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  $lc_cont->misc(\&nothing,\&nothing);
  
  return $lc_cont;
}


sub nothing { }


sub tag_on {
  $_[0]->subparse($_[0]->pram('ref'));
  $_[0]->morph(&zerocont);
}


sub tag_off {
}


1;
