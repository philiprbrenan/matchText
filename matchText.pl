#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Answer some questions
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2021
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use Text::Match qw(response);
use feature qw(say current_sub);

my $questions  = q(questions.txt);                                              # The questions
my $answers    = q(answers.txt);                                                # The answers
my $confidence = 0.50;                                                          # Confidence level

lll "Read questions";
my @q = map {trim $_} readFile $questions;                                      # Read questions

lll "Read answers";
my @a = map {trim $_} readFile $answers;                                        # Read possible answers

lll "Match";
if (1)                                                                          # Print responses
 {my @t;
  for my $q(@q)
   {push @t, [$q, response($q, \@a)]
   }
  say formatTable(\@t, [qw(Question Response)]);
 }
