package me::gnrtag::p_vc;
use strict;
use chobxml02::context;


sub addtags {
  $_[0]->tag('vc',\&tag_on,\&tag_off);
}

sub tag_on {
  $_[0]->esc_tag_data('txt');
  $_[0]->morph(&chobxml02::context::new());
}

sub tag_off {
  my $this;
  my $lc_tg;
  my $lc_sply;
  my $lc_dl;
  $this = $_[0];
  
  $lc_tg = $this->tgdata();
  
  $lc_sply = $this->argum(1);
  $lc_dl = $lc_sply->{'style'}->dlog();
  $lc_dl->set('content',$lc_tg->{'txt'});
  $this->wrraw($lc_dl->run('highlight/vocabulary'));
}


1;
