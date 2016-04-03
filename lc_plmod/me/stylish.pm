package me::stylish;
use strict;
use chobak_style;

my @excl_lis = ();
my %excl_cod = {};
my %excl_exp = {};
my %excl_prm = {};
my $styl_yet = 0;
my $styl_ref;

sub load_excl {
  my $lc_cn;
  
  foreach $lc_cn (@excl_lis)
  {
    if ( $lc_cn eq $_[0] ) { return; }
  }
  
  # Later on, I will add code here to make sure that
  # specified class-ID and template-code are both
  # valid.
  
  @excl_lis = (@excl_lis,$_[0]);
  $excl_cod{$_[0]} = $_[1];
  $excl_exp{$_[0]} = $_[2];
  $excl_prm{$_[0]} = $_[3];
  
  if ( $styl_yet < 5 ) { return; }
  
  
  $styl_ref->load(('extx/cls-' . $_[1] . '.stl'),
      ('extx/cls-' . $_[1]),
      ('Extra Text for: ' . $_[2])
  );
}

sub lookup {
  my $lc_each;
  
  foreach $lc_each (@excl_lis)
  {
    if ( $lc_each eq $_[0] )
    {
      $_[1] = $excl_cod{$lc_each};
      $_[2] = $excl_prm{$lc_each};
      return ( 2 > 1 );
    }
  }
  
  return ( 1 > 2 );
}


sub load {
  my $lc_styl;
  my $lc_not_first;
  my $lc_each;
  
  $lc_styl = &chobak_style::new($_[0]);
  
  $lc_not_first = $styl_yet;
  $styl_yet = 10;
  $styl_ref = $lc_styl;
  
  
  $lc_styl->load('main-frame.stl','mainframe'
    ,"  This is the main framing, including the beginning\n"
    ."  and the end of the HTML output.\n");
  
  $lc_styl->load('main-table-of-contents.stl','contents-by-chapter'
    ,"  A chapter's entry in the compact table-of-contents.\n");
  
  $lc_styl->load('section-in-midtoc.stl','lcn-mid-toc-sect'
    ,"  HTML output-format for a chapter's place in the Expanded Table of Contents.\n"
  );
  
  $lc_styl->load('lesson-in-midtoc.stl','lcn-mid-toc-lcn');
  
  $lc_styl->load('midtoc-date/each.stl','each-midtoc-date');
  $lc_styl->load('midtoc-date/another.stl','another-midtoc-date');
  $lc_styl->load('midtoc-date/frame.stl','frame-midtoc-date');
  
  $lc_styl->load('main-lesson-group-display.stl','lcn-group-main');
  $lc_styl->load('main-lesson-display.stl','lcn-main');
  $lc_styl->load('main-lesson-placehold.stl','lcn-phold-main');
  
  $lc_styl->load('mainbd-date/each.stl','each-mainbd-date');
  $lc_styl->load('mainbd-date/another.stl','another-mainbd-date');
  $lc_styl->load('mainbd-date/frame.stl','frame-mainbd-date');
  
  $lc_styl->load('highlight/document-name.stl','highlight/docname');
  $lc_styl->load('highlight/emphasis.stl','highlight/emphasis');
  $lc_styl->load('highlight/vocabulary.stl','highlight/vocabulary');
  
  
  # UNSORTED STUFF
  
  
  $lc_styl->load('highlight/reference.stl','highlight/reference');
  
  $lc_styl->load('contain/expanded-text.stl','contain/expanded-text');
  $lc_styl->load('link/off-of-doc.stl','link/off-of-doc');
  
  
  if ( $lc_not_first < 5 )
  {
    foreach $lc_each (@excl_lis)
    {
      $lc_styl->load(('extx/cls-' . $excl_cod{$lc_each} . '.stl'),
          ('extx/cls-' . $excl_cod{$lc_each}),
          ('Extra Text for: ' . $excl_exp{$lc_each})
      );
    }
  }
  
  return $lc_styl;
}



1;
