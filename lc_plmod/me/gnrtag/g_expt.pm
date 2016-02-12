package me::gnrtag::g_expt;
use strict;
use me::gnrtag::g_stnz;
use me::gnrtag::expt::g_p;
use me::gnrtag::expt::g_title;


sub addtags {
  $_[0]->tag('expt',\&tag_on,\&tag_off);
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
  $this = $_[0];
  
  $lc_gdt = $this->gldata();
  $lc_tdt = $this->tgdata();
  
  if ( $lc_gdt->{'title'}->siz() < 0.5 )
  {
    die "\n"
      . "YOU FORGOT TO INCLUDE A TITLE <title></title>\n"
      . "in an EXPT <expt></expt> area!!!\n"
    . "\n";
  }
  
  $lc_sply = $this->argum(1);
  $lc_dl = $lc_sply->{'style'}->dlog();
  $lc_dl->set('content',$lc_tdt->{'txt'});
  $lc_dl->set('title',$lc_gdt->{'title'}->see());
  $this->wrraw($lc_dl->run('contain/expanded-text'));
  
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
