package me::gnrtag::g_lcn;
use strict;
use me::gnrtag::g_stnz;
use me::gnrtag::g_p;

sub addtags {
  $_[0]->tag('lcn',\&tag_on,\&tag_off);
}

sub tag_on {
  $_[0]->pentotg('lcntx');
  $_[0]->morph(&subcont());
}

sub tag_off {
  my $this;
  my $lc_tg;
  my $lc_dat;
  my $lc_lcnr; # Lesson Record
  my $lc_lc_ray; # Reference to Lesson ARray
  $this = $_[0];
  
  $lc_tg = $this->tgdata();
  $lc_dat = $this->gldata();
  $lc_lcnr = {};
  $lc_lcnr->{'tx'} = $lc_tg->{'lcntx'};
  $lc_lcnr->{'ttl'} = $lc_dat->{'sctitle'}->clone();
  $lc_lcnr->{'newt'} = $lc_dat->{'newt'};
  $lc_dat->{'newt'} = ( 1 > 2 );
    
  $lc_lc_ray = $lc_dat->{'lcnx'};
  @$lc_lc_ray = (@$lc_lc_ray,$lc_lcnr);
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  &me::gnrtag::g_stnz::addtags($lc_cont);
  &me::gnrtag::g_p::addtags($lc_cont);
  
  return $lc_cont;
}


1;
