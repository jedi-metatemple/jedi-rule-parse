package me::language;
use strict;
use chobak_lang01;

sub load {
  my $lc_lang;
  
  $lc_lang = &chobak_lang01::new($_[0]);
  
  return $lc_lang;
}


1;
