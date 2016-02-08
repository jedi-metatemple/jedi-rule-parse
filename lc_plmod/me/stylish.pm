package me::stylish;
use strict;
use chobak_style;


sub load {
  my $lc_styl;
  
  $lc_styl = &chobak_style::new($_[0]);
  $lc_styl->load('main-frame.stl','mainframe');
  
  return $lc_styl;
}



1;
