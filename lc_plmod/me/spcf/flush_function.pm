package me::spcf::flush_function;
use strict;
use wraprg;


sub ftfunc {
  my $this;
  my $lc_gprm;
  my $lc_dlg;
  my $lc_outp;
  my $lc_gdat;
  my $lc_lcnx;
  my $lc_wricm;
  my $lc_lesson;
  my $lc_cont_body;
  my $lc_cont_midtoc;
  my $lc_lcn_body;
  my $lc_lcn_midtoc;
  $this = $_[0];
  
  $lc_gdat = $this->gldata();
  $lc_lcnx = $lc_gdat->{'lcnx'};
  &daycode($lc_lcnx);
  
  $lc_gprm = $this->argum(1);
  
  $lc_cont_body = '';
  $lc_cont_midtoc = '';
  $lc_lcn_body = '';
  $lc_lcn_midtoc = '';
  foreach $lc_lesson (@$lc_lcnx)
  {
    &mainshow($lc_lesson,$lc_gprm->{'style'},{
      'body' => \$lc_cont_body,
      'midtoc' => \$lc_cont_midtoc,
      'lc-body' => \$lc_lcn_body,
      'lc-midtoc' => \$lc_lcn_midtoc,
    });
  }
  
  $lc_dlg = $lc_gprm->{'style'}->dlog();
  $lc_dlg->set('title','Untitle Document');
  $lc_dlg->set('contents',$lc_cont_body);
  $lc_dlg->set('big-toc',$lc_cont_midtoc);
  $lc_outp = $lc_dlg->run('mainframe');
  #system("echo",": : :\n" . $lc_outp . "\n: : :");
  
  
  $lc_wricm = "echo";
  &wraprg::lst($lc_wricm,$lc_outp);
  $lc_wricm .= ' > index.html';
  system($lc_wricm);
}

sub mainshow {
  my $this;
  my $lc_out;
  my $lc_dl;
  my $lc_tmplnom;
  $this = $_[0];
  
  
  $lc_dl = $_[1]->dlog();
  if ( $this->{'newt'} ) { $lc_dl->set('newsec','ok'); }
  $lc_dl->set('ttl1',$this->{'ttl'}->see());
  $lc_dl->set('ttl2',$this->{'ttl'}->dpsee(1));
  $lc_dl->set('text',$this->{'tx'});
  $lc_dl->set('current',$this->{'current'});
  $lc_dl->set('previous',$this->{'previous'});
  $lc_dl->set('next',$this->{'next'});
  $lc_dl->set('daynum',$this->{'daynum'});
  
  $lc_tmplnom = 'lcn-main';
  if ( $this->{'stat'} eq 'notyet' ) { $lc_tmplnom = 'lcn-phold-main'; }
  $lc_out = $_[2]->{'lc-body'};
  $$lc_out .= $lc_dl->run($lc_tmplnom);
  
  $lc_out = $_[2]->{'lc-midtoc'};
  $$lc_out .= $lc_dl->run('lcn-mid-toc-lcn');
  
  if ( $this->{'wayout'} ) {
    my $lc2_a;
    my $lc2_cont;
    
    $lc2_a = $_[1]->dlog();
    $lc2_a->set('ttl1',$this->{'ttl'}->see());
    $lc2_a->set('ttl2',$this->{'ttl'}->dpsee(1));
    
    $lc_out = $_[2]->{'lc-midtoc'};
    $lc2_cont = $$lc_out;
    $lc2_a->set('content',$lc2_cont);
    $$lc_out = '';
    $lc_out = $_[2]->{'midtoc'};
    $$lc_out .= $lc2_a->run('lcn-mid-toc-sect');
    
    $lc_out = $_[2]->{'lc-body'};
    $lc2_cont = $$lc_out;
    $lc2_a->set('content',$lc2_cont);
    $$lc_out = '';
    $lc_out = $_[2]->{'body'};
    $$lc_out .= $lc2_a->run('lcn-group-main');
  }
  
  return $lc_out;
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
    $lc_lcon->{'daynum'} = $lc_dnum;
    $lc_lcon->{'wayout'} = ( 2 > 1 );
    $lc_lcon->{'segmenid'} = 0;
    if ( ref($lc_preva) eq 'HASH' )
    {
      $lc_preva->{'next'} = $lc_code;
      $lc_lcon->{'previous'} = $lc_preva->{'current'};
      $lc_preva->{'wayout'} = $lc_lcon->{'newt'};
      
      # Segment ID part
      $lc_lcon->{'segmenid'} = $lc_preva->{'segmenid'}
    }
    if ( $lc_lcon->{'newt'} )
    {
      $lc_lcon->{'segmenid'} = int( $lc_lcon->{'segmenid'} + 1.2 );
    }
    $lc_preva = $lc_lcon;
  }
  
}


1;
