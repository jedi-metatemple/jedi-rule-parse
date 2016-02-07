package me::spcf::init_function;
use strict;
use chobak_stack;

sub ftfunc {
  my $lc_data;
  
  $lc_data = $_[0]->gldata();
  $lc_data->{'sctitle'} = &chobak_stack::new();
}



1;
