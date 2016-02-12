package me::gnrtag::expt::g_title;
use strict;


sub addtags {
  $_[0]->tag('title',\&tag_on,\&tag_off);
}

sub tag_on {
  my $this;
  my $lc_dat;
  $this = $_[0];
  
  $this->untag('title');
  $this->to_tag_data('titl');
  $_[0]->morph(&chobxml02::context::new());
}

sub tag_off {
  my $this;
  my $lc_gdt;
  my $lc_tdt;
  $this = $_[0];
  
  $lc_gdt = $this->gldata();
  $lc_tdt = $this->tgdata();
  $lc_gdt->{'title'}->on($lc_tdt->{'titl'});
}

1;
