package me::gnrtag::g_lcn;
use strict;
use me::gnrtag::g_stnz;
use me::gnrtag::g_p;
use me::gnrtag::g_expt;
use chobak_stack;

sub addtags {
  $_[0]->tag('lcn',\&tag_on,\&tag_off);
}

sub tag_on {
  my $this;
  my $lc_gdat;
  my $lc_tdat;
  $this = $_[0];
  
  $lc_gdat = $this->gldata();
  $lc_tdat = $this->tgdata();
  
  # Establish date queue;
  $lc_tdat->{'date'} = $lc_gdat->{'date'};
  $lc_tdat->{'date'} = &chobak_stack::new();
  
  $this->untag('title'); # Title must come *before* first lcn.
  $this->pentotg('lcntx');
  $this->morph(&subcont());
}

sub tag_off {
  my $this;
  my $lc_tdat;
  my $lc_gdat;
  my $lc_lcnr; # Lesson Record
  my $lc_lc_ray; # Reference to Lesson ARray
  $this = $_[0];
  
  $lc_tdat = $this->tgdata();
  $lc_gdat = $this->gldata();
  $lc_lcnr = {};
  $lc_lcnr->{'tx'} = $lc_tdat->{'lcntx'};
  $lc_lcnr->{'ttl'} = $lc_gdat->{'sctitle'}->clone();
  $lc_lcnr->{'newt'} = $lc_gdat->{'newt'};
  $lc_lcnr->{'stat'} = $this->pram('stat');
  $lc_lcnr->{'date'} = $lc_gdat->{'date'};
  if ( ! ( defined($lc_lcnr->{'stat'}) ) )
  {
    $lc_lcnr->{'stat'} = 'ok';
  }
  $lc_gdat->{'newt'} = ( 1 > 2 );
    
  $lc_lc_ray = $lc_gdat->{'lcnx'};
  @$lc_lc_ray = (@$lc_lc_ray,$lc_lcnr);
  
  # RESTORATIONS:
  $lc_gdat->{'date'} = $lc_tdat->{'date'};
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  &me::gnrtag::g_stnz::addtags($lc_cont);
  &me::gnrtag::g_p::addtags($lc_cont);
  &me::gnrtag::g_expt::addtags($lc_cont);
  
  return $lc_cont;
}


1;
