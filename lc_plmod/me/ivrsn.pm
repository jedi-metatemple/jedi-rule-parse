package me::ivrsn;
use strict;

my $prognom = "jedi-rule-parse";
my $vrsn_max = 3;  # Maximum Version Permitted
my $vrsn_stbl = 2; # Maximun Version Congealed
my $vrsn_dflt = 2; # Default Version
my $vrsn_crnt = 'x';

sub stable {
  &do_seta($_[0],$vrsn_stbl,'-vrsn');
}

sub experim {
  &do_seta($_[0],$vrsn_max,'-exvrsn');
}


sub echo_crnt {
  if ( $vrsn_crnt eq 'x' ) { $vrsn_crnt = $vrsn_dflt; } # Defaultation Clause
  return $vrsn_crnt;
}

sub echo_dflt {
  return $vrsn_dflt;
}

sub echo_max {
  return $vrsn_max;
}

sub echo_stbl {
  return $vrsn_stbl;
}


sub do_seta {
  my $lc_nvr;
  my $lc_ok;
  
  if ( $vrsn_crnt eq 'x' ) { $vrsn_crnt = $vrsn_dflt; } # Defaultation Clause
  $lc_nvr = int($_[0] + 0.2);
  $lc_ok = 10;
  if ( $lc_nvr ne $_[0] ) { $lc_ok = 0; }
  if ( $lc_ok > 5 ) { if ( $lc_nvr < 0.5 ) { $lc_ok = 0; } }
  if ( $lc_ok > 5 ) { if ( $lc_nvr > ( $_[1] + 0.5 ) ) { $lc_ok = 0; } }
  
  if ( $lc_ok < 5 )
  {
    die "\n" .
      $prognom . " FATAL ERROR: Invalid Intervace-Version: " . $_[0] . ":\n" .
      "  Interface version specified by " . $_[2] . " option must be a no-frills\n" .
      "  integer ranging from 1 to " . $_[1] . ".\n" .
    "\n";
  }
  
  $vrsn_crnt = $_[0];
}


1;
