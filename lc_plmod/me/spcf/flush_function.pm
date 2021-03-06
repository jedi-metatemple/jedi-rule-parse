package me::spcf::flush_function;
use strict;
use wraprg;
use chobdate02;
use me::globopt;
use Time::JulianDay;

my $lcn_in_ch_count;
my $lcn_in_ch_total;

my $opto;

my $month_tarray = [ 'x'
  , 'January'
  , 'February'
  , 'March'
  , 'April'
  , 'May'
  , 'June'
  , 'July'
  , 'August'
  , 'September'
  , 'October'
  , 'November'
  , 'December'
];

my $week_tarray = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
'Sunday'];


$opto = &me::globopt::refren();



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
  my $lc_date_rnd;
  my $lc_date_src;
  my $lc_dl;
  my $lc_lcn_insc;
  my $lc_top_toc;
  $this = $_[0];
  
  
  $lc_lcn_insc = {};
  
  $lc_gdat = $this->gldata();
  $lc_lcnx = $lc_gdat->{'lcnx'};
  &daycode($lc_lcnx,$lc_lcn_insc);
  &enumera($lc_lcnx);
  
  $lc_gprm = $this->argum(1);
  
  
  foreach $lc_lesson (@$lc_lcnx)
  {
    $lc_lesson->{'datehtm'} = '';
    $lc_lesson->{'mn-datehtm'} = '';
  }
  $lc_date_rnd = 0;
  $lc_date_src = $lc_gprm->{'date'};
  $lc_dl = $lc_gprm->{'style'}->dlog();
  while ( $lc_date_rnd < ( ( $lc_gprm->{'reps'} ) - 0.5 ) )
  {
    foreach $lc_lesson (@$lc_lcnx)
    {
      my @lc3_inf;
      my $lc3_date_uni;
      my $lc3_date_all;
      my $lc3_b_date_uni;
      my $lc3_b_date_all;
      
      @lc3_inf = &chobdate02::moreabout($lc_date_src);
      
      $lc_dl->set('year',$lc_date_src->[0]);
      $lc_dl->set('month',$lc_date_src->[1]);
      $lc_dl->set('dayom',$lc_date_src->[2]);
      $lc_dl->set('dayow',$lc3_inf[3]);
      
      # Original Generation of TOC Date
      $lc3_date_uni = $lc_dl->run('each-midtoc-date');
      $lc3_date_all = $lc3_date_uni;
      
      # Original Generation of Main Body Date
      $lc3_b_date_uni = $lc_dl->run('each-mainbd-date');
      $lc3_b_date_all = $lc3_b_date_uni;
      
      # Now we advance the date to the next day for
      # the benefit of the next round.
      &chobdate02::advanso($lc_date_src,1);
      
      if ( $lc_date_rnd > 0.5 )
      {
        # Collectivization of TOC Date
        $lc_dl->set('old',$lc_lesson->{'datehtm'});
        $lc_dl->set('new',$lc3_date_uni);
        $lc3_date_all = $lc_dl->run('another-midtoc-date');
        
        # Collectivization of Main Body Date
        $lc_dl->set('old',$lc_lesson->{'mn-datehtm'});
        $lc_dl->set('new',$lc3_b_date_uni);
        $lc3_b_date_all = $lc_dl->run('another-mainbd-date');
      }
      $lc_lesson->{'datehtm'} = $lc3_date_all;
      $lc_lesson->{'mn-datehtm'} = $lc3_b_date_all;
    }
    $lc_date_rnd = int($lc_date_rnd + 1.2);
  }
  
  # Frame the dates -- if we are supposed to:
  if ( $lc_date_rnd > 0.5 )
  {
    foreach $lc_lesson (@$lc_lcnx)
    {
      # Framing of TOC Date
      $lc_dl->set('old',$lc_lesson->{'datehtm'});
      $lc_dl->set('wide',$lc_date_rnd);
      $lc_lesson->{'datehtm'} = $lc_dl->run('frame-midtoc-date');
      
      # Framing of Main Body Date
      $lc_dl->set('old',$lc_lesson->{'mn-datehtm'});
      $lc_dl->set('wide',$lc_date_rnd);
      $lc_lesson->{'mn-datehtm'} = $lc_dl->run('frame-mainbd-date');
    }
  }
  
  $lc_cont_body = '';
  $lc_cont_midtoc = '';
  $lc_lcn_body = '';
  $lc_lcn_midtoc = '';
  $lc_top_toc = '';

  $lcn_in_ch_count = {};
  $lcn_in_ch_total = {};

  foreach $lc_lesson (@$lc_lcnx)
  {
    &painshow($lc_lesson);
  }

  foreach $lc_lesson (@$lc_lcnx)
  {
    &mainshow($lc_lesson,$lc_gprm->{'style'},{
      'body' => \$lc_cont_body,
      'midtoc' => \$lc_cont_midtoc,
      'lc-body' => \$lc_lcn_body,
      'lc-midtoc' => \$lc_lcn_midtoc,
      'lc-headtoc' => \$lc_top_toc,
      'segsize' => $lc_lcn_insc,
    });
  }
  
  $lc_dlg = $lc_gprm->{'style'}->dlog();
  $lc_dlg->set('title',$lc_gprm->{'title'});
  $lc_dlg->set('contents',$lc_cont_body);
  $lc_dlg->set('big-toc',$lc_cont_midtoc);
  $lc_dlg->set('small-toc',$lc_top_toc);
  $lc_outp = $lc_dlg->run('mainframe');
  #system("echo",": : :\n" . $lc_outp . "\n: : :");
  
  
  $lc_wricm = "echo";
  &wraprg::lst($lc_wricm,$lc_outp);
  $lc_wricm .= ' > index.html';
  system($lc_wricm);
}

sub painshow {
  my $this;
  my $lc_hnd;
  my $lc_lcn_count;
  $this = $_[0];

  $lc_hnd = $lcn_in_ch_total;
  $lc_lcn_count = $lc_hnd->{$this->{'chapt_id'}};
  $lc_lcn_count = int($lc_lcn_count + 1.2);
  $lc_hnd->{$this->{'chapt_id'}} = $lc_lcn_count;
}

sub mainshow {
  my $this;
  my $lc_out;
  my $lc_dl;
  my $lc_tmplnom;
  my $lc_segsz;
  my $lc_hnd;
  my $lc_lcn_count;
  my $lc_xtra;
  my $lc_extr;
  my @lc_date_array;
  my $lc_today_jul;
  my $lc_today_dayow_a;
  my $lc_today_dayow_b;
  $this = $_[0];

  $lc_hnd = $lcn_in_ch_count;
  $lc_lcn_count = $lc_hnd->{$this->{'chapt_id'}};
  $lc_lcn_count = int($lc_lcn_count + 1.2);
  $lc_hnd->{$this->{'chapt_id'}} = $lc_lcn_count;
  
  $lc_segsz = $_[2]->{'segsize'};
  
  $lc_today_jul = int($opto->{'prejuld'} + $this->{'daynum'} + 0.2);
  $lc_today_dayow_a = (int($lc_today_jul - 5.8) % 7);
  $lc_today_dayow_b = $week_tarray->[$lc_today_dayow_a];
  @lc_date_array = inverse_julian_day($lc_today_jul);

  
  
  $lc_dl = $_[1]->dlog();
  if ( $this->{'newt'} ) { $lc_dl->set('newsec','ok'); }
  $lc_dl->set('ttl1',$this->{'ttl'}->see());
  $lc_dl->set('ttl2',$this->{'ttl'}->dpsee(1));
  $lc_dl->set('text',$this->{'tx'});
  $lc_dl->set('current',$this->{'current'});
  $lc_dl->set('previous',$this->{'previous'});
  $lc_dl->set('next',$this->{'next'});
  $lc_dl->set('daynum',$this->{'daynum'});
  $lc_dl->set('dates',$this->{'mn-datehtm'});
  $lc_dl->set('part_num',$this->{'subpart'});
  $lc_dl->set('part_of',$lc_segsz->{$this->{'segmenid'}});
  $lc_dl->set('chapt_id',$this->{'chapt_id'});
  $lc_dl->set('show_year',$lc_date_array[0]);
  $lc_dl->set('show_n_month',$lc_date_array[1]);
  $lc_dl->set('show_month',$month_tarray->[$lc_date_array[1]]);
  $lc_dl->set('show_dayom',$lc_date_array[2]);
  $lc_dl->set('show_dayow',$lc_today_dayow_b);

  $lc_dl->set('lesson_in_ch_count',$lcn_in_ch_count->{$this->{'chapt_id'}});
  $lc_dl->set('lesson_in_ch_total',$lcn_in_ch_total->{$this->{'chapt_id'}});

  $lc_xtra = $opto->{'extras'};
  foreach $lc_extr (@$lc_xtra)
  {
    my $lc2_nom;
    my $lc2_val;
    $lc2_nom = 'x_' . $lc_extr->[0];
    $lc2_val = $lc_extr->[1];
    $lc_dl->set($lc2_nom,$lc2_val);
  }
  
  
  $lc_tmplnom = 'lcn-main';
  if ( $this->{'stat'} eq 'notyet' ) { $lc_tmplnom = 'lcn-phold-main'; }
  $lc_out = $_[2]->{'lc-body'};
  $$lc_out .= $lc_dl->run($lc_tmplnom);
  
  $lc_dl->set('dates',$this->{'datehtm'});
  $lc_out = $_[2]->{'lc-midtoc'};
  $$lc_out .= $lc_dl->run('lcn-mid-toc-lcn');
  
  if ( $this->{'wayout'} ) {
    my $lc2_a;
    my $lc2_cont;
    
    
    $lc2_a = $_[1]->dlog();
    $lc2_a->set('ttl1',$this->{'ttl'}->see());
    $lc2_a->set('ttl2',$this->{'ttl'}->dpsee(1));
    $lc2_a->set('chapt_id',$this->{'chapt_id'});
    
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
    
    $lc_out = $_[2]->{'lc-headtoc'};
    $$lc_out .= $lc2_a->run('contents-by-chapter');
  }
  
  return $lc_out;
}

sub enumera {
  my $lc_lcon;
  my $lc_lcnx;
  my $lc_chapt;
  my $lc_prv_chapt;
  
  $lc_lcnx = $_[0];
  $lc_prv_chapt = 0;
  $lc_chapt = 1;
  foreach $lc_lcon (@$lc_lcnx)
  {
    $lc_lcon->{'chapt_id'} = $lc_chapt;
    
    # The chapter is incremented conditionally *after* it's
    # assignment to the current lesson rather than *before*,
    # because the 'wayout' variable based on which it *decides*
    # this flags the *last* lesson in the chapter, not the first.
    if ( $lc_lcon->{'wayout'} )
    {
      $lc_prv_chapt = $lc_chapt;
      $lc_chapt = int($lc_chapt + 1.2);
    }
  }
}

sub daycode {
  my $lc_lcnx;
  my $lc_lcon;
  my $lc_dnum;
  my $lc_code;
  my $lc_preva;
  my $lc_lcins;
  
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
      $lc_lcins = 0;
    }
    $lc_lcins = int($lc_lcins + 1.2);
    $_[1]->{$lc_lcon->{'segmenid'}} = $lc_lcins;
    $lc_lcon->{'subpart'} = $lc_lcins;
    $lc_preva = $lc_lcon;
  }
  
}


1;
