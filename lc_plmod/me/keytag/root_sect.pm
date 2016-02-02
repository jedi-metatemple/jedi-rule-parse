package me::keytag::root_sect;
use strict;
use me::gnrtag::g_sect;

sub tags { return (\&tag_on,\&tag_off); }


sub tag_on {
  return &me::gnrtag::g_sect::tag_on($_[0]);
}

sub tag_off {
  return &me::gnrtag::g_sect::tag_off($_[0]);
}


1;
