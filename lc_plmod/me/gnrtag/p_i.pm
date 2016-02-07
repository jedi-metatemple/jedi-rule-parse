package me::gnrtag::p_i;
use strict;
use chobxml02::context;


sub addtags {
  $_[0]->tag('i',\&tag_on,\&tag_off);
}

sub tag_on {
  $_[0]->esc_tag_data('txt');
  $_[0]->morph(&chobxml02::context::new());
}

sub tag_off {
  my $this;
  my $lc_tg;
  $this = $_[0];
  
  $lc_tg = $this->tgdata();
  $this->wrraw('<em>');
  $this->wrraw($lc_tg->{'txt'});
  $this->wrraw("</em>");
}


1;
