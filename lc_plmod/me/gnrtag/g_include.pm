package me::gnrtag::g_include;
use strict;
use chobxml02::context;
use me::spctag::g_sect_title;

sub subcont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  $lc_cont->tag('sub',\&nothing,\&nothing);
  $lc_cont->tag('include',\&tag_on,\&tag_off);
  &me::spctag::g_sect_title::addtags($lc_cont);
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
  my $lc_opts; # Options to subparse() method:
  
  $lc_opts = {};
  
  $_[0]->subparse($_[0]->pram('ref'),$lc_opts);
  $_[0]->morph(&zerocont);
}


sub tag_off {
}


1;
