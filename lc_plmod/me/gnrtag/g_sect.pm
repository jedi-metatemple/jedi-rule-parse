package me::gnrtag::g_sect;
use me::gnrtag::g_include;


sub tag_on {
  $_[0]->morph(&subcont());
}

sub tag_off {
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &me::gnrtag::g_include::subcont();
  $lc_cont->tag('sect',\&tag_on,\&tag_off);
  
  return $lc_cont;
}


1;
