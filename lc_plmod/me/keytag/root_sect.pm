package me::keytag::root_sect;
use strict;
use me::gnrtag::g_sect;

sub tags { return (\&tag_on,\&tag_off); }


sub tag_on {
  my $this;
  my $lc_dat;
  $this = $_[0];
  
  $lc_dat = $this->gldata();
  $lc_dat->{'lcnx'} = [];
  $lc_dat->{'newt'} = ( 2 > 1 ); # A message to the first <lcn>
  return &me::gnrtag::g_sect::tag_on($_[0]);
}

sub tag_off {
  return &me::gnrtag::g_sect::tag_off($_[0]);
}


1;
