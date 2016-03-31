package me::gnrtag::g_extxcl;
use strict;
use me::stylish;
use me::gnrtag::g_include;


sub addtags {
  $_[0]->tag('extxcl',\&tag_on,\&tag_off);
}


sub tag_on {
  my $lc_cls;
  my $lc_stl;
  my $lc_exp;
  my $lc_param;
  
  $lc_param = {};
  
  # The 'rqtitle' field indicates whether or not
  # extra texts of this type have a title.
  $lc_param->{'rqtitle'} = ( 1 > 2 );
  $lc_param->{'fbdtitle'} = ( 2 > 1 );
  if ( $_[0]->pram('rqtitle') eq 'yes' )
  {
    $lc_param->{'rqtitle'} = ( 2 > 1 );
    $lc_param->{'fbdtitle'} = ( 1 > 2 );
  }
  
  $lc_cls = $_[0]->pram('id');
  $lc_stl = $_[0]->pram('tmpl');
  $lc_exp = $_[0]->pram('expl');
  &me::stylish::load_excl($lc_cls,$lc_stl,$lc_exp,$lc_param);
  $_[0]->morph(&me::gnrtag::g_include::zerocont);
}

sub tag_off {
}


1;