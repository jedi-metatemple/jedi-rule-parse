use strict;
use argola;
use chobxml02::context;
use me::keytag::root_sect;
use me::spcf::init_function;
use me::spcf::flush_function;
use me::stylish;
use me::language;
use me::ivrsn;
use me::globopt;

my $cntx;
my $opto;

my $srcroot = undef;
my $strdate = undef;
my $styledir = undef;
my $langdir = undef;
my $repetia = 0;

$opto = &me::globopt::refren();

$opto->{'styleswp'} = [];
$opto->{'extras'} = [];

sub opto__src_do {
  $srcroot = &argola::getrg();
} &argola::setopt('-src',\&opto__src_do);

sub opto__styl_do {
  $styledir = &argola::getrg();
} &argola::setopt('-styl',\&opto__styl_do);

sub opto__fcopt_do {
  $opto->{'fcopt'} = (2>1);
} &argola::setopt('-fcopt',\&opto__fcopt_do);
$opto->{'fcopt'} = (1>2);

sub opto__date_do {
  $strdate = [];
  @$strdate = (&argola::getrg());
  @$strdate = (@$strdate,&argola::getrg());
  @$strdate = (@$strdate,&argola::getrg());
} &argola::setopt('-date',\&opto__date_do);

sub opto__rep_do {
  $repetia = &argola::getrg();
} &argola::setopt('-rep',\&opto__rep_do);

sub opto__lang_do {
  $langdir = &argola::getrg();
} &argola::setopt('-lang',\&opto__lang_do);

sub opto__vrsn_do {
  &me::ivrsn::stable(&argola::getrg());
} &argola::setopt('-vrsn',\&opto__vrsn_do);

sub opto__exvrsn_do {
  &me::ivrsn::experim(&argola::getrg());
} &argola::setopt('-exvrsn',\&opto__exvrsn_do);

sub opto__repl_do {
  my $lc_prv;
  my $lc_neo;
  my $lc_swp;
  $lc_prv = &argola::getrg();
  $lc_neo = &argola::getrg();
  $lc_swp = $opto->{'styleswp'};
  @$lc_swp = (@$lc_swp, ['repl',$lc_prv,$lc_neo]);
} &argola::setopt('-repl',\&opto__repl_do);

sub opto__xtra_do {
  my $lc_prv;
  my $lc_neo;
  my $lc_swp;
  $lc_prv = &argola::getrg();
  $lc_neo = &argola::getrg();
  $lc_swp = $opto->{'extras'};
  @$lc_swp = (@$lc_swp, [$lc_prv,$lc_neo]);
} &argola::setopt('-xtra',\&opto__xtra_do);



&argola::runopts();

if ( !(defined($srcroot) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -src option to define the root source file.\n"
  ;
}

if ( !(defined($styledir) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -styl option to define the theme directory.\n"
  ;
}

if ( !(defined($langdir) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -lang option to define the language-resource directory.\n"
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
if ( $opto->{'fcopt'} )
{
  $cntx->tag('mfdldml',&me::keytag::root_sect::tags());
}
$cntx->initf(\&me::spcf::init_function::ftfunc);
$cntx->flush(\&me::spcf::flush_function::ftfunc);
$cntx->parsefrom($srcroot,{
  'style' => &me::stylish::load($styledir),
  'lang' => &me::language::load($langdir),
  'reps' => $repetia,
  'date' => $strdate,
  'title' => "Untitled Document",
  'ttlopen' => ( 2 > 1 ),
});


