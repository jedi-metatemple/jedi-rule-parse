package me::gnrtag::expt::g_a;
use strict;
use chobxml02::context;


sub addtags {
  $_[0]->tag('a',\&tag_on,\&tag_off);
}

sub tag_on {
  $_[0]->esc_tag_data('txt');
  $_[0]->untag('a');
}

sub tag_off {
  my $this;
  my $lc_tg;
  my $lc_sply;
  my $lc_dl;
  my $lc_refloc;
  $this = $_[0];
  
  $lc_tg = $this->tgdata();
  $lc_refloc = $this->pram('ref');
  
  &addtags($this);
  $lc_sply = $this->argum(1);
  $lc_dl = $lc_sply->{'style'}->dlog();
  $lc_dl->set('text',$lc_tg->{'txt'});
  $lc_dl->set('link',$lc_refloc);
  $this->wrraw($lc_dl->run('link/off-of-doc'));
}


1;
