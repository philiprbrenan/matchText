#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/ -I/home/phil/perl/cpan/GitHubCrud/lib/
#-------------------------------------------------------------------------------
# Push MatchText to GitHub
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2020
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use GitHub::Crud qw(:all);
use YAML::Loader;
use feature qw(say current_sub);

my $home = q(/home/phil/perl/z/z/jordan/);                                      # Home folder
my $user = q(philiprbrenan);                                                    # User
my $repo = q(matchText);                                                        # Repo
my $wf   = q(.github/workflows/main.yml);                                       # Work flow

if (1)                                                                          # Upload
 {my @f = grep {!m(backup)i}
          searchDirectoryTreesForMatchingFiles($home);                          # Select files

  for my $f(@f)                                                                 # Upload each selected file
   {my $t = swapFilePrefix($f, $home);
    my $w = eval {writeFileUsingSavedToken($user, $repo, $t, readFile($f))};
    lll "$f $t $w";
   }
 }

my $y = <<END;                                                                  # Workflow to test each cpan module
# Test text matching

name: Test

on:
  push

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout\@v2

    - name: Install JSON
      run: |
        sudo cpan install -T JSON

    - name: Install Data::Table::Text
      run: |
        sudo cpan install -T Data::Table::Text

    - name: Install Digest::SHA1
      run: |
        sudo cpan install -T Digest::SHA1

    - name: Install GitHub Crud
      run: |
        sudo cpan install -T GitHub::Crud

    - name: Test
      run: |
        perl matchText.pl > output.txt
        cat output.txt

    - name: Upload results
      run: |
        perl -MGitHub::Crud -e "GitHub::Crud::writeFileFromFileFromCurrentRun q(output.txt)"
END

lll "Work flow: ", writeFileUsingSavedToken($user, $repo, $wf, $y);

