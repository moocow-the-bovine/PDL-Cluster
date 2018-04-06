#!/usr/bin/perl -w

use lib qw(./blib/lib ./blib/arch);
use PDL;
use PDL::Cluster;
#use Benchmark qw(cmpthese timethese);

##-------------------------------------------------------
## version
sub test_version {
  print STDERR "PDL::Cluster::VERSION=$PDL::Cluster::VERSION (library_version=".PDL::Cluster::library_version.")\n";
}
#test_version; exit 0;

##-------------------------------------------------------
## calculate_weights
sub test_calc_weights {
  my $data = sequence(3,4);
  my $mask = $data->ones;
  my $weight = ones($data->dim(0));
  my $cutoff = 42;
  my $exp    = 2;
  my $oweights = $weight->zeroes;
  calculate_weights($data,$mask,$weight,$cutoff,$exp, $oweights, 'v');
  print "calc_weights = $oweights\n";
}
#test_calc_weights; exit 0;

##-------------------------------------------------------
## test tree

our ($data,$mask,$weight,$d,$n,$k, $dist,$method,$lnkdist,$cdmethod, $cids,$tree);
sub testtree {
  $weight = pdl double, [ 1,1,1 ];
  $data   = pdl double, [
			 [ 1,1,1, ],
			 [ 2,2,2, ],
			 [ 3,4,5, ],
			 [ 7,8,9, ],
			];
  $mask = pdl long, [
		     [ 1, 1, 1, ],
		     [ 1, 1, 1, ],
		     [ 1, 1, 1, ],
		     [ 1, 1, 1, ],
		    ];

  ($d,$n) = $data->dims;
  $k = 2;

  treecluster($data,$mask,$weight,
	      $tree=zeroes(long,2,$n),$lnkdist=zeroes(double,$n),
	      $dist='b',$method='m');
  $cdmethod = 'x';

  cuttree($tree, $k, $cids=zeroes(long,$n));
  print "nc=$k ; tree=$tree\n";
  exit 0;
}
testtree();



##-------------------------------------------------------
## main
foreach $i (0..10) {
  print "--dummy($i)--\n";
}

