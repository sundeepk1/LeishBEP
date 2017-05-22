###################################################################################
# Author: Saravanan Vijayakumar (brsaran@gmail.com)                               #
# Affiliation: CAS in Crystallography and Biophysics, University of Madras, India #
# Date:	18-05-2015								  #
###################################################################################

package      brsaran::DDE;
require      Exporter;

our @ISA       = qw(Exporter);
our @EXPORT    = qw(DDE generate_random_string Epi_Predict_pep);    # Symbols to be exported by default
our @EXPORT_OK = qw();  # Symbols to be exported on request
our $VERSION   = 1.00;         # Version number

### Include your variables and functions here
use strict;



sub DDE{		#Computes the Dipeptide Deviation from Mean
			#Usage DDE($sequence);

    my($param_one)= @_;
    $param_one = uc $param_one;
    my @SLC = qw(A C D E F G H I K L M N P Q R S T V W Y); #20 aminoacid single letter code
    my (@DSLC,$Dx,$Dy,$Di,@temp,$tz,$Dtz);

    foreach $Dx(@SLC){ #computing possible dipeptides (400)
        foreach $Dy(@SLC){
            $DSLC[$Di] = "$Dx$Dy";
            $Di++;
        }
    }
        
    my $Length_Prt = length($param_one)-1; #
    my ($i,$j);
    my (@nX,@pX,@Res_Codon_Occ,@piX,@Theo_Variance,@DDE_Value); 
#   Measure Calculation :
    
    foreach $Dtz(@DSLC){
                 if ($param_one =~/$Dtz/g){
                     $i = &occur($Dtz,$param_one);
		 }else{
		     $i=0; 	
		 }
	     if($Length_Prt <5){print "\nLength of peptide less than 6 is not acceptable ! Exiting !\n";exit;}
	     $pX[$j] = $i/$Length_Prt;	     	#Measure Calculation : px = nx/N	
	     $j++;
	     $i=0;
    }
    
    #Theoretical Mean Calculation: Codon Occurence
    @piX = qw(0.0042999194 0.0021499597 0.0021499597 0.0021499597 0.0021499597 0.0042999194 0.0021499597 0.0032249395 0.0021499597 0.0064498791 0.0010749798 0.0021499597 0.0042999194 0.0021499597 0.0064498791 0.0064498791 0.0042999194 0.0042999194 0.0010749798 0.0021499597 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0042999194 0.0021499597 0.0021499597 0.0021499597 0.0021499597 0.0042999194 0.0021499597 0.0032249395 0.0021499597 0.0064498791 0.0010749798 0.0021499597 0.0042999194 0.0021499597 0.0064498791 0.0064498791 0.0042999194 0.0042999194 0.0010749798 0.0021499597 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0032249395 0.0016124698 0.0016124698 0.0016124698 0.0016124698 0.0032249395 0.0016124698 0.0024187046 0.0016124698 0.0048374093 0.0008062349 0.0016124698 0.0032249395 0.0016124698 0.0048374093 0.0048374093 0.0032249395 0.0032249395 0.0008062349 0.0016124698 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0064498791 0.0032249395 0.0032249395 0.0032249395 0.0032249395 0.0064498791 0.0032249395 0.0048374093 0.0032249395 0.0096748186 0.0016124698 0.0032249395 0.0064498791 0.0032249395 0.0096748186 0.0096748186 0.0064498791 0.0064498791 0.0016124698 0.0032249395 0.0010749798 0.0005374899 0.0005374899 0.0005374899 0.0005374899 0.0010749798 0.0005374899 0.0008062349 0.0005374899 0.0016124698 0.000268745 0.0005374899 0.0010749798 0.0005374899 0.0016124698 0.0016124698 0.0010749798 0.0010749798 0.000268745 0.0005374899 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0042999194 0.0021499597 0.0021499597 0.0021499597 0.0021499597 0.0042999194 0.0021499597 0.0032249395 0.0021499597 0.0064498791 0.0010749798 0.0021499597 0.0042999194 0.0021499597 0.0064498791 0.0064498791 0.0042999194 0.0042999194 0.0010749798 0.0021499597 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798 0.0064498791 0.0032249395 0.0032249395 0.0032249395 0.0032249395 0.0064498791 0.0032249395 0.0048374093 0.0032249395 0.0096748186 0.0016124698 0.0032249395 0.0064498791 0.0032249395 0.0096748186 0.0096748186 0.0064498791 0.0064498791 0.0016124698 0.0032249395 0.0064498791 0.0032249395 0.0032249395 0.0032249395 0.0032249395 0.0064498791 0.0032249395 0.0048374093 0.0032249395 0.0096748186 0.0016124698 0.0032249395 0.0064498791 0.0032249395 0.0096748186 0.0096748186 0.0064498791 0.0064498791 0.0016124698 0.0032249395 0.0042999194 0.0021499597 0.0021499597 0.0021499597 0.0021499597 0.0042999194 0.0021499597 0.0032249395 0.0021499597 0.0064498791 0.0010749798 0.0021499597 0.0042999194 0.0021499597 0.0064498791 0.0064498791 0.0042999194 0.0042999194 0.0010749798 0.0021499597 0.0042999194 0.0021499597 0.0021499597 0.0021499597 0.0021499597 0.0042999194 0.0021499597 0.0032249395 0.0021499597 0.0064498791 0.0010749798 0.0021499597 0.0042999194 0.0021499597 0.0064498791 0.0064498791 0.0042999194 0.0042999194 0.0010749798 0.0021499597 0.0010749798 0.0005374899 0.0005374899 0.0005374899 0.0005374899 0.0010749798 0.0005374899 0.0008062349 0.0005374899 0.0016124698 0.000268745 0.0005374899 0.0010749798 0.0005374899 0.0016124698 0.0016124698 0.0010749798 0.0010749798 0.000268745 0.0005374899 0.0021499597 0.0010749798 0.0010749798 0.0010749798 0.0010749798 0.0021499597 0.0010749798 0.0016124698 0.0010749798 0.0032249395 0.0005374899 0.0010749798 0.0021499597 0.0010749798 0.0032249395 0.0032249395 0.0021499597 0.0021499597 0.0005374899 0.0010749798);
    #Theoretical variance Calculation
    for($i=0;$i<400;$i++){
              $Theo_Variance[$i] = ($piX[$i]*(1-$piX[$i]))/$Length_Prt;
    }
    #DDE Calculation
    for($i=0;$i<400;$i++){
        eval{($pX[$i] - $piX[$i])/(sqrt($Theo_Variance[$i]));};
        if($@){
              $DDE_Value[$i] = 0.00;
        }else{
              $DDE_Value[$i] = ($pX[$i] - $piX[$i])/(sqrt($Theo_Variance[$i]));
        }

    }
    my $vector = join(",",@DDE_Value);
    return $vector;
}

sub occur { #Computes occurence of Dipeptides

    my( $x, $y ) = @_;

    my $pos = 0;
    my $matches = 0;

    while (1) {
        $pos = index($y, $x, $pos);
        last if($pos < 0);
        $matches++;
        $pos++;
    }   

    return $matches;
}
#Random File name generator
sub generate_random_string
{
        my $length_of_randomstring=shift;# the length of
                 # the random string to generate

        my @chars=('a'..'z','A'..'Z','0'..'9');
        my $random_string;
        foreach (1..$length_of_randomstring)
        {
                # rand @chars will generate a random
                # number between 0 and scalar @chars
                $random_string.=$chars[rand @chars];
        }
        return $random_string;
}
sub Epi_Predict_pep{ #Routine for making prediciton using model generated in WEKA
	my ($Arff_file) = $_[0];
	my ($path) = $_[1];
	my ($Model_sel) = $_[2];
	my $mod_path;
	if($Model_sel eq 'B'){ $mod_path = $path.'model/BALANCED.model';}
	my $t;
	$t = `java -cp $path./weka.jar weka.classifiers.trees.RandomForest -T $Arff_file -l $mod_path -p 0`;
	return $t;
}
1;