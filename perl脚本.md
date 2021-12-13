## 二倍体表达量过滤


```perl
#!/usr/bin/perl -w

use strict ;

my $file = shift ;
my $SampleNum = shift ;

my $index1 = sprintf("%.0f",$SampleNum*0.05) ;
# my $index2 = sprintf("%.0f",$SampleNum*0.95) ;

open IN,"<",$file ;
while (<IN>){
    chomp ;
    my @regions = split ;
    if ($regions[0] eq "GeneID"){
        print join("\t",@regions),"\n" ;
    }else{
        my $num = 0 ;
        my $FPKM = 0 ;
        for my $tmp (@regions[1..$#regions]){
            if ($tmp >=0.1){
                $num += 1 ;
                $FPKM += $tmp ;
            }
        }
        if ($num >=$index1 && $FPKM >= 10){
                print join("\t",@regions),"\n" ;
        }
    }
}
```