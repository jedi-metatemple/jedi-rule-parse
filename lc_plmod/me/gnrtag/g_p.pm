package me::gnrtag::g_p;
use strict;
use me::gnrtag::p_dcn;
use me::gnrtag::p_i;
use me::gnrtag::p_vc;
use me::gnrtag::p_cite;

sub addtags {
  $_[0]->tag('p',\&tag_on,\&tag_off);
}

sub tag_on {
  &tag_meat_on($_[0]);
  $_[0]->morph(&subcont());
}

sub tag_meat_on {
  $_[0]->esc_tag_data('prgtx');
}

sub tag_off {
  my $this;
  my $lc_tg;
  $this = $_[0];
  
  $this->untag('title');
  $lc_tg = $this->tgdata();
  $this->wrraw("\n" . '<p class = "lcn_p">');
  $this->wrraw($lc_tg->{'prgtx'});
  $this->wrraw("</p>\n");
}


sub subcont {
  my $lc_cont;
  
  $lc_cont = $lc_cont = &chobxml02::context::new();
  &me::gnrtag::p_dcn::addtags($lc_cont);
  &me::gnrtag::p_i::addtags($lc_cont);
  &me::gnrtag::p_vc::addtags($lc_cont);
  &me::gnrtag::p_cite::addtags($lc_cont);
  
  return $lc_cont;
}


1;
