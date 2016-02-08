package me::spcf::flush_function;
use strict;


sub ftfunc {
  my $this;
  my $lc_gprm;
  my $lc_dlg;
  my $lc_outp;
  my $lc_gdat;
  my $lc_lcnx;
  $this = $_[0];
  
  $lc_gdat = $this->gldata();
  $lc_lcnx = $lc_gdat->{'lcnx'};
  &daycode($lc_lcnx);
  
  $lc_gprm = $this->argum(1);
  $lc_dlg = $lc_gprm->{'style'}->dlog();
  
  $lc_dlg->set('title','Untitle Document');
  $lc_dlg->set('contents','BOOKOOROO');
  $lc_outp = $lc_dlg->run('mainframe');
  #system("echo",": : :\n" . $lc_outp . "\n: : :");
}

sub daycode {
  my $lc_lcnx;
  my $lc_lcon;
  my $lc_dnum;
  my $lc_code;
  my $lc_preva;
  
  $lc_lcnx = $_[0];
  $lc_dnum = 0;
  $lc_preva = 'x';
  foreach $lc_lcon (@$lc_lcnx)
  {
    $lc_dnum = int($lc_dnum + 1.2);
    $lc_code = "day";
    if ( $lc_dnum < 9.5 ) { $lc_code .= '0'; }
    if ( $lc_dnum < 99.5 ) { $lc_code .= '0'; }
    if ( $lc_dnum < 999.5 ) { $lc_code .= '0'; }
    #if ( $lc_dnum < 9999.5 ) { $lc_code .= '0'; }
    $lc_code .= $lc_dnum . "lcn";
    
    $lc_lcon->{'current'} = $lc_code;
    if ( ref($lc_preva) eq 'HASH' )
    {
      $lc_preva->{'next'} = $lc_code;
      $lc_lcon->{'previous'} = $lc_preva->{'current'};
    }
    $lc_preva = $lc_lcon;
  }
  
}


1;
