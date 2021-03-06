package me::gnrtag::g_pream;
use strict;
use me::gnrtag::g_include;
use me::gnrtag::g_notice;
use me::gnrtag::g_lcn;
use me::gnrtag::g_extxcl;
use me::globopt;


my $opto;

$opto = &me::globopt::refren();


sub addtags {
  $_[0]->tag('pream',\&tag_on,\&tag_off);
}


sub tag_on {
  my $lc_gdata;
  my $lc_tdata;

  $opto->{'num_chapt'} = (1>2);
  
  # BEGIN LITANY OF TITLESET PRESERVATION
  $_[0]->untag('title'); # Too late if title for supersect not yet declared
  $lc_gdata = $_[0]->gldata();
  $lc_tdata = $_[0]->tgdata();
  
  # Create tagwide copy of title-set
  $lc_tdata->{'sctitle'} = $lc_gdata->{'sctitle'}->clone();
  
  # END LITANY OF TITLESET PRESERVATION:
  
  $_[0]->morph(&subcont());
}

sub tag_off {
  my $lc_gdata;
  my $lc_tdata;
  
  # BEGIN LITANY OF TITLESET PRESERVATION
  
  $lc_gdata = $_[0]->gldata();
  $lc_tdata = $_[0]->tgdata();
  
  # Restore global copy of title-set
  $lc_gdata->{'sctitle'} = $lc_tdata->{'sctitle'}->clone();
  
  
  # END LITANY OF TITLESET PRESERVATION:
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &me::gnrtag::g_include::subcont();
  $lc_cont->tag(&me::gnrtag::g_notice::full_tag());
  &me::gnrtag::g_lcn::addtags($lc_cont);
  &me::gnrtag::g_extxcl::addtags($lc_cont);
  
  return $lc_cont;
}


1;
