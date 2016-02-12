package me::gnrtag::g_stnz;
use strict;
use me::gnrtag::g_l;


sub addtags {
  $_[0]->tag('stnz',\&tag_on,\&tag_off);
}

sub tag_on {
  $_[0]->pentotg('stnztx');
  $_[0]->morph(&subcont());
}

sub tag_off {
  my $this;
  my $lc_tg;
  $this = $_[0];
  
  $this->untag('title');
  $lc_tg = $this->tgdata();
  $this->wrraw("\n" . '<p class = "lc_verse">' . "\n");
  $this->wrraw($lc_tg->{'stnztx'});
  $this->wrraw("\n</p>\n");
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  &me::gnrtag::g_l::addtags($lc_cont);
  
  return $lc_cont;
}


1;
