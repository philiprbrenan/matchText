#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/ -I/home/phil/perl/z/z/jordan/ -I.
#-------------------------------------------------------------------------------
# Answer some questions
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2021
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use MatchText qw(response);
use feature qw(say current_sub);

my $questions  = q(/home/phil/perl/z/z/jordan/questions.txt);                   # The questions
my $answers    = q(/home/phil/perl/z/z/jordan/answers.txt);                     # The answers
my $confidence = 0.50;                                                          # Confidence level

lll "Read questions";
my @q = map {trim $_} readFile $questions;                                      # Read questions

lll "Read answers";
my @t = readFile $answers;                                                      # Read answers
my @a;
my $person; my @speech;
for my $t(@t)                                                                   # Parse Hamlet
 {if ($t =~ m(\A\S))
   {if ($person)
     {#push @a, map{"$person $_"} @speech;
      push @a, map {trim $_}  @speech;
      @speech = ();
     }
    ($person) = split /\s+/, $t;
   }
  else
   {push @speech, $t;
   }
 }

lll "Match";
if (1)                                                                          # Print answers
 {my @t;
  for my $q(@q)
   {push @t, [$q, response($q, \@a)]
   }
  say formatTable(\@t, [qw(Question Response)]);
 }
