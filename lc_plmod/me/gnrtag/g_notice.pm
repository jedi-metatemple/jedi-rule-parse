package me::gnrtag::g_notice;
use strict;

sub full_tag {
  return ( 'notice', \&tag_on, \&tag_off );
}

sub tag_on {
  $_[0]->morph(&me::gnrtag::g_include::zerocont());
}

sub tag_off { }

1;
