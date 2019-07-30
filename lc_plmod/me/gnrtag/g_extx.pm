package me::gnrtag::g_extx;
use strict;
use me::gnrtag::g_stnz;
use me::gnrtag::expt::g_p;
use me::gnrtag::expt::g_title;
use me::stylish;
use me::globopt;

my $opto;

$opto = &me::globopt::refren();



sub addtags {
  $_[0]->tag('extx',\&tag_on,\&tag_off);
}

sub tag_on {
  my $this;
  my $lc_gdt;
  my $lc_tdt;
  $this = $_[0];
  
  $lc_gdt = $this->gldata();
  $lc_tdt = $this->tgdata();
  
  # Back up 'title' data
  $lc_tdt->{'title'} = $lc_gdt->{'title'};
  $lc_gdt->{'title'} = &chobak_stack::new();
  
  $this->pentotg('txt');
  
  
  $_[0]->morph(&subcont());
}

sub tag_off {
  my $this;
  my $lc_gdt;
  my $lc_tdt;
  my $lc_sply;
  my $lc_dl;
  my $lc_class;
  my $lc_stlid;
  my $lc_cprm;
  my $lc_extr;
  my $lc_xtra;
  $this = $_[0];
  
  $lc_gdt = $this->gldata();
  $lc_tdt = $this->tgdata();
  
  $lc_class = $this->pram('cls');
  if ( !(&me::stylish::lookup($lc_class,$lc_stlid,$lc_cprm)) )
  {
    die "\nNo such -extx- class: " . $lc_class . ":\n\n";
  }
  
  
  if ( $lc_cprm->{'rqtitle'} )
  {
    if ( $lc_gdt->{'title'}->siz() < 0.5 )
    {
      die "\n"
        . "YOU FORGOT TO INCLUDE A TITLE <title></title>\n"
        . 'in an EXPT <extx cls="' . $lc_class . '"></extx> area!!!' . "\n"
      . "\n";
    }
  }
  
  if ( $lc_cprm->{'fbdtitle'} )
  {
    if ( $lc_gdt->{'title'}->siz() > 0.5 )
    {
      die "\n"
        . "TITLE FORBIDDEN <title></title>\n"
        . 'in an EXPT <extx cls="' . $lc_class . '"></extx> area!!!' . "\n"
      . "\n";
    }
  }
  
  $lc_sply = $this->argum(1);
  $lc_dl = $lc_sply->{'style'}->dlog();
  $lc_dl->set('content',$lc_tdt->{'txt'});
  $lc_dl->set('title',$lc_gdt->{'title'}->see());



  $lc_xtra = $opto->{'extras'};
  foreach $lc_extr (@$lc_xtra)
  {
    my $lc2_nom;
    my $lc2_val;
    $lc2_nom = 'x_' . $lc_extr->[0];
    $lc2_val = $lc_extr->[1];
    $lc_dl->set($lc2_nom,$lc2_val);
  }


  $this->wrraw($lc_dl->run(('extx/cls-' . $lc_stlid)));
  
  # Restore the 'title'
  $lc_gdt->{'title'} = $lc_tdt->{'title'};
}

sub subcont {
  my $lc_cont;
  
  $lc_cont = &chobxml02::context::new();
  &me::gnrtag::g_stnz::addtags($lc_cont);
  &me::gnrtag::expt::g_p::addtags($lc_cont);
  &me::gnrtag::expt::g_title::addtags($lc_cont);
  
  
  return $lc_cont;
}



1;


1;
