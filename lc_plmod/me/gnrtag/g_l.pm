package me::gnrtag::g_l;
use strict;

sub addtags {
  $_[0]->tag('l',\&tag_on,\&tag_off_a);
}

sub tag_on {
  $_[0]->tag('l',\&tag_on,\&tag_off_b);
  $_[0]->esc_tag_data('lcon');
}

sub tag_off_a {
  my $this;
  my $lc_tg;
  $this = $_[0];
  
  $lc_tg = $this->tgdata();
  $this->wrraw('&nbsp; <em>');
  $this->wresc($lc_tg->{'lcon'});
  $this->wrraw('</em>');
}

sub tag_off_b {
  my $this;
  my $lc_tg;
  $this = $_[0];
  
  $lc_tg = $this->tgdata();
  $this->wrraw("<br />\n" . '&nbsp; <em>');
  $this->wrraw($lc_tg->{'lcon'});
  $this->wrraw('</em>');
}



1;
