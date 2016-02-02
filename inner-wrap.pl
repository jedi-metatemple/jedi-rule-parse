use strict;
use argola;
use chobxml02::context;
use me::keytag::root_sect;

my $cntx;

my $srcroot = undef;
my $strdate = undef;
my $repetia = 1;

sub opto__src_do {
  $srcroot = &argola::getrg();
} &argola::setopt('-src',\&opto__src_do);

sub opto__date_do {
  $strdate = [];
  @$strdate = (&argola::getrg());
  @$strdate = (@$strdate,&argola::getrg());
  @$strdate = (@$strdate,&argola::getrg());
} &argola::setopt('-date',\&opto__date_do);

sub opto__rep_do {
  $repetia = &argola::getrg();
} &argola::setopt('-rep',\&opto__rep_do);

&argola::runopts();

if ( !(defined($srcroot) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -src option to define the root source file.\n"
  ;
}

if ( !(defined($strdate) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -date option to define the cycle start-date.\n"
  ;
}

$cntx = &chobxml02::context::new();
$cntx->tag('sect',&me::keytag::root_sect::tags());
$cntx->parsefrom($srcroot);


